//
//  LocalisysChatView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

@IBDesignable
final class LocalisysChatView: UIView {

  // MARK: - UI

  lazy var messagesCollectionView: ChatMessagesView = ChatMessagesView()
  lazy var delimiterView: UIView = {
    let delimiterView = UIView()
    delimiterView.frame = CGRect(origin: .zero, size: CGSize(width: self.bounds.width, height: 0.5))
    delimiterView.backgroundColor = UIColor(red: 154.0 / 255.0, green: 205.0 / 255.0, blue: 1.0, alpha: 1.0)
    return delimiterView
  }()
  lazy var toolbarView: ChatToolbarView = {
    let toolbarView = ChatToolbarView()
    self.textArea.textViewDelegate = self
    self.textArea.delegate = self
    return toolbarView
  }()
  var textArea: AutoTextView { return toolbarView.textArea }
  var sendButton: ChatSendButton { return toolbarView.sendButton }

  // MARK: - Core properties

  fileprivate var isActive: Bool = false {
    didSet { setNeedsDisplay() }
  }

  // MARK: - Public properties

  public weak var delegate: LocalisysChatViewDelegate?
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

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
  }

  // MARK: - Setup & Configuration

  fileprivate func setupInitialState() {
    [messagesCollectionView, toolbarView, delimiterView].forEach(addSubview)
    sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
  }

  //MARK: - Actions

  func sendMessage() {
    delegate?.chatSendMessage(textArea.text)
  }

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    let toolbarSize = toolbarView.sizeThatFits(bounds.size)
    var currentMaxY = bounds.height - toolbarSize.height
    toolbarView.frame = CGRect(x: 0, y: currentMaxY, width: bounds.width, height: toolbarSize.height)
    currentMaxY -= delimiterHeight
    delimiterView.frame = CGRect(x: 0, y: currentMaxY, width: bounds.width, height: delimiterHeight)
    messagesCollectionView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: currentMaxY)
    toolbarView.layoutSubviews()
  }

  override func draw(_ rect: CGRect) {
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
  func textViewHeightChanged(textView: AutoTextView, newHeight: CGFloat) {
    layoutSubviews()
  }

  func textViewDidChange(_ textView: UITextView) {
    sendButton.isEnabled = delegate?.chatCanSendMessage(textView.text) ?? true
  }

  func textViewDidBeginEditing(_ textView: UITextView) {
    isActive = true
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    isActive = false
  }
}



