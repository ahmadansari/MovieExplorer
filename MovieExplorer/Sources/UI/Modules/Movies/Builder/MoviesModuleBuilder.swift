//
//  MoviesModuleBuilder.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class MoviesModuleBuilder {
  
  func build() -> UIViewController {
    
    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
    let viewController = storyboard.instantiateViewController(withIdentifier: "MoviesViewController") as! MoviesViewController
    
    let navigationController = UINavigationController(rootViewController: viewController)
    
    let coordinator = MoviesModuleCoordinator(navigationController: navigationController)
    let viewModel = MoviesViewModel(coordinator: coordinator, handler: MovieHandler.shared)
    
    viewController.viewModel = viewModel
    
    return navigationController
  }
}
