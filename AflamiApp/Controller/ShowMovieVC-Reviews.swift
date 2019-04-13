//
//  ShowMovieVC-ReviewsCollectionView.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/12/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

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
