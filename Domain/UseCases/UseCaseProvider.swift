//
//  UseCaseProvider.swift
//  RxChuckNorris
//
//  Created by sergdort on 15/05/2018.
//  Copyright © 2018 jessapps. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    
    func makeJokesUseCase() -> JokesUseCase
}
