//
//  AppDelegate.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?

  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    IQKeyboardManager.sharedManager().enable = true
    IQKeyboardManager.sharedManager().enableAutoToolbar = false
    IQKeyboardManager.sharedManager().keyboardDistanceFromTextField = 40.0
    return true
  }
}
