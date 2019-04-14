import Foundation
import UIKit

class ModelLayer{
    
    let apiKey = "e91d155831d8f6a5c7089243d189285b"
    let baseUrl = "https://api.themoviedb.org"
    let networkLayer : NetworkLayer = NetworkLayer()
    let dataLayer : DataLayer?
    var appDelegate : AppDelegate?
    var pageNumber : Int = 1
    
    init(appDelegate : AppDelegate) {
        dataLayer = DataLayer(appDelegate: appDelegate)
    }
        
    //MARK: - Get all movies
    func getMoviesList (sortType : SortType, completionHandler : @escaping (Array<Movie>?, Error?) -> Void){
        turnNetwokIndicatorOn()
        let url = "\(baseUrl)/3/discover/movie?sort_by=\(sortType.rawValue).desc&page=\(pageNumber)&api_key=\(apiKey)"
        
        networkLayer.executeNetwordRequest(url: url) { (value, error) in
            if let result = value {
                var movieslist : Array<Movie> = []
                let moviesArray = result[APIMovie.results.rawValue] as! Array<[String : Any]>
                for item in moviesArray{
                    
                    let movie = Movie()
                    movie.id = item[APIMovie.id.rawValue] as? Int ?? 0
                    movie.posterPath = item[APIMovie.posterPath.rawValue] as? String ?? ""
                    movie.releaseDate = item[APIMovie.releaseDate.rawValue] as? String ?? ""
                    movie.title = item[APIMovie.title.rawValue] as? String ?? ""
                    movie.voteAverage = item[APIMovie.voteAverage.rawValue] as? Double ?? 0
                    movie.originalLanguage = item[APIMovie.originalLanguage.rawValue] as? String ?? ""
                    movie.overview = item[APIMovie.overview.rawValue] as? String ?? ""
                    
                    movieslist.append(movie)
                }
                
                self.pageNumber = self.pageNumber + 1
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
        networkLayer.getImageUsingPosterPath(posterPath: movie.posterPath, imageSize: APIImageSize.w185) { (data, error) in
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
        let url : String = "\(baseUrl)/3/movie/\(movieId)/videos?api_key=\(apiKey)"
        
        networkLayer.executeNetwordRequest(url: url) { (value, error) in
            if let result = value {
                let trailersArray = result[APIMovie.results.rawValue] as! Array<[String : Any]>
                for item in trailersArray{
                    
                    let trailer = Trailer()
                    trailer.key = item[APITrailer.key.rawValue] as? String ?? ""
                    trailer.name = item[APITrailer.name.rawValue] as? String ?? ""
                    trailer.site = item[APITrailer.site.rawValue] as? String ?? ""
                    trailer.size = item[APITrailer.size.rawValue] as? Int ?? 0
                    trailer.type = item[APITrailer.type.rawValue] as? String ?? ""
                    
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
        let url : String = "\(baseUrl)/3/movie/\(movieId)/reviews?api_key=\(apiKey)"
        
        networkLayer.executeNetwordRequest(url: url) { (value, error) in
            if let result = value {
                let reviewsArray = result["results"] as! Array<[String : Any]>
                for item in reviewsArray{
                    
                    let review = Review()
                    review.id = item[APIReview.id.rawValue] as? String ?? ""
                    review.author = item[APIReview.author.rawValue] as? String ?? ""
                    review.content = item[APIReview.content.rawValue] as? String ?? ""
                    
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
    
    //MARK: - Get cast using movie id
    func getCast (movieId : Int, completionHandler : @escaping (Array<Cast>?, Error?) -> Void){
        
        self.turnNetwokIndicatorOn()
        var castlist : Array<Cast> = []
        let url : String = "\(baseUrl)/3/movie/\(movieId)/credits?api_key=\(apiKey)"
        
        networkLayer.executeNetwordRequest(url: url) { (value, error) in
            if let result = value {
                let castArray = result["cast"] as! Array<[String : Any]>
                for item in castArray{
                    
                    let cast = Cast()
                    cast.id = item[APICast.id.rawValue] as? String ?? ""
                    cast.character = item[APICast.character.rawValue] as? String ?? ""
                    cast.name = item[APICast.name.rawValue] as? String ?? ""
                    cast.profilePath = item[APICast.profilePath.rawValue] as? String ?? ""
                    
                    print(cast.name ?? "")
                    
                    castlist.append(cast)
                }
                
                self.turnNetwokIndicatorOff()
                completionHandler(castlist, nil)
                
            } else {
                
                self.turnNetwokIndicatorOff()
                completionHandler(nil, error)
                
            }
        }
    }
    
    //MARK - Get Actor Image
    func getCastImage(cast : Cast, completionHandler : @escaping (UIImage?) -> Void){
        
        self.turnNetwokIndicatorOn()
        networkLayer.getImageUsingPosterPath(posterPath: cast.profilePath ?? "", imageSize: APIImageSize.face66x66) { (data, error) in
            if let imageData = data{
                cast.image = imageData
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
    
    // MARK: - Reset page number to 1 in case of changed sorting type
    func resetPageNumber(){
        self.pageNumber = 1
    }
}
