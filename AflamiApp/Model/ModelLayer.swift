import Foundation
import UIKit

class ModelLayer{
    
    let apiKey = "e91d155831d8f6a5c7089243d189285b"
    let networkLayer : NetworkLayer = NetworkLayer()
    let dataLayer : DataLayer?
    var appDelegate : AppDelegate?
    
    init(appDelegate : AppDelegate) {
        dataLayer = DataLayer(appDelegate: appDelegate)
    }
        
    //MARK: - Get all movies
    func getMoviesList (sortType : SortType, completionHandler : @escaping (Array<Movie>?, Error?) -> Void){
        turnNetwokIndicatorOn()
        var movieslist : Array<Movie> = []
        var url : String?
        
        switch sortType{
        case .Popularity:
            url = "https://api.themoviedb.org/3/discover/movie?sort_by=popularity.desc&api_key=\(apiKey)"
        case .TopRated:
            url = "https://api.themoviedb.org/3/discover/movie?sort_by=vote_count.desc&api_key=\(apiKey)"
        }
        
        networkLayer.executeNetwordRequest(url: url!) { (value, error) in
            if let result = value {
                let moviesArray = result["results"] as! Array<[String : Any]>
                for item in moviesArray{
                    
                    let movie = Movie()
                    movie.id = item["id"] as? Int ?? 0
                    movie.posterPath = item["poster_path"] as? String ?? ""
                    movie.releaseDate = item["release_date"] as? String ?? ""
                    movie.title = item["original_title"] as? String ?? ""
                    movie.voteAverage = item["vote_average"] as? Double ?? 0
                    movie.originalLanguage = item["original_language"] as? String ?? ""
                    movie.overview = item["overview"] as? String ?? ""
                    
                    movieslist.append(movie)
                }
                
                self.turnNetwokIndicatorOff()
                completionHandler(movieslist, nil)
                
            } else {
                
                self.turnNetwokIndicatorOff()
                completionHandler(nil, error)
                
            }
        }
    }
    
    
    //MARK - Get movie thumbnail
    func getMovieThumbnail(movie : Movie, completionHandler : @escaping (UIImage?) -> Void){
        
        self.turnNetwokIndicatorOn()
        networkLayer.getImageUsingPosterPath(posterPath: movie.posterPath) { (data, error) in
            if let imageData = data{
                movie.image = imageData
                // Convert that Data into an image and do what you wish with it.
                let image = UIImage(data: imageData)
                self.turnNetwokIndicatorOff()
                completionHandler(image)
            } else {
                self.turnNetwokIndicatorOff()
                print(error.debugDescription)
            }
        }
        
    }
    
    
    //MARK: - Get all trailers using movie id
    func getTrailers (movieId : Int, completionHandler : @escaping (Array<Trailer>?, Error?) -> Void){
        
        self.turnNetwokIndicatorOn()
        var trailerslist : Array<Trailer> = []
        let url : String = "https://api.themoviedb.org/3/movie/\(movieId)/videos?api_key=\(apiKey)"
        
        networkLayer.executeNetwordRequest(url: url) { (value, error) in
            if let result = value {
                let trailersArray = result["results"] as! Array<[String : Any]>
                for item in trailersArray{
                    
                    let trailer = Trailer()
                    trailer.key = item["key"] as? String ?? ""
                    trailer.name = item["name"] as? String ?? ""
                    trailer.site = item["site"] as? String ?? ""
                    trailer.size = item["size"] as? Int ?? 0
                    trailer.type = item["type"] as? String ?? ""
                    
                    trailerslist.append(trailer)
                }
                
                self.turnNetwokIndicatorOff()
                completionHandler(trailerslist, nil)
                
            } else {
                
                self.turnNetwokIndicatorOff()
                completionHandler(nil, error)
                
            }
        }
    }
    
    
    //MARK: - Get all reviews using movie id
    func getReviews (movieId : Int, completionHandler : @escaping (Array<Review>?, Error?) -> Void){
        
        self.turnNetwokIndicatorOn()
        var reviewslist : Array<Review> = []
        let url : String = "https://api.themoviedb.org/3/movie/\(movieId)/reviews?api_key=\(apiKey)"
        
        networkLayer.executeNetwordRequest(url: url) { (value, error) in
            if let result = value {
                let reviewsArray = result["results"] as! Array<[String : Any]>
                for item in reviewsArray{
                    
                    let review = Review()
                    review.id = item["id"] as? String ?? ""
                    review.author = item["author"] as? String ?? ""
                    review.content = item["content"] as? String ?? ""
                    
                    reviewslist.append(review)
                }
                
                self.turnNetwokIndicatorOff()
                completionHandler(reviewslist, nil)
                
            } else {
                
                self.turnNetwokIndicatorOff()
                completionHandler(nil, error)
                
            }
        }
    }
    
    // MARK: - Open trailer link using movie id
    func openTrailerLink(key : String){
        if let url = URL(string: "http://youtube.com/watch?v=\(key)") {
            UIApplication.shared.open(url, options: [:])
        }
    }
    
    // MARK: - Turn network indicaor On
    func turnNetwokIndicatorOn(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    // MARK: - Turn network indicaor Off
    func turnNetwokIndicatorOff(){
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    // MARK: - insertMovieToCoreData
    func insertMovieToCoreData(movie: Movie) -> Bool{
        return (dataLayer?.insertMovie(movie: movie))!
    }
    
    // MARK: - getMoviesListFromCoreData
    func getMoviesListFromCoreData(listType : ListType)-> Array<Movie>{
        return (dataLayer?.getAllMovies(listType: listType))!
    }
    
    // MARK: - Get movie data using movie id
    func getMovieDataById(id : Int) -> Movie{
        return (dataLayer?.getMovieDataById(id: id))!
    }
    
    // MARK: - Checks if movie aleady exists in coredata
    func isMovieExistsInCoreData(id : Int) -> Bool {
        return (dataLayer?.isMovieExists(id: id))!
    }
    
    // MARK: - Delete movie from coredata.. Returns true if succeed
    func deleteMovieFromCoreData(id : Int) -> Bool {
        return (dataLayer?.deleteMovie(id: id))!
    }
    
}
