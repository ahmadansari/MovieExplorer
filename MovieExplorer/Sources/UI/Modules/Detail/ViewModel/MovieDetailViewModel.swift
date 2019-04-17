//
//  MovieDetailViewModel.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import RxSwift
import Kingfisher

class MovieDetailViewModel {
    
    let movieDTO: MovieDTO?
    
    //Navigation Title
    var title = BehaviorSubject<String>(value: "")
    
    init(movieDTO: MovieDTO) {
        self.movieDTO = movieDTO
    }
}

extension MovieDetailViewModel {
    
    func loadViewData() {
        
    }
    
}
