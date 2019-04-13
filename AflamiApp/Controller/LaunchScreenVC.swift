//
//  LaunchScreenVC.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/11/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class LaunchScreenVC: UIViewController {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var appName: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        image.alpha = 0
        appName.alpha = 0
    }
    
}
