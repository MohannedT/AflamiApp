//
//  CustomFavButton.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/12/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import UIKit

class CustomFavButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.addTarget(self, action: #selector(selectionAnimation), for: .touchUpInside)
    }
    
    func selectionAnimation(){
        self.center.y += 20
        self.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        self.alpha = 0.5
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: [], animations: {
            
            self.center.y -= 20
            self.transform = CGAffineTransform.identity
            self.alpha = 1
            
            
        }, completion: { (bool) in
            
        })
    }


}
