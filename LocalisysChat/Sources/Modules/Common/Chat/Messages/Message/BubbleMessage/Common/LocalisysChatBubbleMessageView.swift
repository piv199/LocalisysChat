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

fileprivate enum LocalisysChatBubbleAlignment {
  case left, right
}

fileprivate extension LocalisysChatMessageOwner {
  var substrateBackgroundColor: UIColor {
    switch self {
    case .me: return UIColor(red: 93/255.0, green: 179/255.0, blue: 1.0, alpha: 0.5)
    case .stranger: return UIColor(white: 0.83, alpha: 0.5)
    }
  }

  var alignment: LocalisysChatBubbleAlignment {
    switch self {
    case .me: return .right
    case .stranger: return .left
    }
  }
}

public class LocalisysChatBubbleMessageView: LocalisysChatMessageView {

  public dynamic var bubbleMaxWidthPercent: CGFloat = 0.75

  public dynamic var bubbleInsets = UIEdgeInsets(top: 3.0, left: 12.0, bottom: 3.0, right: 12.0)

  // MARK: - UI

  var mainView: LocalisysChatBubbleMessageMainView = LocalisysChatBubbleMessageMainView() {
    didSet {
      oldValue.removeFromSuperview()
      self.addSubview(mainView)
      layoutSubviews()
    }
  }

  // MARK: - Lifecycle

  public override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    setupInitialState()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
  }

  public init(mainView: LocalisysChatBubbleMessageMainView, frame: CGRect = .zero) {
    super.init(frame: frame)
    self.mainView = mainView
    setupInitialState()
  }

  // MARK: - Setup & Configuration

  fileprivate func setupInitialState() {
    backgroundColor = .clear
    addSubview(mainView)
  }

  // MARK: - Public properties

  public var owner: LocalisysChatMessageOwner = .me {
    didSet { layoutSubviews() }
  }

  // MARK: - Layout

  public override func sizeThatFits(_ size: CGSize) -> CGSize {
    let estimatedMainViewSize = mainView.sizeThatFits(.init(width: size.width * bubbleMaxWidthPercent, height: size.height))
    return CGSize(width: estimatedMainViewSize.width + bubbleInsets.horizontal,
                  height: estimatedMainViewSize.height + bubbleInsets.vertical)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    let estimatedMainViewSize = mainView.sizeThatFits(.init(width: bounds.width * bubbleMaxWidthPercent, height: bounds.height))

    let rect: CGRect
    switch owner.alignment {
    case .left: rect = CGRect(x: bubbleInsets.left, y: bubbleInsets.top,
                              width: estimatedMainViewSize.width, height: estimatedMainViewSize.height)
    case .right: rect = CGRect(x: bounds.width - estimatedMainViewSize.width - bubbleInsets.right,
                               y: bubbleInsets.top,
                               width: estimatedMainViewSize.width,
                               height: estimatedMainViewSize.height)
    }
    mainView.frame = rect
    mainView.layoutSubviews()
    setNeedsDisplay()
  }

  // MARK: - Drawing

  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let canvas = UIGraphicsGetCurrentContext() else { return }
    drawSubstrate(canvas: canvas)
  }

  fileprivate func drawSubstrate(canvas: CGContext) {
    let rect: CGRect
    switch owner.alignment {
    case .left: rect = CGRect(x: bubbleInsets.left, y: bubbleInsets.top,
                              width: mainView.bounds.width, height: bounds.height - bubbleInsets.vertical)
    case .right: rect = CGRect(x: bounds.width - bubbleInsets.right - mainView.bounds.width, y: bubbleInsets.top,
                               width: mainView.bounds.width, height: bounds.height - bubbleInsets.vertical)
    }
    canvas.addPath(UIBezierPath(roundedRect: rect, cornerRadius: 12.5).cgPath)
    canvas.setFillColor(owner.substrateBackgroundColor.cgColor)
    canvas.fillPath()
  }
}

extension UIEdgeInsets {
  static func +(_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
    return UIEdgeInsets(top: lhs.top + rhs.top,
                        left: lhs.left + rhs.left,
                        bottom: lhs.bottom + rhs.bottom,
                        right: lhs.right + rhs.right)
  }
}

