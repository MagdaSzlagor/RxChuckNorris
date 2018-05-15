//
//  Joke+Mapping.swift
//  NetworkPlatform
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Domain
import ObjectMapper

extension Joke: ImmutableMappable, Identifiable {
    
    // JSON -> Object
    public init(map: Map) throws {
        uid = try map.value("id", using: UidTransform())
        text = try map.value("joke")
    }
}

extension Joke: Encodable {
    var encoder: NETJoke {
        return NETJoke(with: self)
    }
}

final class NETJoke: NSObject, NSCoding, DomainConvertibleType {
    struct Keys {
        static let uid = "uid"
        static let text = "text"
    }
    let uid: String
    let text: String
    
    init(with domain: Joke) {
        self.uid = domain.uid
        self.text = domain.text
    }
    
    init?(coder aDecoder: NSCoder) {
        guard
            let uid = aDecoder.decodeObject(forKey: Keys.uid) as? String,
            let text = aDecoder.decodeObject(forKey: Keys.text) as? String
            else {
                return nil
        }
        self.uid = uid
        self.text = text
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(uid, forKey: Keys.uid)
        aCoder.encode(text, forKey: Keys.text)
    }
    
    func asDomain() -> Joke {
        return Joke(uid: uid, text: text)
    }
}
