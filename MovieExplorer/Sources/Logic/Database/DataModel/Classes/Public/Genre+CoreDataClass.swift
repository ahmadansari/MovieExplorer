//
//  Genre+CoreDataClass.swift
//  
//
//  Created by Ahmad Ansari on 17/04/2019.
//
//

import Foundation
import CoreData

@objc(Genre)
public class Genre: NSManagedObject {
    //Entity Name
    static let entityName = "Genre"
    
    //DTO
    lazy var genreDTO: GenreDTO = {
        return GenreDTO.init(genre: self)
    }()
}

extension Genre: DataTransferProtocol {
    func dataTransferObject() -> Any? {
        return self.genreDTO
    }
}

//Genre Data Persistence
extension Genre {
    
    //Saving Genre Object
    class func saveGenres(_ genres: [GenreData],
                          context: NSManagedObjectContext,
                          completion:@escaping (Error?) -> Void) {
        context.perform {
            
            guard genres.count > 0 else {
                completion(nil)
                return
            }
            
            for genreData in genres {
                
                let id = genreData.id
                let request: NSFetchRequest = Genre.fetchRequest()
                request.predicate = NSPredicate.init(format: "SELF.id == %ld", id)
                let filteredResults = try? context.fetch(request)
                
                var genre: Genre?
                if (filteredResults?.isEmpty == false) {
                    genre = filteredResults?.first
                } else {
                    genre = Genre(context: context)
                }
                
                genre?.id = id
                genre?.name = genreData.name
            }
            
            CoreDataStack.saveContext(context, { (error) in
                completion(error)
            })
        }
    }
}
