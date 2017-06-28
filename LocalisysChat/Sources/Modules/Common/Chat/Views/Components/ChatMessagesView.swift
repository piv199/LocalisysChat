//
//  ChatMessagesView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/28/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

@objc protocol LocalisysChatMessagesProvider: class {
  //
}

final class ChatMessagesView: UICollectionView {

  // MARK: - Core properties

  @objc public weak var messagesProvider: LocalisysChatMessagesProvider? {
    didSet { reloadData() }
  }

  // MARK: - Lifecycle

  override init(frame: CGRect = .zero, collectionViewLayout layout: UICollectionViewLayout = UICollectionViewFlowLayout()) {
    super.init(frame: frame, collectionViewLayout: layout)
    setupInitialState()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
  }

  // MARK: - Setup & Configurations

  fileprivate func setupInitialState() {
    backgroundColor = .clear
  }

  override func reloadData() {
    guard messagesProvider != nil else {
      fatalError("\(String(describing: self)) must have \(#keyPath(messagesProvider)) properly set up before displaying messages!")
    }
    super.reloadData()
  }
}

extension ChatMessagesView: UICollectionViewDataSource {

  override var numberOfSections: Int { return 0 }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 0
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }

}

extension ChatMessagesView: UICollectionViewDelegate {

}

extension ChatMessagesView: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

  }
}
