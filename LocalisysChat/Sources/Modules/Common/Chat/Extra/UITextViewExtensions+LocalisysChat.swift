//
//  UITextViewExtensions+LocalisysChat.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 7/5/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit
import CoreText

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

  func lines(allowedWidth width: CGFloat) -> [String] {
    guard !text.isEmpty else { return [] }
    guard let font = self.font else { return [] }
    let ctFont = CTFontCreateWithName(font.fontName as CFString, font.pointSize, nil)
    let attrText = NSMutableAttributedString(string: text)
    attrText.addAttribute(kCTFontAttributeName as String, value: ctFont, range: NSRange(location: 0, length: attrText.length))

    let frameSetter = CTFramesetterCreateWithAttributedString(attrText)

    let path = CGMutablePath()
    path.addRect(.init(x: 0, y: 0, width: width - 1.5 * textContainerInset.horizontal, height: .greatestFiniteMagnitude))
    let frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, nil)

    let lines = CTFrameGetLines(frame) as! [CTLine]
    var resultLines = [String]()

    for line in lines {
      let lineRange = CTLineGetStringRange(line)
      let range = NSRange.init(location: lineRange.location, length: lineRange.length)
      let lineString = (text as NSString).substring(with: range)

      CFAttributedStringSetAttribute(attrText, lineRange, kCTKernAttributeName, NSNumber(value: 0))
      CFAttributedStringSetAttribute(attrText, lineRange, kCTKernAttributeName, NSNumber(value: 0))

      resultLines.append(lineString)
    }
    return resultLines
  }

}
