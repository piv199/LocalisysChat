//
//  ToolbarView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

final class ChatToolbarView: UIView {

  // MARK: - UI

  internal lazy var textArea: AutoTextView = ChatTextInputArea()
  internal var actionButtons: [ChatActionButton] = []
  internal lazy var sendButton: ChatSendButton = ChatSendButton()

  // MARK: - Properties

  fileprivate var isInWriteMode: Bool { return !textArea.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty }

  // MARK: - Lifecycle

  override init(frame: CGRect = .zero) {
    super.init(frame: frame)
    setupUI()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
  }

  fileprivate func setupUI() {
    backgroundColor = .clear
    [[textArea, sendButton], actionButtons].flatten().forEach(addSubview)
  }

  // MARK: - Actions

  // MARK: - Layout

  override func layoutSubviews() {
    super.layoutSubviews()
    [[sendButton], actionButtons].flatten().forEach { (view: UIView) in view.sizeToFit() }

    var currentMaxX = bounds.width - 24.0
    let minHeight: CGFloat = 44.0
    if isInWriteMode || actionButtons.count == 0 {
      currentMaxX -= sendButton.bounds.width
      sendButton.frame = CGRect(origin: .init(x: bounds.width - 24.0 - sendButton.bounds.width,
                                              y: (bounds.height - minHeight) + (minHeight - sendButton.bounds.height) / 2.0),
                                size: sendButton.bounds.size)
      actionButtons.forEach { $0.isHidden = true }
      sendButton.isHidden = false
      currentMaxX -= 12.0
//      sendButton.isEnabled = isInWriteMode
    } else {
      for additionButton in actionButtons {
        currentMaxX -= additionButton.bounds.width

        additionButton.frame = CGRect(x: currentMaxX,
                                      y: (bounds.height - minHeight) + (minHeight - additionButton.bounds.height) / 2.0,
                                      width: additionButton.bounds.width,
                                      height: additionButton.bounds.height)
        currentMaxX -= 12.0
      }
      sendButton.isHidden = true
      actionButtons.forEach { $0.isHidden = false }
    }

    let textAreaWidth = currentMaxX - 24.0
    let textAreaHeight = textArea.expectedHeight

    textArea.frame = CGRect(x: 24.0, y: (bounds.height - textAreaHeight) / 2.0,
                            width: textAreaWidth, height: textAreaHeight)
  }

  override func sizeThatFits(_ size: CGSize) -> CGSize {
    return .init(width: size.width, height: max(min(textArea.expectedHeight, size.height), 44.0))
  }

}

