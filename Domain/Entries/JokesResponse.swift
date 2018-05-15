//
//  JokesResponse.swift
//  Domain
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Foundation

public struct JokesResponse {
    public let jokes: [Joke]
    public let type: String
    public let uid: String = ""
    
    public init(type: String, jokes: [Joke]) {
        self.type = type
        self.jokes = jokes
    }
}

extension JokesResponse: Equatable {
    public static func == (lhs: JokesResponse, rhs: JokesResponse) -> Bool {
        return lhs.type == rhs.type &&
            lhs.jokes == rhs.jokes
    }
}
