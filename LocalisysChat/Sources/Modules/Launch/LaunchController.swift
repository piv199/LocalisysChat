//
//  LaunchController.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseAuth

final class LaunchController: UIViewController {

  fileprivate var isUserAuthenticated: Bool { return Auth.auth().currentUser != nil }

  // MARK: - Lifecycle

  deinit { print("\(String(describing: self)) deinit") }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if isUserAuthenticated { showScreen(identifier: "Main") }
    else { showScreen(identifier: "Auth")  }
  }

  fileprivate func showScreen(identifier: String) {
    performSegue(withIdentifier: identifier, sender: self)
  }

}
