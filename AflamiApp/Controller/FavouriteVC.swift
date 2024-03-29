//
//  FavouriteVC.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/6/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class FavouriteVC: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Constants
    let modelLayer : ModelLayer = ModelLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var moviesList : Array<Movie> = []
    var sortType = SortType.Popularity
    
    // MARK: - Constants
    let CORNER_RADIUS : CGFloat = 10
    let CELL_IDENTIFIER : String = "favCell"
    let DETAILS_VIEW_ID : String = "showMovie"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        moviesList = modelLayer.getMoviesListFromCoreData(listType: .Shortlist)
        collectionView.reloadData()
        super.viewWillAppear(animated)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier!{
        case DETAILS_VIEW_ID:
            if let showMovieVC = segue.destination as? ShowMovieVC{
                let indexPath = self.collectionView.indexPathsForSelectedItems?[0]
                showMovieVC.OFFLINE_MODE = true
                showMovieVC.movie = moviesList[(indexPath?.row)!]
            }
            
        default:
            print("")
        }
    }
    
    // MARK: - Swipe right to Home
    @IBAction func didSwipeRight(_ sender: UISwipeGestureRecognizer) {
        self.tabBarController?.selectedIndex = 0
    }

}
