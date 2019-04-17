//
//  ViewController.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad () {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        MovieHandler.shared.fetchGenreList { (response, error) in
            print("\(response)")
            if error == nil {
                MovieHandler.shared.fetchLatestMovies(1, { (response, _) in
                    print("\(response)")
                })
            }
        }
    }
    
}
