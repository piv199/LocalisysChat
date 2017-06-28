//
//  MainViewController.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseDatabase

final class MainViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
  }

  func viewTapped() {
    view.endEditing(true)
  }

}
