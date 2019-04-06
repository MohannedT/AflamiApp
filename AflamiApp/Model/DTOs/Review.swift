//
//  Review.swift
//  aflami
//
//  Created by Ahmed M. Hassan on 7/23/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation

public class Review : NSObject, NSCoding{
    
    var id : String = ""
    var author : String = ""
    var content : String = ""
    var image : String = ""
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(id, forKey: "id")
        aCoder.encode(author, forKey: "author")
        aCoder.encode(content, forKey: "content")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? String ?? ""
        author = aDecoder.decodeObject(forKey: "author") as? String ?? ""
        content = aDecoder.decodeObject(forKey: "content") as? String ?? ""
    }
    
    override init() {
       super.init()
    }
}
