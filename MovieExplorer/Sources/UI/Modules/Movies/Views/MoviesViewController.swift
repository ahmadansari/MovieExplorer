//
//  MoviesViewController.swift
//  MovieExplorer
//
//  Created by Ahmad Ansari on 17/04/2019.
//  Copyright © 2019 Ahmad Ansari. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MoviesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel: MoviesViewModel!
    
    private let disposeBag = DisposeBag()
    private var pageLoading: Bool = false
    private var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupUI()
        bindViewModel()
        pageLoading = true
        setupData()
    }
    
    func setupUI() {
        //Navigaiton
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Filter",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(onTapFilterButton))
        //Register Custom Cell
        MovieCell.register(forTableView: tableView)
    }
    
    func setupData() {
        //Load View Data
        viewModel.loadViewData { [weak self] in
            ProgressHUD.dismiss()
            self?.pageLoading = false
            self?.viewModel.moviesFRC.performFetch()
            self?.reloadData()
        }
    }
    
    func bindViewModel() {
        //Bind Title
        viewModel.title
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        //Show Progress
        viewModel.showProgress
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: {
                ProgressHUD.show(viewController: self)
            }).disposed(by: disposeBag)
        
        //Bind Movies Loaded Event
        viewModel.moviesLoaded
            .asDriver(onErrorJustReturn: ())
            .drive(onNext: { [weak self] in
                ProgressHUD.dismiss()
                self?.pageLoading = false
                self?.reloadData()
            }).disposed(by: disposeBag)
        
        //Bind TableView Selection
        tableView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak self] (indexPath) in
                self?.viewModel.didSelectItem.onNext(indexPath)
            }).disposed(by: disposeBag)
        
        //Bind TableView for FRC Events
        viewModel.moviesFRC.subscribe(forTableView: tableView)
    }

    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MoviesViewController {
    @objc func onTapFilterButton() {
        print("Filter Tap")
        
        if isFiltering {
            isFiltering = false
            navigationItem.rightBarButtonItem?.title = "Filter"
            let predicate = NSPredicate(value: true)
            viewModel.moviesFRC.performFetch(withPredicate: predicate) { (_) in
                self.reloadData()
            }
        } else {
            isFiltering = true
            navigationItem.rightBarButtonItem?.title = "Clear Filter"
            
            let predicate = NSPredicate(format: "releaseDate == %@", Date().stripTime() as NSDate)
            viewModel.moviesFRC.performFetch(withPredicate: predicate) { (_) in
                self.reloadData()
            }
        }
    }
}

extension MoviesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.moviesFRC.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.moviesFRC.numberOfRowsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell: MovieCell = self.tableView.dequeueReusableCell(withIdentifier: MovieCell.cellIdentifier)! as! MovieCell
        
        if let movieDTO = viewModel.moviesFRC.object(at: indexPath) as? MovieDTO {
            movieCell.configure(movieDTO: movieDTO)
        }
        return movieCell
    }
}

extension MoviesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if isLastCell(indexPath: indexPath) && !pageLoading  && isFiltering == false {
            viewModel.loadNextPage()
        }
    }

    func isLastCell(indexPath: IndexPath) -> Bool {
        if indexPath.row >= (viewModel.moviesFRC.count() - 1) {
            return true
        }
        return false
    }
    
}
