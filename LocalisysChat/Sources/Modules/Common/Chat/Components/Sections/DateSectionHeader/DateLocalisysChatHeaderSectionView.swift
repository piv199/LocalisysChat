//
//  DateMessagesSectionView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

extension UIEdgeInsets {
  public var horizontal: CGFloat { return left + right }
  public var vertical: CGFloat { return top + bottom }
}

@IBDesignable
public final class DateLocalisysChatHeaderSectionView: LocalisysChatHeaderSectionView {

  public dynamic var outerInsets = UIEdgeInsets(top: 3.0, left: 0.0, bottom: 3.0, right: 0.0)
  public dynamic var innerInsets = UIEdgeInsets(top: 1.0, left: 12.0, bottom: 1.0, right: 12.0)
  fileprivate var totalInsets: UIEdgeInsets { return outerInsets + innerInsets }

  // MARK: - UI

  fileprivate lazy var dateLabel: UILabel = {
    let dateLabel = UILabel()
    dateLabel.font = UIFont.systemFont(ofSize: 8.0)
    dateLabel.textColor = UIColor(white: 0.96, alpha: 1.0)
    dateLabel.textAlignment = .center
    return dateLabel
  }()

  // MARK: - Public properties

  dynamic public var substrateColor = UIColor(white: 0.12, alpha: 0.5) {
    didSet { setNeedsDisplay() }
  }

  @IBInspectable public var dateText: String {
    get { return dateLabel.text ?? "" }
    set { dateLabel.text = newValue }
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
    backgroundColor = .clear
    [dateLabel].forEach(addSubview)
  }

  // MARK: - Methods

  public func fill(title: String) {
    dateText = title
  }

  // MARK: - Layout

  public override func sizeThatFits(_ size: CGSize) -> CGSize {
    dateLabel.sizeToFit()
    return CGSize(width: dateLabel.bounds.width + totalInsets.horizontal,
                  height: dateLabel.bounds.height + totalInsets.vertical)
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    dateLabel.sizeToFit()
    dateLabel.frame = CGRect(x: (bounds.width - dateLabel.bounds.width) / 2.0,
                             y: (bounds.height - totalInsets.vertical) / 2.0,
                             width: dateLabel.bounds.width, height: dateLabel.bounds.height)
    setNeedsDisplay()
  }

  // MARK: - Drawing

  public override func draw(_ rect: CGRect) {
    super.draw(rect)
    guard let canvas = UIGraphicsGetCurrentContext() else { return }
    drawSubstrate(canvas: canvas)
  }

  fileprivate func drawSubstrate(canvas: CGContext) {
    let substrateRect = CGRect(x: dateLabel.frame.origin.x - innerInsets.left,
                               y: dateLabel.frame.origin.y - innerInsets.top,
                               width: dateLabel.frame.width + innerInsets.horizontal,
                               height: dateLabel.frame.height + innerInsets.vertical)
    let substratePath = UIBezierPath(roundedRect: substrateRect,
                                     cornerRadius: min(substrateRect.width, substrateRect.height) / 2.0)
      .cgPath
    canvas.addPath(substratePath)
    canvas.setFillColor(substrateColor.cgColor)
    canvas.fillPath()
  }
}
