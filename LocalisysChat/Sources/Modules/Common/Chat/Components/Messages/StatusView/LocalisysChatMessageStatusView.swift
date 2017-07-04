//
//  LocalisysChatMessageStatusView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/3/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

open class LocalisysChatMessageStatusView: UIView {

  open func setSubviews(_ subviews: [UIView]) {
    self.subviews.forEach { $0.removeFromSuperview() }
    subviews.forEach(addSubview)
  }

  // MARK: - Layout

  //Actual size is the sum of width and max height across displayedViews.

  open override func sizeToFit() {
    layoutSubviews()
    super.sizeToFit()
  }

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    var totalWidth: CGFloat = 0.0, maxHeight: CGFloat = 0.0
    subviews.forEach { (view) in
      let estimatedViewSize = view.sizeThatFits(size)
      totalWidth += estimatedViewSize.width
      maxHeight = (maxHeight < estimatedViewSize.height) ? estimatedViewSize.height : maxHeight
    }
    return CGSize(width: totalWidth, height: maxHeight)
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    _ = subviews.reduce(CGFloat(0.0)) { (currentX, currentView) -> CGFloat in
      let estimatedCurrentViewSize = currentView.sizeThatFits(bounds.size)
      currentView.frame = CGRect(x: currentX, y: bounds.height - estimatedCurrentViewSize.height,
                                 width: estimatedCurrentViewSize.width, height: estimatedCurrentViewSize.height)
      return currentX + estimatedCurrentViewSize.width
    }
  }
}
