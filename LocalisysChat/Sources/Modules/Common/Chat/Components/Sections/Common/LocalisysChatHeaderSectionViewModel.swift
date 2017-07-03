//
//  MessageSectionViewModel.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import Foundation

public protocol LocalisysChatHeaderSectionViewModel: LocalisysChatReusable {
  var sectionClass: AnyClass { get }
  func configure(_ headerSectionView: LocalisysChatHeaderSectionView)
}

extension LocalisysChatHeaderSectionViewModel {
  public var reuseIdentifier: String { return String(describing: sectionClass) }
}
