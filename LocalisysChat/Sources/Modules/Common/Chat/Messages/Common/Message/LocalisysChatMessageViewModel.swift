//
//  MessageViewModel.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import Foundation

@objc public protocol LocalisysChatMessageViewModel: LocalisysChatReusable {
  func configure(_ messageView: LocalisysChatMessageView)
}
