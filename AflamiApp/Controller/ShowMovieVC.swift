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
    @IBOutlet weak var trailersTableView: UITableView!
    @IBOutlet weak var rateView: CosmosView!
    var favButton: UIButton?
    
    // MARK: - Properties
    let modelLayer : ModelLayer = ModelLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var movie : Movie?
    
    // MARK: - Constants
    var OFFLINE_MODE = false
    let TRAILERS_CELL_ID : String = "trailersCell"
    let REVIEWS_CELL_ID : String = "reviewsCell"
    let CORNER_RADIUS : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fillMovieData()
        getTrailers()
        getReviews()
        
        trailersTableView.rowHeight = UITableViewAutomaticDimension
        
        // Edit items corner radius
        labelReleaseDate.layer.masksToBounds = true
        labelReleaseDate.layer.cornerRadius = CORNER_RADIUS
        
        labelOriginalLanguage.layer.cornerRadius = CORNER_RADIUS
        labelOriginalLanguage.layer.masksToBounds = true
        
        imagePosterImage.layer.cornerRadius = CORNER_RADIUS
        imagePosterImage.layer.masksToBounds = true

        //create a favourite button
        favButton = UIButton(type: UIButtonType.custom)
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
    }
    
    func changeFavIconColor(){
        if (modelLayer.isMovieExistsInCoreData(id: (movie?.id)!)){ // Movie exist in database
            favButton?.setImage(UIImage(named: "like-1.png"), for: UIControlState.normal)
        } else { // Movie doesn't exist in database
            favButton?.setImage(UIImage(named: "like-0.png"), for: UIControlState.normal)
        }
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

// MARK: - trailers table
extension ShowMovieVC : UITableViewDataSource, UITableViewDelegate{
    
    // MARK: - Trailers section name
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sectionName: String
        switch section {
        case 0:
            sectionName = NSLocalizedString("Trailers", comment: "Trailers Section")
        default:
            sectionName = ""
        }
        return sectionName
    }
    
    // MARK: - Open trailer video
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        modelLayer.openTrailerLink(key: (movie?.trailers[indexPath.row].key)!)
    }
    
    // MARK: - Trailers sections number
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // MARK: - No of trailers
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return movie?.trailers.count ?? 0
    }
    
    // MARK: - Trailers cells
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: TRAILERS_CELL_ID, for: indexPath) as! ShowMovieTrailersCell
        
        let site : String = movie?.trailers[indexPath.row].site ?? ""
        let size : Int = movie?.trailers[indexPath.row].size ?? 0
        
        cell.labelName?.text = movie?.trailers[indexPath.row].name ?? ""
        cell.labelDescription?.text = "\(site), \(size)p"
        
        return cell
        
    }
    
}


// MARK: - reviews collection view
extension ShowMovieVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return (movie?.reviews.count)!
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: REVIEWS_CELL_ID, for: indexPath) as! ShowMovieReviewsCell
        
        cell.author.text = movie?.reviews[indexPath.row].author ?? ""
        cell.content.text = movie?.reviews[indexPath.row].content ?? ""
        let imageName = (movie?.reviews[indexPath.row].image)!
        cell.image.image = UIImage(named: (!imageName.isEmpty) ? imageName : "user-1.png")
        
        return cell
    }

    
}

