//
//  JokesResponse+Mapping.swift
//  NetworkPlatform
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Domain
import ObjectMapper

extension JokesResponse: ImmutableMappable, Identifiable {

    // JSON -> Object
    public init(map: Map) throws {
        jokes = try map.value("value")
        type = try map.value("type")
        uid = ""
    }
}

extension JokesResponse: Encodable {
    var encoder: NETJokesResponse {
        return NETJokesResponse(with: self)
    }
}

final class NETJokesResponse: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let jokes = "jokes"
        static let type = "type"
    }
    let jokes: [Joke]
    let type: String
    
    init(with domain: JokesResponse) {
        self.jokes = domain.jokes
        self.type = domain.type
    }
    
    init?(coder aDecoder: NSCoder) {
        guard
            let jokes = aDecoder.decodeObject(forKey: Keys.jokes) as? [Joke],
            let type = aDecoder.decodeObject(forKey: Keys.type) as? String
            else {
                return nil
        }
        self.jokes = jokes
        self.type = type
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(jokes, forKey: Keys.jokes)
        aCoder.encode(type, forKey: Keys.type)
    }
    
    func asDomain() -> JokesResponse {
        return JokesResponse(type: type, jokes: jokes)
    }
}
