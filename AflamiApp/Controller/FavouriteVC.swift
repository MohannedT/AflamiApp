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
    
    // MARK: - Data
    let modelLayer : ModelLayer = ModelLayer(appDelegate: UIApplication.shared.delegate as! AppDelegate)
    var moviesList : Array<Movie> = []
    
    // MARK: - Constants
    var sortType = SortType.Popularity
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

}


// MARK: - Collection view
extension FavouriteVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_IDENTIFIER, for: indexPath) as! FavouriteCollectionViewCell
        
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
        }
        
        return cell
        
    }
    
}
