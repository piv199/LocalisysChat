//
//  LocalisysChatTextBubbleMessageMainView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/3/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

extension UITextView {
  func hasMultilineText(with size: CGSize) -> Bool {
    let estimatedTextHeight: CGFloat
    if (!text.isEmpty) {
      estimatedTextHeight = (text as NSString)
        .boundingRect(with: size, options: .usesLineFragmentOrigin,
                      attributes: [NSFontAttributeName: font!], context: nil)
        .height
    } else {
      estimatedTextHeight = attributedText
        .boundingRect(with: size, options: .usesLineFragmentOrigin, context: nil)
        .height
    }
    let numberOfLines = estimatedTextHeight / font!.lineHeight
    return numberOfLines > 1.0
  }

}

open class LocalisysChatTextBubbleMessageMainView: LocalisysChatBubbleMessageMainView {

  public dynamic var textInsets = UIEdgeInsets(top: 3.0, left: 12.0, bottom: 3.0, right: 12.0) {
    didSet { textArea.textContainerInset = textInsets }
  }

  // MARK: - UI

  lazy var textArea: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .clear
    textView.isEditable = false
    textView.font = UIFont.systemFont(ofSize: 12)
    textView.textColor = UIColor(white: 0.12, alpha: 1.0)
    textView.isUserInteractionEnabled = false
    textView.textContainerInset = self.textInsets
    return textView
  }()

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
    addSubview(textArea)
  }

  // MARK: - Methods

  open func fill(text: String) {
    textArea.text = text
  }

  open func fill(attributedText: NSAttributedString) {
    textArea.attributedText = attributedText
  }

  // MARK: - Layout

  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    let estimatedTextAreaSize = textArea.sizeThatFits(size)
    return CGSize(width: textArea.hasMultilineText(with: estimatedTextAreaSize) ? size.width : estimatedTextAreaSize.width,
                  height: estimatedTextAreaSize.height)
  }

  open override func layoutSubviews() {
    super.layoutSubviews()
    textArea.frame = bounds
  }

}

