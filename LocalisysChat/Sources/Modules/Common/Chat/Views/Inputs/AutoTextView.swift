//
//  ALTextView.swift
//  ALTextInputBar
//
//  Created by Alex Littlejohn on 2015/04/24.
//  Copyright (c) 2015 zero. All rights reserved.
//

import UIKit

public protocol AutoTextViewDelegate: UITextViewDelegate {

  /**
   Notifies the receiver of a change to the contentSize of the textView

   The receiver is responsible for layout

   - parameter textView: The text view that triggered the size change
   - parameter newHeight: The ideal height for the new text view
   */
  func textViewHeightChanged(textView: AutoTextView, newHeight: CGFloat)
}

public class AutoTextView: UITextView {

  // MARK: - Core properties

  fileprivate var textObserver: NSObjectProtocol?

  // MARK: - UI

  fileprivate lazy var placeholderLabel: UILabel = {
    var _placeholderLabel = UILabel()

    _placeholderLabel.clipsToBounds = false
    _placeholderLabel.autoresizesSubviews = false
    _placeholderLabel.numberOfLines = 1
    _placeholderLabel.font = self.font
    _placeholderLabel.backgroundColor = UIColor.clear
    _placeholderLabel.textColor = self.tintColor
    _placeholderLabel.isHidden = true

    self.addSubview(_placeholderLabel)

    return _placeholderLabel
  }()

  // MARK: - Public properties

  override public var font: UIFont? {
    didSet { placeholderLabel.font = font }
  }

  override public var contentSize: CGSize {
    didSet { updateSize() }
  }

  public weak var textViewDelegate: AutoTextViewDelegate? {
    didSet { delegate = textViewDelegate }
  }

  public var placeholder: String = "" {
    didSet { placeholderLabel.text = placeholder }
  }

  /// The color of the placeholder text
  public var placeholderColor: UIColor! {
    get { return placeholderLabel.textColor }
    set { placeholderLabel.textColor = newValue }
  }

  public override var textAlignment: NSTextAlignment {
    get { return super.textAlignment }
    set {
      super.textAlignment = newValue
      placeholderLabel.textAlignment = newValue
    }
  }

  /// The maximum number of lines that will be shown before the text view will scroll. 0 = no limit
  public var maxNumberOfLines: CGFloat = 0
  public fileprivate(set) var expectedHeight: CGFloat = 0 {
    didSet {
      guard oldValue != expectedHeight else { return }
      textViewDelegate?.textViewHeightChanged(textView: self, newHeight: expectedHeight)
    }
  }
  public var minimumHeight: CGFloat {
    get { return ceil(font?.lineHeight ?? 0.0) + textContainerInset.top + textContainerInset.bottom }
  }

  // MARK: - Lifecycle

  override public init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)
    commonInit()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }

  private func commonInit() {
    isScrollEnabled = false
    configureObservers()
    updateSize()
  }

  fileprivate func configureObservers() {
    textObserver = NotificationCenter.default
      .addObserver(forName: NSNotification.Name.UITextViewTextDidChange, object: self, queue: nil) {
        [unowned self] (notification) in
        guard (notification.object as? AutoTextView) == self else { return }
        self.textViewDidChange()
    }
  }

  // MARK: - Layout

  override public func layoutSubviews() {
    super.layoutSubviews()
    placeholderLabel.isHidden = shouldHidePlaceholder()
    if !placeholderLabel.isHidden {
      placeholderLabel.frame = placeholderRectThatFits(rect: bounds)
      sendSubview(toBack: placeholderLabel)
    }
  }

  //MARK: - Sizing and scrolling
  private func updateSize() {
    let maxHeight = maxNumberOfLines > 0
      ? (ceil(font!.lineHeight) * maxNumberOfLines) + textContainerInset.top + textContainerInset.bottom
      : CGFloat.greatestFiniteMagnitude
    let roundedHeight = roundHeight()
    if roundedHeight >= maxHeight {
      expectedHeight = maxHeight
      isScrollEnabled = true
    } else {
      isScrollEnabled = false
      expectedHeight = roundedHeight
    }
    ensureCaretDisplaysCorrectly()
  }

  /**
   Calculates the correct height for the text currently in the textview as we cannot rely on contentsize to do the right thing
   */
  private func roundHeight() -> CGFloat {
    let boundingSize = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
    let size = sizeThatFits(boundingSize)
    return max(ceil(size.height), minimumHeight)
  }

  /**
   Ensure that when the text view is resized that the caret displays correctly withing the visible space
   */
  private func ensureCaretDisplaysCorrectly() {
    guard let range = selectedTextRange else { return }
    DispatchQueue.main.async {
      let rect = self.caretRect(for: range.end)
      UIView.performWithoutAnimation {
        self.scrollRectToVisible(rect, animated: false)
      }
    }
  }

  //MARK: - Placeholder Layout -

  /**
   Determines if the placeholder should be hidden dependant on whether it was set and if there is text in the text view

   - returns: true if it should not be visible
   */
  private func shouldHidePlaceholder() -> Bool {
    return placeholder.characters.count == 0 || text.characters.count > 0
  }

  /**
   Layout the placeholder label to fit in the rect specified

   - parameter rect: The constrained size in which to fit the label
   - returns: The placeholder label frame
   */
  private func placeholderRectThatFits(rect: CGRect) -> CGRect {
    let padding = textContainer.lineFragmentPadding
    var placeHolderRect = UIEdgeInsetsInsetRect(rect, textContainerInset)
    placeHolderRect.origin.x += padding
    placeHolderRect.size.width -= padding * 2
    return placeHolderRect
  }

  //MARK: - Notifications -

  internal func textViewDidChange() {
    placeholderLabel.isHidden = shouldHidePlaceholder()
    updateSize()
  }
}
