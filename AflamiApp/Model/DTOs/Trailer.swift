//
//  Trailer.swift
//  aflami
//
//  Created by Ahmed M. Hassan on 7/23/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation

public class Trailer : NSObject, NSCoding{
    
    var key : String?
    var name : String?
    var site : String?
    var size : Int?
    var type : String?
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(key, forKey: "key")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(site, forKey: "site")
        aCoder.encode(size, forKey: "size")
        aCoder.encode(type, forKey: "type")
    }
    
    required public init?(coder aDecoder: NSCoder) {
        key = aDecoder.decodeObject(forKey: "key") as? String ?? ""
        name = aDecoder.decodeObject(forKey: "name") as? String ?? ""
        site = aDecoder.decodeObject(forKey: "site") as? String ?? ""
        size = aDecoder.decodeObject(forKey: "size") as? Int ?? 0
        type = aDecoder.decodeObject(forKey: "type") as? String ?? ""
    }
    
    override init() {
        super.init()
    }
}
