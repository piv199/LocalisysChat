//
//  MessageViewModel.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import Foundation

public protocol LocalisysChatMessageViewModel: LocalisysChatReusable {
  var messageClass: AnyClass { get }
  func configure(_ messageView: LocalisysChatMessageView)
}

extension LocalisysChatMessageViewModel {
  public var reuseIdentifier: String { return String(describing: messageClass) }
}
