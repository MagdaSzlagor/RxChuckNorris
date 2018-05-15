//
//  JokesNavigator.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import UIKit
import Domain

protocol JokesNavigator {
    func toCreateUser()
    func toJokes()
}

class DefaultJokesNavigator: JokesNavigator {
    private let storyBoard: UIStoryboard
    private let navigationController: UINavigationController
    private let services: UseCaseProvider
    
    init(services: UseCaseProvider,
         navigationController: UINavigationController,
         storyBoard: UIStoryboard) {
        self.services = services
        self.navigationController = navigationController
        self.storyBoard = storyBoard
    }
    
    func toJokes() {
        let vc = storyBoard.instantiateViewController(ofType: JokesViewController.self)
        vc.viewModel = JokesViewModel(useCase: services.makeJokesUseCase(),
                                      navigator: self)
        navigationController.pushViewController(vc, animated: true)
    }
    
    func toCreateUser() {
        let navigator = DefaultCreateUserNavigator(navigationController: navigationController)
        let viewModel = CreateUserViewModel(jokesUseCase: services.makeJokesUseCase(),
                                            navigator: navigator)
        let vc = storyBoard.instantiateViewController(ofType: CreateUserViewController.self)
        vc.viewModel = viewModel
        navigationController.present(vc, animated: true, completion: nil)
    }
}
