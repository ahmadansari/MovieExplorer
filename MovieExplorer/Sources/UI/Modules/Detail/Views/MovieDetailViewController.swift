//
//  MovieDetailViewController.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

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
    
    private let disposeBag = DisposeBag()
    
    //Movie Detail Presenter
    var viewModel: MovieDetailViewModel!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        bindViewModel()
        viewModel.loadViewData()
    }
    
    func setupUI() {
        self.updateInterfaceOnOrientationChange()
    }
    
    func bindViewModel() {
        
        viewModel.title.bind(to: titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.genreList.bind(to: genreLabel.rx.text).disposed(by: disposeBag)
        viewModel.releaseDate.bind(to: releaseDateLabel.rx.text).disposed(by: disposeBag)
        viewModel.movieLanguage.bind(to: languageLabel.rx.text).disposed(by: disposeBag)
        viewModel.movieRatings.bind(to: ratingLabel.rx.text).disposed(by: disposeBag)
        viewModel.movieOverview.bind(to: storyTextView.rx.text).disposed(by: disposeBag)
        
        viewModel.posterLoaded.asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] (url) in
                self?.posterImageView.kf.setImage(with: url, placeholder: UIImage.placeholderImage)
            }).disposed(by: disposeBag)
        
        viewModel.backdropLoaded.asDriver(onErrorJustReturn: nil)
            .drive(onNext: { [weak self] (url) in
                self?.backdropImageView.kf.setImage(with: url, placeholder: UIImage.placeholderImage)
            }).disposed(by: disposeBag)
    }
}

// MARK: - View Tranistion
extension MovieDetailViewController {
    
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
    
}
