//
//  LocalisysChatBubbleMessage.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public struct LocalisysChatTextBubbleMessageModel: LocalisysChatTextBubbleMessageConvertible {
  public let text: String
  public let timestamp: Date
  public let status: LocalisysChatMessageStatus
}

public class LocalisysChatTextBubbleMessage: LocalisysChatMessageViewModel {

  // MARK: - Public properties

  public let messageModel: LocalisysChatTextBubbleMessageConvertible

  // MARK: - Lifecycle

  init(_ model: LocalisysChatTextBubbleMessageConvertible) {
    self.messageModel = model
  }

  // MARK: - LocalisysChatMessageViewModel

  public var messageClass: AnyClass { return LocalisysChatTextBubbleMessageView.self }

  public func configure(_ messageView: LocalisysChatMessageView) {
    guard let textBubbleMessage = messageView as? LocalisysChatTextBubbleMessageView else { return }
    textBubbleMessage.owner = Bool(NSNumber(value: arc4random() % 2)) ? .me : .stranger
    textBubbleMessage.fill(messageModel)
  }
}
