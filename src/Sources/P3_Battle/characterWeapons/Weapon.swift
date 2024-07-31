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
    var heal: Int
    let type: String
    let name: String
    
    init(damage: Int, heal: Int, type: String, name: String) {
        self.damage = damage
        self.heal = heal
        self.type = type
        self.name = name
    }
}
