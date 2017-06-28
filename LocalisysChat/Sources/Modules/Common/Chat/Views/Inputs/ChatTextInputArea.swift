//
//  ChatTextInputArea.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/28/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

final class ChatTextInputArea: AutoTextView {

  // MARK: - Lifecycle

  override init(frame: CGRect = .zero, textContainer: NSTextContainer? = nil) {
    super.init(frame: frame, textContainer: textContainer)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  // MARK: - Setup & Configuration

  fileprivate func setup() {
    placeholderColor = UIColor(white: 0.48, alpha: 1.0)
    placeholder = "Enter message"
    font = UIFont.systemFont(ofSize: 11.0)
    textColor = UIColor(white: 0.12, alpha: 1.0)
    maxNumberOfLines = 4 //6(iPhone) or 8(for ipads)
    backgroundColor = .clear
    textContainerInset = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
  }

}
