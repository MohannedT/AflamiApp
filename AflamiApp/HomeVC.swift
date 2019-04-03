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
    let modelLayer : ModelLayer = ModelLayer()
    var moviesList : Array<Movie> = []
    
    //MARK: - Setting grid view
    public var customCollectionViewLayout: UICustomCollectionViewLayout? {
        get {
            return collectionView as? UICustomCollectionViewLayout
        }
        set {
            if newValue != nil {
                self.collectionView?.collectionViewLayout = newValue!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customCollectionViewLayout?.delegate = self
        self.customCollectionViewLayout?.numberOfColumns = 2
        //self.customCollectionViewLayout?.cellPadding = 30
        
        //navigationController?.navigationBar.prefersLargeTitles = true
        
        self.modelLayer.getMoviesList(completionHandler: { (value, error) in
            if let result = value {
                DispatchQueue.main.async {
                    self.moviesList = result
                    self.collectionView.reloadData()
                }
                
            } else {
                print("Connection Error!")
            }
        })
    }
    
    
}

// MARK: - Flow layout delegate
extension HomeVC : CustomLayoutDelegate{
    
    struct Model {
        var index: Int
        var isBig: Bool
    }
    
    func collectionView(_ collectionView: UICollectionView, heightForItemAt indexPath: IndexPath, with width: CGFloat) -> CGFloat {

        //        let heightSizes = [100,216]
        return CGFloat(UIImage(data: moviesList[indexPath.row].image!)!.size.height)
    }
    
}

// MARK: - Data Source
extension HomeVC : UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return moviesList.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCell
        
        //cell.textLabel?.text = moviesList[indexPath.row].title
        if let image = moviesList[indexPath.row].image {
            cell.imageView?.image = UIImage(data: image)
        } else {
            self.modelLayer.getMovieThumbnail(movie: (moviesList[indexPath.row]), completionHandler: { (image) in
                cell.imageView?.image = image
            })
        }
        
        return cell
        
    }
        
}

