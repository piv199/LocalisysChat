//
//  ChatMessagesView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/28/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

protocol ChatMessagesProvider: class {
  //
}

final class ChatMessagesView: UICollectionView {

  // MARK: - Core properties

  weak var messagesProvider: ChatMessagesProvider? {
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
