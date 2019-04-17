//
//  MoviesViewModel.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

typealias VoidBlock = () -> Void

class MoviesViewModel {
 
    private var managedObjectContext: NSManagedObjectContext!
    var moviesFRC: RXFetchedResultsController!
    
    let moduleCoordinator: MoviesModuleCoordinator?
    let movieHandler: MovieHandler?
    
    var page: Int = PageInfo.defaultPage
    
    //Model Output
    var title = BehaviorSubject<String>(value: "Movies")
    var moviesLoaded = PublishSubject<Void>()
    var showProgress = PublishSubject<Void>()
    
    //Model Input
    var didSelectItem = BehaviorSubject<IndexPath?>(value: nil)
    private let disposeBag = DisposeBag()
    
    init(coordinator: MoviesModuleCoordinator, handler: MovieHandler) {
        moduleCoordinator = coordinator
        movieHandler = handler
        configure()
        
        //Subscribe Model Input
        didSelectItem.subscribe(onNext: { [weak self] (indexPath) in
            guard indexPath != nil else {
                return
            }
            self?.didSelectItem(atIndexPath: indexPath!)
        }).disposed(by: disposeBag)
    }
    
    private func configure() {
        managedObjectContext = CoreDataStack.defaultStack.mainContext
        let dateDescriptor = NSSortDescriptor(key: "cachedDate", ascending: true)
        moviesFRC = RXFetchedResultsController(context: managedObjectContext,
                                                              entityName: Movie.entityName,
                                                              sortDescriptors: [dateDescriptor])
        moviesFRC.removeDelegate()
    }
}

extension MoviesViewModel {
    func loadViewData(completion: @escaping VoidBlock) {
        showProgress.onNext(())
        movieHandler?.fetchLatestMovies(page, { [weak self] (response, error) in
            if error != nil {
                print("Error: \(String(describing: error))")
            } else {
                self?.page = response?.page ?? PageInfo.defaultPage
            }
            completion()
        })
    }
    
    func loadNextPage() {
        page += 1
        loadViewData { [weak self] in
            self?.moviesFRC.performFetch(completion: { _ in
                self?.moviesLoaded.onNext(())
            })
        }
    }
}

//Navigation
extension MoviesViewModel {
    func didSelectItem(atIndexPath indexPath: IndexPath) {
        if let movieDTO = moviesFRC.object(at: indexPath) as? MovieDTO {
            moduleCoordinator?.showMovieDetail(movieDTO: movieDTO)
        }
    }
}
