//
//  HomeVC-CollectionView.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/12/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

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

