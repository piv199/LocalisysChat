//
//  DateLocalisysChatHeaderSectionViewModel.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/30/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public final class DateLocalisysChatHeaderSection: LocalisysChatHeaderSectionViewModel {

  //MARK: - Public properties

  public let dateTitle: String

  // MARK: - Lifecycle

  public init(dateTitle: String) {
    self.dateTitle = dateTitle
  }

  // MARK: - LocalisysChatHeaderSectionViewModel

  public var reuseIdentifier: String { return "DateLocalisysChatHeaderSectionView" }

  public func configure(_ headerSectionView: LocalisysChatHeaderSectionView) {
    guard let dateHeaderSectionView = headerSectionView as? DateLocalisysChatHeaderSectionView else { return }
    dateHeaderSectionView.dateText = dateTitle
  }

}
