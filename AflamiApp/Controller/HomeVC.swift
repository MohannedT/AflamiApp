//
//  ViewController.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/2/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Data
    let modelLayer : ModelLayer = ModelLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var moviesList : Array<Movie> = []
    
    // MARK: - Constants
    var sortType = SortType.Popularity
    let CORNER_RADIUS : CGFloat = 10
    let CELL_IDENTIFIER : String = "homeCell"
    let DETAILS_VIEW_ID : String = "showMovie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        fillMoviesList(sortType: .Popularity)
        
    }
    
    // MARK: - Get movies list
    func fillMoviesList(sortType : SortType){
        self.modelLayer.getMoviesList(sortType: sortType, completionHandler: { (value, error) in
            if let result = value {
                DispatchQueue.main.async {
                    for item in result{
                        self.moviesList.append(item)
                    }
                    self.collectionView.reloadData()
                    self.sortType = sortType
                }
                
            } else {
                print("Connection Error!")
            }
        })
    }
    
    func changeSortType(newSortType : SortType){
        self.moviesList.removeAll()
        modelLayer.resetPageNumber()
        collectionView.reloadData()
        fillMoviesList(sortType: newSortType)
    }
    
    // MARK: - Change sort type of movies by popularity or top rated
    @IBAction func sortMovies(_ sender: Any) {
        
        let actionSheet = UIAlertController.init(title: "Choose prefered sorting type", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction.init(title: "Popularity", style: UIAlertActionStyle.default, handler: { (action) in
            if self.sortType != .Popularity{
                self.changeSortType(newSortType: .Popularity)
            }
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Top Rated", style: UIAlertActionStyle.default, handler: { (action) in
            if self.sortType != .TopRated{
                self.changeSortType(newSortType: .TopRated)
            }
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            //If you tap outside the UIAlertController action buttons area, then also this handler gets called.
        }))
        
        //Present the controller
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier!{
        case DETAILS_VIEW_ID:
            if let showMovieVC = segue.destination as? ShowMovieVC{
                let indexPath = self.collectionView.indexPathsForSelectedItems?[0]
                showMovieVC.movie = moviesList[(indexPath?.row)!]
            }
            
        default:
            print("")
        }
    }
}


// MARK: - Collection view
extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesList.count
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                
        // Fetch new items to the array
        if indexPath.row == (moviesList.count - 1) {
            fillMoviesList(sortType: sortType)
            print("Get new movies")
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! HomeCollectionViewCell
        
        // Set movie name
        cell.movieNameLabel?.text = moviesList[indexPath.row].title
        cell.movieNameLabel.layer.masksToBounds = true
        cell.movieNameLabel.layer.cornerRadius = CORNER_RADIUS
        cell.movieNameLabel.sizeToFit()
        
        // Set movie image
        cell.imageView.layer.cornerRadius = CORNER_RADIUS
        cell.imageView.layer.masksToBounds = true
        if let image = moviesList[indexPath.row].image {
            cell.imageView?.image = UIImage(data: image)
        } else {
            cell.imageView.image = UIImage(named: "placeholder.png")
            self.modelLayer.getMovieThumbnail(movie: (moviesList[indexPath.row]), completionHandler: { (image) in
                cell.imageView?.image = image
            })
        }
        
        return cell
        
    }
    
}

enum SortType{
    case Popularity
    case TopRated
}

