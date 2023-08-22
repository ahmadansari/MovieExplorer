//
//  MovieCell.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
  static let cellIdentifier = "movieCell"
  
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var releaseDateLabel: UILabel!
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var posterView: UIImageView!
  
  class func register(forTableView tableView: UITableView?) {
    guard tableView != nil else { return }
    tableView?.register(UINib.init(nibName: "MovieCell", bundle: Bundle.main), forCellReuseIdentifier: MovieCell.cellIdentifier)
  }
  
  func configure(movieDTO: MovieDTO) {
    titleLabel?.text = movieDTO.movieTitle()
    descriptionLabel.text = movieDTO.movieOverview()
    releaseDateLabel.text = movieDTO.displayDate()
    titleLabel.sizeToFit()
    descriptionLabel.sizeToFit()        
    posterView.kf.setImage(with: movieDTO.posterURL(), placeholder: UIImage.placeholderImage)
  }
}
