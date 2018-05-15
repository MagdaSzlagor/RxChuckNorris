//
//  JokeUseCase.swift
//  Domain
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Foundation
import RxSwift

public protocol JokesUseCase {
//    func jokes() -> Observable<[Joke]>
    func jokes(user: User) -> Observable<[Joke]>
}
