//
//  LocalisysChatMessagesView.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/28/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

@objc public protocol LocalisysChatMessagesProvider: class {

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

  /// Model for displaying header for group of messages(section)
  ///
  /// - Parameters:
  ///   - chat: localisys chat instance
  ///   - section: section for model apply to
  /// - Returns: model that describes data and view to display for group of messages
  func localisysChat(_ chat: LocalisysChatView, headerViewModelInSection section: Int) -> LocalisysChatHeaderSectionViewModel

  func localisysChat(_ chat: LocalisysChatView, messageViewModelAt indexPath: IndexPath) -> LocalisysChatMessageViewModel
}

class LocalisysChatMessagesView: UICollectionView {

  fileprivate var chatView: LocalisysChatView { return (superview as? LocalisysChatView)! }

  // MARK: - Core properties

  /// Messages data source required for displaying messages
  @objc public weak var messagesProvider: LocalisysChatMessagesProvider? {
    didSet { reloadData() }
  }

  // MARK: - Lifecycle

  convenience init() {
    self.init(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
  }

  override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
    super.init(frame: frame, collectionViewLayout: layout)
    setupInitialState()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupInitialState()
  }

  // MARK: - Setup & Configurations

  fileprivate func setupInitialState() {
    bounces = true
    alwaysBounceVertical = true

    backgroundColor = .clear

    dataSource = self
    delegate = self
  }
}

extension LocalisysChatMessagesView: UICollectionViewDataSource {

  override var numberOfSections: Int {
    return messagesProvider?.localisysChatNumberOfMessagesSections(chatView) ?? 0
  }

  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messagesProvider?.localisysChat(chatView, numberOfMessagesInSection: section) ?? 0
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
    let headerSectionViewModel = messagesProvider!.localisysChat(chatView, headerViewModelInSection: indexPath.section)
    let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                     withReuseIdentifier: headerSectionViewModel.reuseIdentifier,
                                                                     for: indexPath)
    (headerView as? LocalisysChatHeaderSectionView).flatMap(headerSectionViewModel.configure)
    return headerView
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let messageViewModel = messagesProvider!.localisysChat(chatView, messageViewModelAt: indexPath)
    let messageCell = collectionView.dequeueReusableCell(withReuseIdentifier: messageViewModel.reuseIdentifier, for: indexPath)
    (messageCell as? LocalisysChatMessageView).flatMap(messageViewModel.configure)
    return messageCell
  }

}

extension LocalisysChatMessagesView: UICollectionViewDelegateFlowLayout {
  public func collectionView(_ collectionView: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: bounds.width, height: 44.0)
  }

  public func collectionView(_ collection: UICollectionView,
                             layout collectionViewLayout: UICollectionViewLayout,
                             referenceSizeForHeaderInSection section: Int) -> CGSize {
    let headerSectionViewModel = messagesProvider!.localisysChat(chatView, headerViewModelInSection: section)
    let headerSectionView = DateLocalisysChatHeaderSectionView()
    headerSectionViewModel.configure(headerSectionView)
    return headerSectionView.sizeThatFits(.init(width: bounds.width, height: .greatestFiniteMagnitude))
    //  Crashes the program due to calling collectionView(_:headerViewAt:) which dequeues the cell by ourselves so its forbidden, before its actually needed for the core implementation of UICollectionView
//    return collectionView(collection, headerViewAt: IndexPath(row: 0, section: section))
//      .sizeThatFits(.init(width: bounds.width, height: .greatestFiniteMagnitude))
  }
}

extension LocalisysChatMessagesView: UICollectionViewDataSourcePrefetching {
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {

  }
}