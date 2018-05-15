//
//  User.swift
//  RxChuckNorris
//
//  Created by sergdort on 15/05/2018.
//  Copyright © 2018 jessapps. All rights reserved.
//

import Foundation

public struct User {

    public let firstName: String
    public let lastName: String

    public init(firstName: String,
                lastName: String) {
        self.firstName = firstName
        self.lastName = lastName
    }
}

extension User: Equatable {
    public static func == (lhs: User, rhs: User) -> Bool {
        return lhs.firstName == rhs.firstName &&
            lhs.lastName == rhs.lastName
    }
}
