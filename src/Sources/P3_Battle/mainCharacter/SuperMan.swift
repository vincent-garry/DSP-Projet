//
//  SuperMan.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation
class SuperMan: Character {
    init(name: String) {
        super.init(type: "SuperMan", life: 50, weapon: Punch(), name: name)
    }
}
