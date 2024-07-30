//
//  Fighter.swift
//  P3_Battle
//
//  Created by Angelique Babin on 18/12/2018.
//  Copyright © 2018 Angelique Babin. All rights reserved.
//

import Foundation

class Fighter: Character { // type attack
  
  //MARK: - Init
  init(name: String) {
    super.init(type: "Fighter", life: 100, weapon: Sword.init(), name: name, isBlocked: false)
  }
}

