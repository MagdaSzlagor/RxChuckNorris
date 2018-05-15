//
//  NetworkProvider.swift
//  RxChuckNorris
//
//  Created by sergdort on 15/05/2018.
//  Copyright © 2018 jessapps. All rights reserved.
//

import Domain

final class NetworkProvider {
    private let apiEndpoint: String

    public init() {
        apiEndpoint = "https://api.icndb.com"
    }

    public func makeJokesNetwork() -> JokesNetwork {
        let network = Network<JokesResponse>(apiEndpoint)
        return JokesNetwork(network: network)
    }
}
