//
//  LocalisysChatView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

@IBDesignable
public class LocalisysChatView: UIView {

  // MARK: - UI

  lazy var messagesCollectionView: LocalisysChatMessagesView = LocalisysChatMessagesView()
  lazy var delimiterView: UIView = {
    let delimiterView = UIView()
    delimiterView.frame = CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: 0.5))
    delimiterView.backgroundColor = UIColor(red: 154.0 / 255.0, green: 205.0 / 255.0, blue: 1.0, alpha: 1.0)
    return delimiterView
  }()
  lazy var toolbarView: LocalisysChatToolbarView = LocalisysChatToolbarView()
  var textArea: AutoTextView { return toolbarView.textArea }
  var sendButton: ChatSendButton { return toolbarView.sendButton }

  // MARK: - Core properties

  fileprivate var isActive: Bool = false {
    didSet { setNeedsDisplay() }
  }

  // MARK: - Public properties

  public weak var delegate: LocalisysChatViewDelegate?
  public var messagesProvider: LocalisysChatMessagesProvider? {
    get { return messagesCollectionView.messagesProvider }
    set { messagesCollectionView.messagesProvider = newValue }
  }

//  public weak var dataSourcce:

  @IBInspectable var chatColor: UIColor = UIColor(red: 194.0 / 255.0, green: 224.0 / 255.0, blue: 1.0, alpha: 1.0) {
    didSet { setNeedsDisplay() }
  }

  @IBInspectable var chatRoundedRadius: CGFloat = 12.5 {
    didSet { if !isActive { setNeedsDisplay() } }
  }

  //MARK: Delimiter

  @IBInspectable var delimiterColor: UIColor {
    get { return delimiterView.backgroundColor ?? .clear }
    set { delimiterView.backgroundColor = newValue  }
  }

  @IBInspectable var delimiterHeight: CGFloat {
    get { return delimiterView.frame.height }
    set {
      delimiterView.frame.size = CGSize(width: delimiterView.frame.width, height: newValue)
      layoutIfNeeded()
    }
  }

  // MARK: - Lifecycle

  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    setupInitialState()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
  }

  // MARK: - Setup & Configuration

  fileprivate func setupInitialState() {
    [messagesCollectionView, toolbarView, delimiterView].forEach(addSubview)
    textArea.textViewDelegate = self
    textArea.delegate = self
    sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
  }

  //MARK: - Actions

  func sendMessage() {
    delegate?.chatSendMessage(textArea.text)
  }

  // MARK: - Layout

  override public func layoutSubviews() {
    super.layoutSubviews()
    let toolbarSize = toolbarView.sizeThatFits(bounds.size)
    var currentMaxY = bounds.height - toolbarSize.height
    toolbarView.frame = CGRect(x: 0, y: currentMaxY, width: bounds.width, height: toolbarSize.height)
    currentMaxY -= delimiterHeight
    delimiterView.frame = CGRect(x: 0, y: currentMaxY, width: bounds.width, height: delimiterHeight)
    messagesCollectionView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: currentMaxY)
    toolbarView.layoutSubviews()
  }

  override public func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let canvas = UIGraphicsGetCurrentContext() else { return }
    let roundRadius = isActive ? 0.0 : chatRoundedRadius
    let chatToolbarForegroundPath = UIBezierPath(roundedRect: bounds,
                                                 byRoundingCorners: [.bottomLeft, .bottomRight],
                                                 cornerRadii: CGSize(width: roundRadius, height: roundRadius))
    canvas.setFillColor(chatColor.cgColor)
    chatToolbarForegroundPath.fill()
  }
}

extension LocalisysChatView: AutoTextViewDelegate {
  public func textViewHeightChanged(textView: AutoTextView, newHeight: CGFloat) {
    layoutSubviews()
  }

  public func textViewDidChange(_ textView: UITextView) {
    sendButton.isEnabled = delegate?.chatCanSendMessage(textView.text) ?? true
  }

  public func textViewDidBeginEditing(_ textView: UITextView) {
    isActive = true
  }

  public func textViewDidEndEditing(_ textView: UITextView) {
    isActive = false
  }
}



