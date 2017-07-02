//
//  LocalisysChatTextBubbleMessageView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/1/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

public class LocalisysChatTextBubbleMessageView: LocalisysChatBubbleMessageView {

  //MARK: - UI

  fileprivate lazy var textLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 12, weight: 0)
    label.numberOfLines = 0
    return label
  }()

  fileprivate lazy var textView: UITextView = {
    let textView = UITextView()
    textView.font = UIFont.systemFont(ofSize: 12, weight: 0)
    textView.isScrollEnabled = false
    textView.isEditable = false
    textView.backgroundColor = .clear
    return textView
  }()

  override func setupMainView() {
    mainView.addSubview(textView)
  }

  // MARK: - Core Properties

  func fill(textMessage text: String) {
    textView.text = text
  }

  func fill(attributedTextMessage text: NSAttributedString) {
    textView.attributedText = text
  }

  //MARK: - Layout

  override func mainViewSizeFitting(size: CGSize) -> CGSize {
    let textLabelSize = textView.sizeThatFits(size)
    let boundingRect = (textView.text as NSString).boundingRect(with: CGSize.init(width: size.width, height: .greatestFiniteMagnitude),
                                                                options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                                attributes: [NSFontAttributeName: textView.font!],
                                                                context: nil)
    let numberOfLines = boundingRect.height / textView.font!.lineHeight
    print("NumberOflines = \(numberOfLines)")
//    print("Asking for mainView estimated size with size \(size), got = \(textLabelSize), text = \(textView.text!)")
    return CGSize(width: numberOfLines <= 1 ? textLabelSize.width : size.width, height: textLabelSize.height)
  }

  public override func layoutSubviews() {
    super.layoutSubviews()
    textView.frame = mainView.bounds
  }

}
