//
//  LocalisysChatBubbleMessage.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public class LocalisysChatTextBubbleMessage: LocalisysChatMessageViewModel {

  // MARK: - Public properties

  public let text: String //complicated structure

  // MARK: - Lifecycle

  init(message: String) {
    text = message
  }

  // MARK: - LocalisysChatMessageViewModel

  public var messageClass: AnyClass { return LocalisysChatTextBubbleMessageView.self }

  public func configure(_ messageView: LocalisysChatMessageView) {
    guard let textBubbleMessage = messageView as? LocalisysChatTextBubbleMessageView else { return }
    textBubbleMessage.owner = Bool(NSNumber(value: arc4random() % 2)) ? .me : .stranger
    textBubbleMessage.fill(textMessage: text)
  }
}
