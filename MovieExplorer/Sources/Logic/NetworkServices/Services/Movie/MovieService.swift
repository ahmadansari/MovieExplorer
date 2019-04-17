//
//  MovieService.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

// MARK: - Movie Service Protocol
protocol MovieServiceProtocol: class {
    
}

// MARK: - Movie Service
final class MovieService: Service, MovieServiceProtocol {
    
    init() {
        super.init(baseURL: API.baseURL,
                   servicePath: ServicePath.discoverMovies)
    }
    
    func latestMovies(page: Int, completionHandler: @escaping ServiceResponseHandler<MovieServiceResponse>) {
        
        let parameters: [String: Any] = ["sort_by": "primary_release_date.desc",
                                         "primary_release_date.lte": "2019-04-30",
                                         Keys.page: page,
                                         Keys.apiKey: API.apiKey
        ]
        
        self.peformRequest(parameters: parameters) { (response) in
            if (response == nil || response?.error != nil) {
                let error = response?.error
                SLog.error(error as Any)
                completionHandler(nil, error)
            } else {
                if let json: Any = response?.value {
                    do {
                        let moviesResponse: MovieServiceResponse = try self.translation.decode(object: json)
                        completionHandler(moviesResponse, nil)
                    } catch {
                        completionHandler(nil, error)
                    }
                } else {
                    completionHandler(nil, ServiceError.unknown)
                }
            }
        }
    }
}
