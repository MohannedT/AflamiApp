//
//  File.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/6/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import Foundation

public class Movie{
    
    var id : Int = 0
    var voteAverage : Double = 0.0
    var posterPath : String = ""
    var title : String = ""
    var overview : String = ""
    var releaseDate : String = ""
    var originalLanguage : String = ""
    var image : Data?
    var trailers : Array<Trailer> = []
    var reviews : Array<Review> = []
    var cast : Array<Cast> = []
    
}
