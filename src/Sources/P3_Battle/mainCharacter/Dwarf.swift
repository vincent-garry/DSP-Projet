//
//  Dwarf.swift
//  P3_Battle
//
//  Created by Angelique Babin on 18/12/2018.
//  Copyright © 2018 Angelique Babin. All rights reserved.
//

import Foundation

class Dwarf: Character { // type attack
  
  //MARK: - Init
  init(name: String) {
    super.init(type: "Dwarf", life: 60, weapon: Axe.init(), name: name, isBlocked: false)
  }
}
