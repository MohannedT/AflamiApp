//
//  Movie.swift
//  aflami
//
//  Created by Ahmed M. Hassan on 7/22/1440 AH.
//  Copyright © 1440 AH jets. All rights reserved.
//

import Foundation

class Movie{
    
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
    
}
