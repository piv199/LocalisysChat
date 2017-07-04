//
//  LocalisysChatStatusViewTimeLabel.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/4/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

open class LocalisysChatStatusViewTimeLabel: UILabel {

  //MARK: - Lifecycle

  public init(title: String) {
    super.init(frame: .zero)
    self.text = title
    sizeToFit()
    setupInitialState()
  }

  public override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    setupInitialState()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
  }

  //MARK: - Setup & Configuration

  fileprivate func setupInitialState() {
//    textColor = UIColor(red: 93.0 / 255.0, green: 179.0 / 255.0, blue: 1.0, alpha: 1.0)
    textColor = UIColor(white: 0.48, alpha: 1.0)
    font = UIFont.systemFont(ofSize: 8.0)
  }
}
