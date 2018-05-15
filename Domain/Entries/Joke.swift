//
//  Joke.swift
//  Domain
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Foundation

public struct Joke {
    public let uid: String
    public let text: String
    
    public init(uid: String, text: String) {
        self.uid = uid
        self.text = text
    }
}

extension Joke: Equatable {
    public static func == (lhs: Joke, rhs: Joke) -> Bool {
        return lhs.uid == rhs.uid &&
            lhs.text == rhs.text
    }
}
