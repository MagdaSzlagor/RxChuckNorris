//
//  JokeTableViewCell.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import UIKit

class JokeTableViewCell: UITableViewCell {
    @IBOutlet weak var jokeLabel: UILabel!
    
    func bind(_ viewModel:JokeItemViewModel) {
        self.jokeLabel.text = viewModel.text
    }
}
