//
//  SignInViewController.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseAuth

final class SignInViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    Auth.auth().addStateDidChangeListener { [unowned self] (auth, user) in
      guard user != nil else { return }
      self.performSegue(withIdentifier: "Main", sender: self)
    }
    Auth.auth().signIn(withEmail: "piv199@hotmail.com", password: "123456")
  }

}
