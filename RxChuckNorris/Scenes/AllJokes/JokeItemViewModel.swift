//
//  JokeItemViewModel.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import Foundation
import Domain

final class JokeItemViewModel   {
    let text:String
    let joke: Joke
    
    init (with joke: Joke) {
        self.joke = joke
        self.text = joke.text
    }
}
