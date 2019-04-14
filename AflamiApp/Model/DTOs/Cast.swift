//
//  Cast.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/14/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import Foundation

public class Cast: NSObject, NSCoding{
    
    var id : String?
    var character : String?
    var name : String?
    var profilePath : String?
    var image : Data?
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(id, forKey: "id")
        aCoder.encode(character, forKey: "character")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(profilePath, forKey: "profilePath")
        aCoder.encode(image, forKey: "image")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        character = aDecoder.decodeObject(forKey: "character") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        profilePath = aDecoder.decodeObject(forKey: "profilePath") as? String ?? ""
        image = aDecoder.decodeObject(forKey: "image") as? Data
    }
    
    override init() {
        super.init()
    }
}
