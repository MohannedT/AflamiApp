//
//  APIEnums.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/7/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import Foundation

enum SortType : String{
    case Popularity = "popularity"
    case TopRated = "vote_count"
}

enum APIMovie : String{
    case id = "id"
    case posterPath  = "poster_path"
    case releaseDate = "release_date"
    case title = "original_title"
    case voteAverage = "vote_average"
    case originalLanguage = "original_language"
    case overview = "overview"
    case results = "results"
}

enum APITrailer : String{
    case key = "key"
    case name = "name"
    case site = "site"
    case size = "size"
    case type = "type"
}

enum APIReview : String{
    case id = "id"
    case author = "author"
    case content = "content"
}

enum APICast : String{
    case id = "id"
    case character = "character"
    case name = "name"
    case profilePath = "profile_path"
}

enum APIImageSize : String{
    case w185 = "w185"
    case face66x66 = "w66_and_h66_face"
}
