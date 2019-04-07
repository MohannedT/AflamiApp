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
    
    let appDelegate : AppDelegate?
    let managedContext : NSManagedObjectContext?
    let movieEntity : NSEntityDescription?
    
    init(appDelegate : AppDelegate) {
        self.appDelegate = appDelegate
        
        managedContext = appDelegate.persistentContainer.viewContext
        
        movieEntity = NSEntityDescription.entity(forEntityName: MoviesEntity.entityName.rawValue, in: managedContext!)
    }
    
    
    func insertMovie(movie : Movie) -> Bool {

        let movieObj = NSManagedObject(entity: movieEntity!, insertInto: managedContext)
        
        movieObj.setValue(movie.id, forKey: MoviesEntity.id.rawValue)
        movieObj.setValue(movie.voteAverage, forKey: MoviesEntity.voteAverage.rawValue)
        movieObj.setValue(movie.posterPath, forKey: MoviesEntity.posterPath.rawValue)
        movieObj.setValue(movie.title, forKey: MoviesEntity.title.rawValue)
        movieObj.setValue(movie.overview, forKey: MoviesEntity.overview.rawValue)
        movieObj.setValue(movie.releaseDate, forKey: MoviesEntity.releaseDate.rawValue)
        movieObj.setValue(movie.originalLanguage, forKey: MoviesEntity.originalLanguage.rawValue)
        movieObj.setValue(movie.image, forKey: MoviesEntity.image.rawValue)
        movieObj.setValue(movie.trailers, forKey: MoviesEntity.trailers.rawValue)
        movieObj.setValue(movie.reviews, forKey: MoviesEntity.reviews.rawValue)
        
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
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MoviesEntity.entityName.rawValue)
        
        do {
            let fetchedMovies = try managedContext?.fetch(fetchRequest)
            for item in fetchedMovies!{
                let movie : Movie = Movie()
                
                movie.id = (item.value(forKey: MoviesEntity.id.rawValue) as! Int?)!
                movie.title = (item.value(forKey: MoviesEntity.title.rawValue) as! String?)!
                movie.image = (item.value(forKey: MoviesEntity.image.rawValue) as! Data?)!
                
                if (listType == .Fulllist){
                    movie.voteAverage = (item.value(forKey: MoviesEntity.voteAverage.rawValue) as! Double?)!
                    movie.posterPath = (item.value(forKey: MoviesEntity.posterPath.rawValue) as! String?)!
                    movie.overview = (item.value(forKey: MoviesEntity.overview.rawValue) as! String?)!
                    movie.releaseDate = (item.value(forKey: MoviesEntity.releaseDate.rawValue) as! String?)!
                    movie.originalLanguage = (item.value(forKey: MoviesEntity.originalLanguage.rawValue) as! String?)!
                    movie.trailers = (item.value(forKey: MoviesEntity.trailers.rawValue) as! [Trailer]?)!
                    movie.reviews = (item.value(forKey: MoviesEntity.reviews.rawValue) as! [Review]?)!
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
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MoviesEntity.entityName.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(MoviesEntity.id.rawValue) == %i", id)
        
        do {
            let fetchedMovies = try managedContext?.fetch(fetchRequest)
            for item in fetchedMovies!{
                movie.id = (item.value(forKey: MoviesEntity.id.rawValue) as! Int?)!
                movie.title = (item.value(forKey: MoviesEntity.title.rawValue) as! String?)!
                movie.image = (item.value(forKey: MoviesEntity.image.rawValue) as! Data?)!
                movie.voteAverage = (item.value(forKey: MoviesEntity.voteAverage.rawValue) as! Double?)!
                movie.posterPath = (item.value(forKey: MoviesEntity.posterPath.rawValue) as! String?)!
                movie.overview = (item.value(forKey: MoviesEntity.overview.rawValue) as! String?)!
                movie.releaseDate = (item.value(forKey: MoviesEntity.releaseDate.rawValue) as! String?)!
                movie.originalLanguage = (item.value(forKey: MoviesEntity.originalLanguage.rawValue) as! String?)!
                movie.trailers = (item.value(forKey: MoviesEntity.trailers.rawValue) as! [Trailer]?)!
                movie.reviews = (item.value(forKey: MoviesEntity.reviews.rawValue) as! [Review]?)!
                print(movie.title)
            }
            
        } catch let error as NSError {
            print (error)
        }
        return movie
    }
    
    func isMovieExists(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: MoviesEntity.entityName.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(MoviesEntity.id.rawValue) == %i", id)
        
        var entitiesCount = 0
        
        do {
            entitiesCount = try managedContext!.count(for: fetchRequest)
        }
        catch {
            print("error executing fetch request: \(error)")
        }
        
        return entitiesCount > 0
    }

    
    func deleteMovie(id: Int) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: MoviesEntity.entityName.rawValue)
        fetchRequest.predicate = NSPredicate(format: "\(MoviesEntity.id.rawValue) == %i", id)
        
        do {
            let fetchedMovies = try managedContext?.fetch(fetchRequest)
            for item in fetchedMovies!{
                managedContext?.delete(item)
            }
            try managedContext?.save()
            
        } catch let error as NSError {
            print (error)
            return false
        }
        
        return true
    }
    
}
