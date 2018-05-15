//
//  JokesViewModel.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class JokesViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
    }
    struct Output {
        let fetching: Driver<Bool>
        let jokes: Driver<[JokeItemViewModel]>?
        let error: Driver<Error>
    }
    
    private let useCase: JokesUseCase
    private let navigator: JokesNavigator
    private let user: User?
    
    init(useCase: JokesUseCase, navigator: JokesNavigator) {
        self.useCase = useCase
        self.navigator = navigator
        self.user = nil
    }
    
    init(useCase: JokesUseCase, navigator: JokesNavigator, user: User) {
        self.useCase = useCase
        self.navigator = navigator
        self.user = user
    }
    
    func transform(input: Input) -> Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        
        guard  let _ = user else {
            return Output(fetching: fetching,
                          jokes: nil,
                          error: errors)
        }
        let jokes = input.trigger.flatMapLatest {
            return self.useCase.jokes(user: self.user!)
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
                .map { $0.map { JokeItemViewModel(with: $0) } }
        }
   
        return Output(fetching: fetching,
                      jokes: jokes,
                      error: errors)
    }
}
