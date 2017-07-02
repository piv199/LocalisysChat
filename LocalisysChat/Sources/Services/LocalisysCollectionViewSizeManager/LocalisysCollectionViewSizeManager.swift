//
//  LocalisysCollectionViewSizeManager.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/1/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public struct LocalisysCollectionCellSizeCofiguration {

}

public final class LocalisysCollectionCellSizeManager {

  public typealias Cell = UICollectionViewCell

  fileprivate var templateCells = [String: Cell]()

  // MARK: - Lifecycle

  public init() {

  }

  // MARK: - Setup & Configuration

  // MARK: - Public methods

  public func cellSize(with identifier: String,
                       indexPath: IndexPath,
                       configuration: (Cell) -> (Void)) -> CGSize {
    return .zero
  }

  public func cellHeight(with identifier: String,
                         indexPath: IndexPath,
                         fixedWidth: CGFloat,
                         configuration: (Cell) -> (Void)) -> CGFloat {
    return 0.0
  }



}
