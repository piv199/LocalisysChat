//
//  MainViewController.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit
import FirebaseDatabase

final class MainViewController: UIViewController {

  let messages = [
    "This is the chapter where we really get to see the code. We have two examples:\nRequest/Reply\nPublish/Subscribe",
    "This example explores how to implement the Observer pattern using a Publish-Subscribe Channel. It considers distribution.",
    "Hello!",
    "Hi! Are these going to be interesting?",
    "Please, be patient",
    "POJO Messaging Example. Introduction. This example shows that you don't need to learn Camel's super cool DSLs if you don't want to. Camel has a set of ..."
  ]

  @IBOutlet weak var chatView: LocalisysChatView!

  override func viewDidLoad() {
    super.viewDidLoad()
    chatView.messagesProvider = self

    view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(viewTapped)))
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    chatView.messagesCollectionView.reloadData()
  }

  func viewTapped() {
    view.endEditing(true)
  }

}

extension MainViewController: LocalisysChatMessagesProvider {
  func localisysChatNumberOfMessagesSections(_ chat: LocalisysChatView) -> Int {
    return 1
  }

  func localisysChat(_ chat: LocalisysChatView, numberOfMessagesInSection section: Int) -> Int {
    return messages.count
  }

  func localisysChat(_ chat: LocalisysChatView, headerViewModelInSection section: Int) -> LocalisysChatHeaderSectionViewModel {
    return DateLocalisysChatHeaderSection(dateTitle: "Today")
  }

  func localisysChat(_ chat: LocalisysChatView, messageViewModelAt indexPath: IndexPath) -> LocalisysChatMessageViewModel {
    let messageModel = LocalisysChatTextBubbleMessageModel(text: messages[indexPath.row],
                                                           timestamp: Date().addingTimeInterval(TimeInterval(arc4random() % 2000)),
                                                           status: .none)
    return LocalisysChatTextBubbleMessage(messageModel)
  }
}








