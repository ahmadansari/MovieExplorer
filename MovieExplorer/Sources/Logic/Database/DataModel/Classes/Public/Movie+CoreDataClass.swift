//
//  Movie+CoreDataClass.swift
//  
//
//  Created by Ahmad Ansari on 17/04/2019.
//
//

import Foundation
import CoreData

@objc(Movie)
public class Movie: NSManagedObject {
    //Entity Name
    static let entityName = Movie.entity().name ?? "Movie"
    
    //DTO
    lazy var movieDTO: MovieDTO = {
        return MovieDTO.init(movie: self)
    }()
}

extension Movie: DataTransferProtocol {
    func dataTransferObject() -> Any? {
        return self.movieDTO
    }
}

//Movie Data Persistence
extension Movie {
    
    //Saving Movie Objects
    class func saveMovies(_ movies: [MovieData],
                          context: NSManagedObjectContext,
                          completion:@escaping (Error?) -> Void) {
        context.perform {
            
            guard movies.count > 0 else {
                completion(nil)
                return
            }
            
            for movieData in movies {
                
                let id = movieData.id
                let request: NSFetchRequest = Movie.fetchRequest()
                request.predicate = NSPredicate.init(format: "SELF.id == %ld", id)
                let filteredResults = try? context.fetch(request)
                
                var movie: Movie?
                if (filteredResults?.isEmpty == false) {
                    movie = filteredResults?.first
                } else {
                    movie = Movie(context: context)
                }
                
                movie?.id = id
                movie?.voteCount = movieData.voteCount ?? 0
                movie?.video = movieData.video ?? false
                movie?.voteAverage = movieData.voteAverage ?? 0.0
                movie?.title = movieData.title
                movie?.popularity = movieData.popularity ?? 0.0
                movie?.posterPath = movieData.posterPath
                movie?.originalLanguage = movieData.originalLanguage
                movie?.originalTitle = movieData.originalTitle
                movie?.backdropPath = movieData.backdropPath
                movie?.adult = movieData.adult ?? false
                movie?.overview = movieData.overview
                movie?.releaseDate = movieData.releaseDate
                movie?.cachedDate = Date() as NSDate
                
                if let genreIds = movieData.genreIds, genreIds.count > 0 {
                    let genreRequest: NSFetchRequest = Genre.fetchRequest()
                    genreRequest.predicate = NSPredicate.init(format: "SELF.id IN %@", genreIds)
                    if let genres = try? context.fetch(genreRequest) {
                        for genre in genres {
                            genre.addToMovies(movie!)
                        }
                    }
                }
            }
            
            CoreDataStack.saveContext(context, { (error) in
                completion(error)
            })
        }
    }
    
    class func movie(withId movieId: Int64, context: NSManagedObjectContext) -> Movie? {
        var movie: Movie?
        context.performAndWait {
            let request: NSFetchRequest = Movie.fetchRequest()
            request.predicate = NSPredicate.init(format: "SELF.id == %ld", movieId)
            if let filteredResults = try? context.fetch(request) {
                movie = filteredResults.first
            }
        }
        return movie
    }
}
