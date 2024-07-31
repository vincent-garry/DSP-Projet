//
//  SpiderMan.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation
class SpiderMan: Character {
    init(name: String) {
        super.init(type: "SpiderMan", life: 30, weapon: Web(), name: name)
    }
}
