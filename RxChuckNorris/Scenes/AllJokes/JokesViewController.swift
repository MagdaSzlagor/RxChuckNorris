//
//  JokesViewController.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class JokesViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: JokesViewModel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
    }
    
    private func configureTableView() {
        tableView.refreshControl = UIRefreshControl()
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        bindViewModel()
    }
    
    private func bindViewModel() {
        assert(viewModel != nil)
        let viewDidAppear = rx.sentMessage(#selector(UIViewController.viewDidAppear(_:)))
            .mapToVoid()
            .asDriverOnErrorJustComplete()

        let pull = tableView.refreshControl!.rx
            .controlEvent(.valueChanged)
            .asDriver()
        
        let input = JokesViewModel.Input(trigger: Driver.merge(viewDidAppear,pull))
        let output = viewModel.transform(input: input)
        
        //Bind Jokes to UITableView
        output.jokes?.drive(tableView.rx.items(cellIdentifier: JokeTableViewCell.reuseID, cellType: JokeTableViewCell.self)) { tv, viewModel, cell in
            cell.bind(viewModel)
            
            }.addDisposableTo(disposeBag)
        
        //Connect Create User to UI
        output.fetching
            .drive(tableView.refreshControl!.rx.isRefreshing)
            .disposed(by: disposeBag)
    }
}
