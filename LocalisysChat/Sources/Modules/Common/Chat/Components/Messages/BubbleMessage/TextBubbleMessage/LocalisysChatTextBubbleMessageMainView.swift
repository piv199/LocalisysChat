//
//  LocalisysChatTextBubbleMessageMainView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/3/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

open class LocalisysChatTextBubbleMessageMainView: LocalisysChatBubbleMessageMainView {

  public dynamic var textInsets = UIEdgeInsets(top: 3.0, left: 12.0, bottom: 3.0, right: 12.0) {
    didSet { textArea.textContainerInset = textInsets }
  }

  // MARK: - UI

  lazy var textArea: UITextView = {
    let textView = UITextView()
    textView.backgroundColor = .clear
    textView.font = UIFont.systemFont(ofSize: 12)
    textView.textColor = UIColor(white: 0.12, alpha: 1.0)
    textView.isUserInteractionEnabled = false
    textView.textContainerInset = self.textInsets
    return textView
  }()

  internal var statusView: LocalisysChatMessageStatusView! {
    willSet { statusView?.removeFromSuperview() }
    didSet { addSubview(statusView) }
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

  // MARK: - Setup & Configuration

  fileprivate func setupInitialState() {
    addSubview(textArea)
//    backgroundColor = .yellow
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
    let estimatedStatusViewSize = statusView.sizeThatFits(size)

    let textAreaLines = textArea.lines(allowedWidth: size.width)
    let multilineTextArea = textArea.hasMultilineText(with: estimatedTextAreaSize)

    if let lastTextAreaLine = textAreaLines.last {
      let estimatedLastTextAreaLineSize = (lastTextAreaLine as NSString)
        .boundingRect(with: size, options: [], attributes: [NSFontAttributeName: textArea.font!], context: nil)

      let spaceLeft = size.width - estimatedLastTextAreaLineSize.width - textArea.textContainerInset.horizontal - 4.0
      if spaceLeft <= estimatedStatusViewSize.width {
        return CGSize(width: multilineTextArea ? size.width : max(estimatedTextAreaSize.width, estimatedStatusViewSize.width),
                      height: estimatedTextAreaSize.height + estimatedStatusViewSize.height)
      } else {
        return CGSize(width: multilineTextArea ? size.width : estimatedTextAreaSize.width + estimatedStatusViewSize.width,
                      height: estimatedTextAreaSize.height)
      }
    }
    return CGSize(width: multilineTextArea ? size.width : estimatedTextAreaSize.width,
                  height: estimatedTextAreaSize.height + estimatedStatusViewSize.height)
  }

  open override func layoutSubviews() {
    super.layoutSubviews()

    textArea.frame = bounds
    
    let estimatedStatusViewSize = statusView.sizeThatFits(bounds.size)
    statusView.frame = CGRect(x: bounds.width - estimatedStatusViewSize.width - textArea.textContainerInset.right,
                              y: bounds.height - estimatedStatusViewSize.height - 1.0,
                              width: estimatedStatusViewSize.width, height: estimatedStatusViewSize.height)

  }

}

