//
//  AddUserNavigator.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import UIKit
import Domain

protocol CreateUserNavigator {
    
    func toJokes(_ user: User)
}

final class DefaultCreateUserNavigator: CreateUserNavigator {
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toJokes(_ user: User) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let services = Application.shared.networkUseCaseProvider
        let navigator = DefaultJokesNavigator(services: services,
                                              navigationController: navigationController,
                                              storyBoard: storyboard)
        let jokesVC = navigationController.viewControllers.first as! JokesViewController
        let viewModel = JokesViewModel(useCase: services.makeJokesUseCase(),
                                       navigator: navigator,user: user)
        jokesVC.viewModel = viewModel
        navigationController.dismiss(animated: true)
    }
}
