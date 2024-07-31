//
//  CaptainMan.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation
class CaptainMan: Character {
    init(name: String) {
        super.init(type: "CaptainMan", life: 40, weapon: Shield(), name: name)
    }
}
