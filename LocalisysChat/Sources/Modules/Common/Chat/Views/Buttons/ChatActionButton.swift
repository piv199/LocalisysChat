//
//  ChatAdditionButtonConvertible.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/27/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public enum ChatActionButtonType {
  case primary, normal, cancel, destructive
}

public class ChatActionButton: UIButton {

  // MARK: - Core properties

  public var type: ChatActionButtonType = .normal {
    didSet { configure() }
  }

  public override var isHighlighted: Bool {
    didSet { backgroundColor = isHighlighted ? type.backgroundColor.withAlphaComponent(0.5) : type.backgroundColor }
  }

  //MARK: - Lifecycle

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
  }

  public init(title: String, type: ChatActionButtonType = .normal, frame: CGRect = .zero) {
    super.init(frame: frame)
    self.type = type
    setTitle(title, for: .normal)
    setupUI()
  }

  //MARK: - Setup & Configure

  fileprivate func setupUI() {
    layer.masksToBounds = false
    configure()
  }

  fileprivate func configure() {
    backgroundColor = type.backgroundColor
    setTitleColor(type.textColor, for: .normal)
    setTitleColor(type.textColor.withAlphaComponent(0.4), for: .highlighted)
    titleLabel?.font = type.textFont
    contentEdgeInsets = UIEdgeInsets(top: 6, left: 12, bottom: 6, right: 12)
    layer.borderColor = type.borderColor.cgColor
    layer.borderWidth = type.borderWidth
    layer.shouldRasterize = true
    layer.rasterizationScale = UIScreen.main.scale
    layer.shadowColor = type.shadowColor?.cgColor
    layer.shadowOpacity = type.shadowOpacity
    layer.shadowOffset = type.shadowOffset
    layer.shadowRadius = type.shadowBlur
  }

  //MARK: - Layout

  public override func layoutSubviews() {
    super.layoutSubviews()
    layer.cornerRadius = min(bounds.width, bounds.height) / 2.0
  }

}

//MARK: - ChatActionButton Appearence

extension ChatActionButtonType {
  fileprivate var backgroundColor: UIColor {
    switch self {
    case .normal, .cancel: return .clear
    case .primary: return UIColor(red: 93 / 255.0, green: 170 / 255.0, blue: 1.0, alpha: 1.0)
    case .destructive: return UIColor(red: 242 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1.0)
    }
  }

  fileprivate var textColor: UIColor {
    switch self {
    case .primary, .destructive: return UIColor(white: 0.96, alpha: 1.0)
    case .normal: return UIColor(red: 93 / 255.0, green: 179 / 255.0, blue: 1.0, alpha: 1.0)
    case .cancel: return UIColor(red: 242 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1.0)
    }
  }

  fileprivate var textFont: UIFont {
    return UIFont.systemFont(ofSize: 15.0, weight: 0)
  }

  fileprivate var borderColor: UIColor {
    switch self {
    case .primary, .destructive: return .clear
    case .normal: return UIColor(red: 93 / 255.0, green: 179 / 255.0, blue: 1.0, alpha: 1.0)
    case .cancel: return UIColor(red: 242 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1.0)
    }
  }

  fileprivate var borderWidth: CGFloat {
    switch self {
    case .primary, .destructive: return 0.0
    case .normal, .cancel: return 1.0
    }
  }

  fileprivate var shadowColor: UIColor? {
    switch self {
    case .normal, .cancel: return nil
    case .primary: return UIColor(red: 93 / 255.0, green: 170 / 255.0, blue: 1.0, alpha: 1.0)
    case .destructive: return UIColor(red: 242 / 255.0, green: 80 / 255.0, blue: 80 / 255.0, alpha: 1.0)
    }
  }

  fileprivate var shadowOffset: CGSize { return .zero }
  fileprivate var shadowOpacity: Float { return 0.5 }
  fileprivate var shadowBlur: CGFloat { return 10.0 }
}
