//
//  LocalisysChatTextBubbleMessageView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/1/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit
import CoreText

public enum LocalisysChatMessageStatus {
  case sent, delivered, error, none
}

public protocol LocalisysChatMessageConvertible {
  var timestamp: Date { get }
  var status: LocalisysChatMessageStatus { get }
}

public protocol LocalisysChatTextBubbleMessageConvertible: LocalisysChatMessageConvertible {
  var text: String { get }
}

public class LocalisysChatTextBubbleMessageView: LocalisysChatBubbleMessageView {

  // MARK: - UI

  fileprivate lazy var textMessageMainView: LocalisysChatTextBubbleMessageMainView = LocalisysChatTextBubbleMessageMainView()

  //MARK: - Lifecycle

  public override init(frame: CGRect = .zero) {
    super.init(mainView: textMessageMainView, frame: frame)
    setupInitialState()
//    clipsToBounds = true
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
    mainView = textMessageMainView
  }

  fileprivate func setupInitialState() {
    textMessageMainView.statusView = statusView
  }

  // MARK: - Setup & Configuration

  func fill(_ model: LocalisysChatTextBubbleMessageConvertible) {
    textMessageMainView.fill(text: model.text)
    statusView.setSubviews([LocalisysChatStatusViewTimeLabel(title: model.timestamp.description)])
//    layoutSubviews()
  }

}
