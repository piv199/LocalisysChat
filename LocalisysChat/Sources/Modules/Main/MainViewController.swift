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
    "Message 1",
    "Я все еще лучший здесь, в Италии, - заявил Кассано всего неделю назад в интервью Sky Italia",
    "Между тем, ведь речь идет о двукратном чемпионе Германии и о человеке, входившем в состав сборной-чемпиона мира!",
    "Один из наиболее недооцененных игроков своего поколения, Мотта не только был одним из участников великого",
    "Гринвальди"
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
    return LocalisysChatTextBubbleMessage(message: messages[indexPath.row])
  }


}
