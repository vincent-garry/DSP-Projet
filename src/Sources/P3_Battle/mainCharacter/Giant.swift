//
//  Giant.swift
//  P3_Battle
//
//  Created by Angelique Babin on 18/12/2018.
//  Copyright © 2018 Angelique Babin. All rights reserved.
//

import Foundation

class Giant: Character { // type attack
  
  //MARK: - Init
  init(name: String) {
    super.init(type: "Giant", life: 120, weapon: Mace.init(), name: name, isBlocked: false)
  }
}
