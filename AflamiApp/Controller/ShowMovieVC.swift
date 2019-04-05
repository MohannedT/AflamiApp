//
//  ShowMovieVC.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/5/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class ShowMovieVC: UIViewController {
    
    var movie : Movie?

    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var imagePosterImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(movie?.title ?? "")
        labelReleaseDate.text = movie?.releaseDate
        imagePosterImage.image = UIImage(data: (movie?.image)!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
