//
//  AppDelegate.swift
//  RxChuckNorris
//
//  Created by sergdort on 15/05/2018.
//  Copyright © 2018 jessapps. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        Application.shared.configureMainInterface(in: window)
        
        self.window = window
        return true
    }

}
