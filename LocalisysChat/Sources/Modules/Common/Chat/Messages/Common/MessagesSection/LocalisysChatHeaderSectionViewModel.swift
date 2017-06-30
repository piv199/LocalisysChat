//
//  MessageSectionViewModel.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import Foundation

@objc public protocol LocalisysChatHeaderSectionViewModel: LocalisysChatReusable {
  func configure(_ headerSectionView: LocalisysChatHeaderSectionView)
}
