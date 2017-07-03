//
//  LocalisysChatViewDelegate.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/28/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public protocol LocalisysChatViewDelegate: class {
  // Required

  func chatSendMessage(_ message: String)

  // Optional

  func chatCanSendMessage(_ message: String) -> Bool
}

extension LocalisysChatViewDelegate {
  func chatCanSendMessage(_ message: String) -> Bool { return true }
}
