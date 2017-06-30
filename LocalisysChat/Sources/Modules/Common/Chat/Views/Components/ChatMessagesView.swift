//
//  ChatMessagesView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/28/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

@objc protocol LocalisysChatMessagesProvider: class {

  /// Total number of messages groups for localisys chat instance
  ///
  /// - Parameter chat: localisys chat instance
  /// - Returns: number of messages groups
  func localisysChatNumberOfMessagesSections(_ chat: LocalisysChatView) -> Int

  /// Total number of messages in specific group/section
  ///
  /// - Parameters:
  ///   - chat: localisys chat instance
  ///   - section: index of message group
  /// - Returns: number of messages
  func localisysChat(_ chat: LocalisysChatView, numberOfMessagesInSection section: Int) -> Int

  func localisysChat(_ chat: LocalisysChatView, headerReuseIdentifierInSection section: Int) -> String
  func localisysChat(_ chat: LocalisysChatView, messageReuseIdentifierAt indexPath: IndexPath) -> String

  func localisysChat(_ chat: LocalisysChatView, headerModelInSection section: Int) -> LocalisysChatSectionHeaderModel
  func localisysChat(_ chat: LocalisysChatView, messageModelAt indexPath: IndexPath) -> LocalisysChatMessageModel
}

final class ChatMessagesView: UICollectionView {

  fileprivate var chatView: LocalisysChatView { return (superview as? LocalisysChatView)! }

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

  override var numberOfSections: Int {
    return messagesProvider!.localisysChatNumberOfMessagesSections(chatView)
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messagesProvider!.localisysChat(chatView, numberOfMessagesInSection: section)
  }

  func collectionView(_ view: UICollectionView,
                      viewForSupplementaryElementOfKind kind: String,
                      at indexPath: IndexPath) -> UICollectionReusableView {
    switch kind {
    case UICollectionElementKindSectionHeader: return collectionView(view, headerViewAt: indexPath)
    case UICollectionElementKindSectionFooter: return UICollectionReusableView()
    default: return UICollectionReusableView()
    }
  }

  fileprivate func collectionView(_ collectionView: UICollectionView,
                                  headerViewAt indexPath: IndexPath) -> UICollectionReusableView {
    let headerReuseIdentifier = messagesProvider!.localisysChat(chatView, headerReuseIdentifierInSection: indexPath.section)
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                     withReuseIdentifier: headerReuseIdentifier,
                                                                     for: indexPath)
    if let messagesSectionView = headerView as? MessagesSectionView {
      let sectionHeaderModel = messagesProvider!.localisysChat(chatView, headerModelInSection: indexPath.section)
      messagesSectionView.fill(sectionHeaderModel)
    }
    return headerView
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let messageReuseIdentifier = messagesProvider!.localisysChat(chatView, messageReuseIdentifierAt: indexPath)
    let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: messageReuseIdentifier, for: indexPath)
    if let messageViewCell = messageCell as? MessageView {
      let messageModel = messagesProvider!.localisysChat(chatView, messageModelAt: indexPath)
      messageViewCell.fill(messageModel)
    }
    return messageCell
  }

}

extension ChatMessagesView: UICollectionViewDelegate {

}

extension ChatMessagesView: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

  }
}
