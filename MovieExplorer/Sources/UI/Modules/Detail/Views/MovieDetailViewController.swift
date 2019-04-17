//
//  MovieDetailViewController.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var storyTextView: UITextView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var backdropHeightConstraint: NSLayoutConstraint!
    
    //Movie Detail Presenter
    var viewModel: MovieDetailViewModel!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.updateInterfaceOnOrientationChange()
        self.populateMovieData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - View Tranistion
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { (_) in
            self.updateInterfaceOnOrientationChange()
        }, completion: nil)
    }
    
    func updateInterfaceOnOrientationChange() {
        if UIDevice.current.orientation.isLandscape == true {
            self.backdropHeightConstraint.constant = 0
        } else {
            self.backdropHeightConstraint.constant = 211
        }
    }
    
    func populateMovieData() {
        
        guard let movieDTO = self.viewModel.movieDTO else { return }
        
        self.titleLabel?.text = movieDTO.movieTitle()
        self.genreLabel.text = movieDTO.genreList()
        self.releaseDateLabel.text = movieDTO.releaseDate()
        self.languageLabel.text = movieDTO.movieLanguage()
        self.ratingLabel.text = movieDTO.movieRatings()
        self.storyTextView.text = movieDTO.movieOverview()
        self.titleLabel.sizeToFit()
        self.genreLabel.sizeToFit()
        
        posterImageView.kf.setImage(with: movieDTO.posterURL(), placeholder: UIImage.placeholderImage)
        
        backdropImageView.kf.setImage(with: movieDTO.backdropURL(), placeholder: UIImage.placeholderImage)        
    }
}
