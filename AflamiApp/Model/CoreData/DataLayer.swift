//
//  DataLayer.swift
//  AflamiApp
//
//  Created by Ahmed M. Hassan on 4/2/19.
//  Copyright © 2019 Ahmed M. Hassan. All rights reserved.
//

import Foundation
import CoreData

class DataLayer{
    
    static let MOVIE_ENTITY = "MovieEntity"
    
    let appDelegate : AppDelegate?
    let managedContext : NSManagedObjectContext?
    let movieEntity : NSEntityDescription?
    
    init(appDelegate : AppDelegate) {
        self.appDelegate = appDelegate
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        movieEntity = NSEntityDescription.entity(forEntityName: DataLayer.MOVIE_ENTITY, in: managedContext!)
    }
    
    
    func insertMovie(movie : Movie) -> Bool {

        let movieObj = NSManagedObject(entity: movieEntity!, insertInto: managedContext)
        
        movieObj.setValue(movie.id, forKey: "id")
        movieObj.setValue(movie.voteAverage, forKey: "voteAverage")
        movieObj.setValue(movie.posterPath, forKey: "posterPath")
        movieObj.setValue(movie.title, forKey: "title")
        movieObj.setValue(movie.overview, forKey: "overview")
        movieObj.setValue(movie.releaseDate, forKey: "releaseDate")
        movieObj.setValue(movie.originalLanguage, forKey: "originalLanguage")
        movieObj.setValue(movie.image, forKey: "image")
        movieObj.setValue(movie.trailers, forKey: "trailers")
        movieObj.setValue(movie.reviews, forKey: "reviews")
        
        print("Succeed")
        do {
            try managedContext?.save()
        } catch let error as NSError {
            print(error)
            return false
        }
        return true
    }
    
    
    func getAllMovies(listType : ListType) -> Array<Movie> {
        
        var moviesList : Array<Movie> = []
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: DataLayer.MOVIE_ENTITY)
        
        do {
            let fetchedMovies = try managedContext?.fetch(fetchRequest)
            for item in fetchedMovies!{
                let movie : Movie = Movie()
                
                movie.id = (item.value(forKey: "id") as! Int?)!
                movie.title = (item.value(forKey: "title") as! String?)!
                movie.image = (item.value(forKey: "image") as! Data?)!
                
                if (listType == .Fulllist){
                    movie.voteAverage = (item.value(forKey: "voteAverage") as! Double?)!
                    movie.posterPath = (item.value(forKey: "posterPath") as! String?)!
                    movie.overview = (item.value(forKey: "overview") as! String?)!
                    movie.releaseDate = (item.value(forKey: "releaseDate") as! String?)!
                    movie.originalLanguage = (item.value(forKey: "originalLanguage") as! String?)!
                    movie.trailers = (item.value(forKey: "trailers") as! [Trailer]?)!
                    movie.reviews = (item.value(forKey: "reviews") as! [Review]?)!
                }
                moviesList.append(movie)
            }
            
        } catch let error as NSError {
            print (error)
        }
        return moviesList
    }
    
    
    func getMovieDataById(id : Int) -> Movie {
        
        let movie : Movie = Movie()
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: DataLayer.MOVIE_ENTITY)
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        
        do {
            let fetchedMovies = try managedContext?.fetch(fetchRequest)
            for item in fetchedMovies!{
                movie.id = (item.value(forKey: "id") as! Int?)!
                movie.title = (item.value(forKey: "title") as! String?)!
                movie.image = (item.value(forKey: "image") as! Data?)!
                movie.voteAverage = (item.value(forKey: "voteAverage") as! Double?)!
                movie.posterPath = (item.value(forKey: "posterPath") as! String?)!
                movie.overview = (item.value(forKey: "overview") as! String?)!
                movie.releaseDate = (item.value(forKey: "releaseDate") as! String?)!
                movie.originalLanguage = (item.value(forKey: "originalLanguage") as! String?)!
                movie.trailers = (item.value(forKey: "trailers") as! [Trailer]?)!
                movie.reviews = (item.value(forKey: "reviews") as! [Review]?)!
                print(movie.title)
            }
            
        } catch let error as NSError {
            print (error)
        }
        return movie
    }
}
