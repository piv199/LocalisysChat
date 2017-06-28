//
//  InitialApplicationSegue.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/26/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import UIKit

final class InitialApplicationSegue: UIStoryboardSegue {
  override func perform() {
    UIApplication.shared.keyWindow?.rootViewController = destination
  }
}
