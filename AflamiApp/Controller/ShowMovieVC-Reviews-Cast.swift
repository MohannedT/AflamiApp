//
//  ShowMovieVC-ReviewsCollectionView.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/12/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

// MARK: - Collection views (Reviews - Cast)
extension ShowMovieVC : UICollectionViewDataSource, UICollectionViewDelegate{
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        if collectionView == reviewsCollectionView{
            return (movie?.reviews.count)!
        } else {
            return (movie?.cast.count) ?? 0
        }
        
        
    }
    
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        
        // Reviews collectionview
        if collectionView == reviewsCollectionView{
            let cell = reviewsCollectionView.dequeueReusableCell(withReuseIdentifier: REVIEWS_CELL_ID, for: indexPath) as! ShowMovieReviewsCell
            
            cell.author.text = movie?.reviews[indexPath.row].author ?? ""
            cell.content.text = movie?.reviews[indexPath.row].content ?? ""
            let imageName = (movie?.reviews[indexPath.row].image)!
            cell.image.image = UIImage(named: (!imageName.isEmpty) ? imageName : "user-1.png")
            
            return cell
            
        // Cast CollectionView
        } else {
            let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: CAST_CELL_ID, for: indexPath) as! ShowMovieCastCell
            
            cell.castName.text = movie?.cast[indexPath.row].name ?? ""
            cell.castCharacter.text = movie?.cast[indexPath.row].character ?? ""
            
            // Set cast image
            if let image = movie?.cast[indexPath.row].image {
                cell.castImage?.image = UIImage(data: image)
            } else {
                cell.castImage.image = UIImage(named: "user-1.png")
                self.modelLayer.getCastImage(cast: (movie?.cast[indexPath.row])!, completionHandler: { (image) in
                    DispatchQueue.main.async {
                        cell.castImage?.image = image
                    }
                })
            }
            return cell
        }
        
        
    }
}
