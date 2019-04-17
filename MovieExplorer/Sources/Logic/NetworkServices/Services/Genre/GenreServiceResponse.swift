//
//  GenreServiceResponse.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

struct GenreListResponse: Codable {
    let genereList: [GenreData]?
}

struct GenreData: Codable {
    let id: String?
    let name: String?
}
