//
//  AddUserViewModel.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Domain

final class CreateUserViewModel: ViewModelType {
    private let jokesUseCase: JokesUseCase
    private let navigator: CreateUserNavigator
    
    init(jokesUseCase: JokesUseCase, navigator: CreateUserNavigator) {
        self.jokesUseCase = jokesUseCase
        self.navigator = navigator
    }
    
    func transform(input: Input) -> Output {
        let userData = Driver.combineLatest(input.firstName, input.lastName) {
            $0
        }
        
        let canSave = Driver.combineLatest(input.firstName, input.lastName) {
            return !$0.isEmpty && !$1.isEmpty
        }
        
        let user = input.saveTrigger.withLatestFrom(userData)
            .map { (firstName, lastName) in
                return User(firstName: firstName, lastName: lastName)
            }.do(onNext: navigator.toJokes)
        
        return Output(saveEnabled: canSave, userCreated: user)
    }
}

extension CreateUserViewModel {
    struct Input {
        let saveTrigger: Driver<Void>
        let firstName: Driver<String>
        let lastName: Driver<String>
    }
    
    struct Output {
        let saveEnabled: Driver<Bool>
        let userCreated: Driver<User>
    }
}
