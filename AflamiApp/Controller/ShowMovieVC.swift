//
//  ShowMovieVC.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/5/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit
import Cosmos

class ShowMovieVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelOriginalLanguage: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imagePosterImage: UIImageView!
    @IBOutlet weak var reviewsCollectionView: UICollectionView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var trailersTableView: UITableView!
    @IBOutlet weak var rateView: CosmosView!
    var favButton: CustomFavButton?
    
    // MARK: - Properties
    let modelLayer : ModelLayer = ModelLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var movie : Movie?
    
    // MARK: - Constants
    var OFFLINE_MODE = false
    let TRAILERS_CELL_ID : String = "trailersCell"
    let REVIEWS_CELL_ID : String = "reviewsCell"
    let CAST_CELL_ID : String = "castCell"
    let CORNER_RADIUS : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillMovieData()
        getTrailers()
        getReviews()
        getCast()
        
        trailersTableView.rowHeight = UITableViewAutomaticDimension
        
        // Edit items corner radius
        labelReleaseDate.layer.masksToBounds = true
        labelReleaseDate.layer.cornerRadius = CORNER_RADIUS
        
        labelOriginalLanguage.layer.cornerRadius = CORNER_RADIUS
        labelOriginalLanguage.layer.masksToBounds = true
        
        imagePosterImage.layer.cornerRadius = CORNER_RADIUS
        imagePosterImage.layer.masksToBounds = true

        //create a favourite button
//        favButton = UIButton(type: UIButtonType.custom)
        favButton = CustomFavButton()
        favButton?.setImage(UIImage(named: "like-0.png"), for: UIControlState.normal)
        favButton?.addTarget(self, action: #selector(ShowMovieVC.favouriteButtonTapped), for: UIControlEvents.touchUpInside)
        favButton?.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        
        //assign button to navigationbar
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: favButton!)
        
        // Change the cosmos view rating
        rateView.rating = (movie?.voteAverage)!/2
        
        // Change the text
        rateView.text = "\((movie?.voteAverage)!)"
        
        changeFavIconColor()
        
    }
    
    func favouriteButtonTapped(){
        if (modelLayer.isMovieExistsInCoreData(id: (movie?.id)!)){ // Movie exist in database
            if modelLayer.deleteMovieFromCoreData(id: (movie?.id)!) {
                changeFavIconColor()
            }
        } else {
            if modelLayer.insertMovieToCoreData(movie: self.movie!){
                changeFavIconColor()
            }
        }
        animateFavIcon()
    }
    
    func changeFavIconColor(){
        if (modelLayer.isMovieExistsInCoreData(id: (movie?.id)!)){ // Movie exist in database
            favButton?.setImage(UIImage(named: "like-1.png"), for: UIControlState.normal)
        } else { // Movie doesn't exist in database
            favButton?.setImage(UIImage(named: "like-0.png"), for: UIControlState.normal)
        }
    }
    
    // MARK: - Fav icon animation
    func animateFavIcon(){
        self.favButton?.center.y += 10
        self.favButton?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.favButton?.alpha = 0.5
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            
            self.favButton?.center.y -= 10
            self.favButton?.transform = CGAffineTransform.identity
            self.favButton?.alpha = 1
            
            
        }, completion: nil)
    }

    // MARK: - Fill UI items with movie data
    func fillMovieData(){
        if (OFFLINE_MODE){
            self.movie = modelLayer.getMovieDataById(id: (movie?.id)!)
        }
        labelReleaseDate.text = "  \((movie?.releaseDate) ?? "")  "
        labelOriginalLanguage.text = "  \((movie?.originalLanguage) ?? "")  "
        labelOverview.text = movie?.overview
        labelTitle.text = movie?.title
        imagePosterImage.image = UIImage(data: (movie?.image)!)
    }
    
    func getCast(){
        if (!OFFLINE_MODE || movie?.trailers.count == 0){
            modelLayer.getCast(movieId: (movie?.id)!) { (cast, error) in
                self.movie?.cast = cast ?? []
                self.castCollectionView.reloadData()
            }
        }
    }
    
    func getTrailers(){
        if (!OFFLINE_MODE || movie?.trailers.count == 0){
            modelLayer.getTrailers(movieId: (movie?.id)!) { (trailers, error) in
                self.movie?.trailers = trailers ?? []
                self.trailersTableView.reloadData()
            }
        }
    }
    
    func getReviews(){
        if (!OFFLINE_MODE || movie?.reviews.count == 0){
            modelLayer.getReviews(movieId: (movie?.id)!) { (reviews, error) in
                self.movie?.reviews = reviews ?? []
                // Set reviews image
                for item in (self.movie?.reviews)!{
                    item.image = "user-\(String(arc4random_uniform(4)))"
                }
                self.reviewsCollectionView.reloadData()
            }
        }
    }

}
