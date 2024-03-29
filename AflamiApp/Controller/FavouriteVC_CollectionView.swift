//
//  FavouriteVC_CollectionView.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/12/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

// MARK: - Collection view
extension FavouriteVC : UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
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
    
    
    // Set one cell per row
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (self.view.frame.size.width - 10 * 2) //some width
        let height = width / 3 //ratio
        return CGSize(width: width, height: height)
    }
    
}

