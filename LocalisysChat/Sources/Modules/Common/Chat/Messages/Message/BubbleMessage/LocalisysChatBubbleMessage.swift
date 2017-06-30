//
//  LocalisysChatBubbleMessage.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import Foundation

public class LocalisysChatTextBubbleMessage: LocalisysChatMessageViewModel {

  // MARK: - Public properties

  public let text: String //complicated structure

  // MARK: - Lifecycle

  init(message: String) {
    text = message
  }

  // MARK: - LocalisysChatMessageViewModel

  public var reuseIdentifier: String { return "LocalisysChatBubbleMessageView" }

  public func configure(_ messageView: LocalisysChatMessageView) {
    guard let textBubbleMessage = messageView as? LocalisysChatBubbleMessageView else { return }
    textBubbleMessage.fill(text)
  }

}
