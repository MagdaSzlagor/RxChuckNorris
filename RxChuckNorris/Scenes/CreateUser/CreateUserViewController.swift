//
//  AddUserViewController.swift
//  RxChuckNorris
//
//  Created by Magdalena Szlagor on 15/05/2018.
//  Copyright © 2018 sergdort. All rights reserved.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

final class CreateUserViewController: UIViewController {
    private let disposeBag = DisposeBag()
    
    var viewModel: CreateUserViewModel!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let input = CreateUserViewModel.Input(saveTrigger: saveButton.rx.tap.asDriver(),
                                              firstName: firstNameTextField.rx.text.orEmpty.asDriver(),
                                              lastName: lastNameTextField.rx.text.orEmpty.asDriver())
        
        let output = viewModel.transform(input: input)
        
        output.userCreated.drive()
            .addDisposableTo(disposeBag)
        output.saveEnabled.drive(saveButton.rx.isEnabled)
            .addDisposableTo(disposeBag)
    }
}
