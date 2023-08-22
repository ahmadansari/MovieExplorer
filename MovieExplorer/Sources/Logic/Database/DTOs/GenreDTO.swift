//
//  GenreDTO.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation

class GenreDTO: NSObject {

  weak var genre: Genre?

  init(genre: Genre) {
    super.init()
    self.genre = genre
  }

  func genreName() -> String {
    if let name = self.genre?.name {
      return name
    }
    return ""
  }
}
