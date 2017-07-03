//
//  LocalisysChatTextBubbleMessageView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/1/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public class LocalisysChatTextBubbleMessageView: LocalisysChatBubbleMessageView {

  // MARK: - UI

  fileprivate lazy var textMessageMainView: LocalisysChatTextBubbleMessageMainView = LocalisysChatTextBubbleMessageMainView()

  //MARK: - Lifecycle

  public override init(frame: CGRect = .zero) {
    super.init(mainView: textMessageMainView, frame: frame)
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    mainView = textMessageMainView
  }

  // MARK: - Setup & Configuration

  func fill(textMessage text: String) {
    textMessageMainView.fill(text: text)
    layoutSubviews()
  }

  func fill(attributedTextMessage text: NSAttributedString) {
    textMessageMainView.fill(attributedText: text)
    layoutSubviews()
  }
}
