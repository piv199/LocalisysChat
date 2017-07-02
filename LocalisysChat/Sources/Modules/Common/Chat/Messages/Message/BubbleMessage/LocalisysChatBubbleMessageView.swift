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
    case .me: return UIColor(red: 93/255.0, green: 179/255.0, blue: 1.0, alpha: 1.0)
    case .stranger: return UIColor(white: 0.93, alpha: 1.0)
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

  public dynamic var maxWidthRatio: CGFloat = 0.8
  public dynamic var contentInsets: UIEdgeInsets = UIEdgeInsets(top: 3.0, left: 12.0, bottom: 3.0, right: 12.0)

  // MARK: - UI

  fileprivate(set) lazy var mainView: UIView = UIView()

  // MARK: - Lifecycle

  public override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    setupInitialState()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
  }

  // MARK: - Setup & Configuration

  fileprivate func setupInitialState() {
    backgroundColor = .red
    addSubview(mainView)
    setupMainView()
  }

  internal func setupMainView() {}

  // MARK: - Public properties

  public var owner: LocalisysChatMessageOwner = .me {
    didSet {
      layoutSubviews()
      setNeedsDisplay()
    }
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
     let estimatedMainViewSize = mainViewSizeFitting(size: CGSize(width: bounds.width * maxWidthRatio,
                                                                  height: bounds.height))
    let rect: CGRect
    switch owner.alignment {
    case .left: rect = CGRect(x: contentInsets.left, y: contentInsets.top,
                              width: estimatedMainViewSize.width,
                              height: bounds.height - contentInsets.bottom - contentInsets.top)
    case .right: rect = CGRect(x: bounds.width - contentInsets.right - estimatedMainViewSize.width, y: contentInsets.top,
                               width: estimatedMainViewSize.width,
                               height: bounds.height - contentInsets.bottom - contentInsets.top)
    }
    mainView.frame = rect
    setNeedsDisplay()
  }


  // MARK: - Layout

  internal func mainViewSizeFitting(size: CGSize) -> CGSize {
    return mainView.sizeThatFits(size)
  }

  public override func sizeThatFits(_ size: CGSize) -> CGSize {
    let estimatedMainViewSize = mainViewSizeFitting(size: CGSize(width: size.width * maxWidthRatio, height: size.height))
    return CGSize(width: size.width, height: estimatedMainViewSize.height + contentInsets.bottom + contentInsets.top)
  }

  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let canvas = UIGraphicsGetCurrentContext() else { return }
    let rect: CGRect
    switch owner.alignment {
    case .left: rect = CGRect(x: contentInsets.left, y: contentInsets.top,
                              width: mainView.bounds.width,
                              height: bounds.height - contentInsets.bottom - contentInsets.top)
    case .right: rect = CGRect(x: bounds.width - contentInsets.right - mainView.bounds.width, y: contentInsets.top,
                               width: mainView.bounds.width,
                               height: bounds.height - contentInsets.bottom - contentInsets.top)
    }
    canvas.addPath(UIBezierPath(roundedRect: rect, cornerRadius: 12.5).cgPath)
    canvas.setFillColor(owner.substrateBackgroundColor.cgColor)
    canvas.fillPath()
  }
}

