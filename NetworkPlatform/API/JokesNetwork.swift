//
//  JokesNetwork.swift
//  NetworkPlatform
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Domain
import RxSwift

public final class JokesNetwork {
    private let network: Network<JokesResponse>
    let path = "jokes/random/10?escape=javascript"
    
    init(network: Network<JokesResponse>) {
        self.network = network
    }
    
//    public func fetchJokes() -> Observable<JokesResponse> {
//        return network.getItem(path)
//    }
    
    public func fetchJokes(user: User) -> Observable<JokesResponse> {
        var urlString = path + "&firstName=" + user.firstName + "&lastName=" + user.lastName
        // just in case we have some spaces in names
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        return network.getItem(urlString)
    }

}
