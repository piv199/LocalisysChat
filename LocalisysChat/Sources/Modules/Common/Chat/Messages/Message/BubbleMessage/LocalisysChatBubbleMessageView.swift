//
//  LocalisysChatBubbleMessageView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public enum LocalisysChatMessageOwner {
  case me, stranger
}

public class LocalisysChatBubbleMessageView: LocalisysChatMessageView {

  //MARK: - Public properties

  public var owner: LocalisysChatMessageOwner = .me {
    didSet { layoutSubviews() }
  }

  // MARK: - Setup & Configuration

  public func fill(_ message: String) {
    print("LocalisysChatBubbleMessageView filled with '\(message)'")
  }

}

