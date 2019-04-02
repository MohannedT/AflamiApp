import Foundation
import UIKit

class ModelLayer{
    
    let apiKey = "e91d155831d8f6a5c7089243d189285b"
    let networkLayer : NetworkLayer = NetworkLayer()
    
    
    //MARK: - Get all movies
    func getMoviesList (completionHandler : @escaping (Array<Movie>?, Error?) -> Void){
        var movieslist : Array<Movie> = []
        let url : String = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=\(apiKey)"
        
        networkLayer.executeNetwordRequest(url: url) { (value, error) in
            if let result = value {
                let moviesArray = result["results"] as! Array<[String : Any]>
                for item in moviesArray{
                    
                    let movie = Movie()
                    movie.id = item["id"] as! Int
                    movie.posterPath = item["poster_path"] as! String
                    movie.releaseDate = item["release_date"] as! String
                    movie.title = item["original_title"] as! String
                    movie.voteAverage = item["vote_average"] as! Double
                    movie.originalLanguage = item["original_language"] as! String
                    
                    movieslist.append(movie)
                    print("\(movie.id)  \(movie.title)  \(movieslist.count)")
                }
                
                completionHandler(movieslist, nil)
                
            } else {
                
                completionHandler(nil, error)
                
            }
        }
    }
    
    
    //MARK - Get movie thumbnail
    func getMovieThumbnail(movie : Movie, completionHandler : @escaping (UIImage?) -> Void){
        
        networkLayer.getImageUsingPosterPath(posterPath: movie.posterPath) { (data, error) in
            if let imageData = data{
                movie.image = imageData
                // Convert that Data into an image and do what you wish with it.
                let image = UIImage(data: imageData)
                completionHandler(image)
            } else {
                print(error.debugDescription)
            }
        }
        
    }
    
    
}
