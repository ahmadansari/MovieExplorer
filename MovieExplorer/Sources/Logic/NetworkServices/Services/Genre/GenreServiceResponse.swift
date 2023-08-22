//
//  GenreServiceResponse.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

struct GenreServiceResponse: Codable {
  let genereList: [GenreData]?
  
  private enum CodingKeys: String, CodingKey {
    case genereList = "genres"
  }
}

struct GenreData: Codable {
  let id: Int64
  let name: String?
}
