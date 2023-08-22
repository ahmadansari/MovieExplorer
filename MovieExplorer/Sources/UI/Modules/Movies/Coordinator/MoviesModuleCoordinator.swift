//
//  MoviesModuleCoordinator.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class MoviesModuleCoordinator {
  let navigationController: UINavigationController?

  init(navigationController: UINavigationController?) {
    self.navigationController = navigationController
  }
}

extension MoviesModuleCoordinator {
  func showMovieDetail(movieDTO: MovieDTO) {
    let detailController = MovieDetailModuleBuilder().build(movieDTO: movieDTO)
    navigationController?.pushViewController(detailController, animated: true)
  }
}
