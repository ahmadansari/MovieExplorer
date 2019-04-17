//
//  MovieDetailModuleBuilder.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 18/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailModuleBuilder {
    
    func build(movieDTO: MovieDTO) -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        
        viewController.viewModel = MovieDetailViewModel(movieDTO: movieDTO)
        
        return viewController
    }
}
