//
//  Chest.swift
//  P3_Battle
//
//  Created by Angelique Babin on 23/01/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class Chest {
  
  // a chest appears randomly in front of the character and a new weapon appears
  func randomChest(character: Character) {
    let randomNumber = Int.random(in: 0 ... 100)
    if randomNumber <= 20 {
      let arrayWeaponHeal = [StaffOfNordrassil.init(), MoonLightGreatSword.init(), StaffOfFire.init()]
      let arrayWeaponDamage = [SwordOfAnduril.init(), DevilsHammer.init(), SolarSword.init(), SwordFishCurved.init()]
      
      let randomWeaponHeal = arrayWeaponHeal.randomElement()
      let randomWeaponDamage = arrayWeaponDamage.randomElement()
      
      if character is Wizard {
        let typeCharacter = "healing"
        guard let randomWeaponHeal = randomWeaponHeal else { return }
        character.weapon = randomWeaponHeal
        let typeWeapon = character.weapon.heal
        displayChest(character: character, typeCharacter: typeCharacter, typeWeapon: typeWeapon)
      } else {
        let typeCharacter = "damage"
        guard let randomWeaponDamage = randomWeaponDamage else { return }
        character.weapon = randomWeaponDamage
        let typeWeapon = character.weapon.damage
        displayChest(character: character, typeCharacter: typeCharacter, typeWeapon: typeWeapon)
      }
    }
  }
  
  // display the contents of the chest
  private func displayChest(character: Character, typeCharacter: String, typeWeapon: Int) {
    print("@@@@@@@@@@@===========================------------------===========================@@@@@@@@@@@")
    print("☀️☀️☀️ Congratulations ! You discover a chest 📦 and you get a new weapon ⚔️ : ☀️☀️☀️")
    print("Your \(character.type) \"\(character.name)\" gets the \"\(character.weapon.nameWeapon)\" and now can give \(typeWeapon) points of \(typeCharacter) !!!")
    print("@@@@@@@@@@@===========================------------------===========================@@@@@@@@@@@")
    print(" ")
  }
}
