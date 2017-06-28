//
//  ChatArrayExtensions.swift
//  LocalisysChat
//
//  Created by Olexii Pyvovarov on 6/28/17.
//  Copyright © 2017 Olexii Pyvovarov. All rights reserved.
//

import Foundation

extension Array {
  func flatten<U>() -> Array<U> {
    var result = [U]()
    for element in self {
      if let array = element as? Array {
        result += array.flatten()
      } else if let destElement = element as? U {
        result.append(destElement)
      }
    }
    return result
  }
}
