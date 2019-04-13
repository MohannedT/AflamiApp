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
    
    // MARK: - Properties
    let modelLayer : ModelLayer = ModelLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var moviesList : Array<Movie> = []
    var sortType = SortType.Popularity
    
    // MARK: - Constants
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
        
        actionSheet.addAction(UIAlertAction.init(title: "Popularity\((sortType == .Popularity ? " (Selected)" : ""))", style: UIAlertActionStyle.default, handler: { (action) in
            if self.sortType != .Popularity{
                self.changeSortType(newSortType: .Popularity)
            }
        }))
        
        actionSheet.addAction(UIAlertAction.init(title: "Top Rated\((sortType == .TopRated ? " (Selected)" : ""))", style: UIAlertActionStyle.default, handler: { (action) in
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
    
    // MARK: - Swipe left to Favorites
    @IBAction func didSwipeLeft(_ sender: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 1
    }
}
