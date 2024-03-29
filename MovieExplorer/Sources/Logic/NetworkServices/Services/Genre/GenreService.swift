//
//  GenreService.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

// MARK: - Genre Service Protocol
protocol GenreServiceProtocol: AnyObject {
  func genreList(completionHandler: @escaping ServiceResponseHandler<GenreServiceResponse>)
}

// MARK: - Genre Service
final class GenreService: Service, GenreServiceProtocol {

  init() {
    super.init(baseURL: API.baseURL,
               servicePath: ServicePath.genreList)
  }

  func genreList(completionHandler: @escaping ServiceResponseHandler<GenreServiceResponse>) {

    let parameters: [String: Any] = [Keys.apiKey: API.apiKey]

    self.peformRequest(parameters: parameters) { (response) in
      if response == nil || response?.error != nil {
        let error = response?.error
        SLog.error(error as Any)
        completionHandler(nil, error)
      } else {
        if let json: Any = response?.value {
          do {
            let genreResponse: GenreServiceResponse = try self.translation.decode(object: json)
            completionHandler(genreResponse, nil)
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
