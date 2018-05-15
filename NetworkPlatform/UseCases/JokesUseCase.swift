//
//  JokesUseCase.swift
//  NetworkPlatform
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Foundation
import Domain
import RxSwift

final class JokesUseCase<Cache>: Domain.JokesUseCase where Cache: AbstractCache, Cache.T == Joke {
    
    private let network: JokesNetwork
    private let cache: Cache
    
    init(network: JokesNetwork, cache: Cache) {
        self.network = network
        self.cache = cache
    }
    
//    func jokes() -> Observable<[Joke]> {
//        let fetchJokes = cache.fetchObjects().asObservable()
//        let stored = network.fetchJokes()
//            .flatMap {
//                return self.cache.save(objects: $0.jokes)
//                    .asObservable()
//                    .map(to: [Joke].self)
//                    .concat(Observable.just($0.jokes))
//        }
//        
//        return fetchJokes.concat(stored)
//    }
    
    func jokes(user: User) -> Observable<[Joke]> {
        let fetchJokes = cache.fetchObjects().asObservable()
        let stored = network.fetchJokes(user: user)
            .flatMap {
                return self.cache.save(objects: $0.jokes)
                    .asObservable()
                    .map(to: [Joke].self)
                    .concat(Observable.just($0.jokes))
        }
        
        return fetchJokes.concat(stored)
    }
}

struct MapFromNever: Error {}
extension ObservableType where E == Never {
    func map<T>(to: T.Type) -> Observable<T> {
        return self.flatMap { _ in
            return Observable<T>.error(MapFromNever())
        }
    }
}
