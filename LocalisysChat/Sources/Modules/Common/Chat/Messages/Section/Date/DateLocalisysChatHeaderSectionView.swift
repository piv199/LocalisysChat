//
//  DateMessagesSectionView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

@IBDesignable
public final class DateLocalisysChatHeaderSectionView: LocalisysChatHeaderSectionView {

  // MARK: - UI

  fileprivate lazy var substrateView: UIView = {
    let substrateView = UIView()
    substrateView.backgroundColor = UIColor(white: 0.12, alpha: 0.5)
    return substrateView
  }()

  fileprivate lazy var dateLabel: UILabel = {
    let dateLabel = UILabel()
    dateLabel.font = UIFont.systemFont(ofSize: 8.0)
    dateLabel.textColor = UIColor(white: 0.96, alpha: 1.0)
    return dateLabel
  }()

  // MARK: - Public properties

  @IBInspectable
  public var dateText: String {
    get { return dateLabel.text ?? "" }
    set { dateLabel.text = dateText }
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
    backgroundColor = .red
    [substrateView].forEach(addSubview)
     substrateView.addSubview(dateLabel)
  }

  // MARK: - Layout

  public override func sizeThatFits(_ size: CGSize) -> CGSize {
    print("sizeThatFits(_ size: \(size) is called")
    return size
  }

  override public func layoutSubviews() {
    super.layoutSubviews()
    dateLabel.sizeToFit()
    substrateView.frame = CGRect(x: (bounds.width - dateLabel.bounds.width) / 2.0,
                                 y: max(0, (bounds.height - dateLabel.bounds.height) / 2.0),
                                 width: dateLabel.bounds.width,
                                 height: min(dateLabel.bounds.height, bounds.height))
  }

}
