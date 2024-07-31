//
//  Weapon.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation

class Weapon {

  var damage: Int
  var type: String
  let name: String
  

  init(damage: Int, type: String, name: String) {
    self.damage = damage
    self.type = type
    self.name = name
  }
}
