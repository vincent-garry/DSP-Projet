//
//  Wizard.swift
//  P3_Battle
//
//  Created by Angelique Babin on 18/12/2018.
//  Copyright © 2018 Angelique Babin. All rights reserved.
//

import Foundation

class Wizard: Character { // type heal
  
  //MARK: - Inits
  init(name: String) {
        super.init(type: "Wizard", life: 70, weapon: Scepter(), name: name)
    }
  
  //MARK: - Methodes
  func heal(character: Character) {
    if life > 0 {
      if character.life > 0 {
        
        dispel(character: character) // unlocked a character
        
        character.life += weapon.heal
        
        print("⚡️ Your \(character.type) \"\(character.name)\" has recovered \(weapon.heal) points of life by the \(weapon.nameWeapon) of your \(type) \"\(name)\" !⚡️")
        if character.life >= character.lifeMaxLimit { // after a healing the character can't have more points of life than to the start
          character.life = character.lifeMaxLimit
          print("❇️ He has recovered the totality of his life points. ❇️")
        }
      } else {
        print("❌ Your \(character.type), \"\(character.name)\" is already dead and cannot be resurrected !")
      }
    } else {
      print("❌ Sorry your \(type) \"\(name)\" is already dead and you cannot heal !")
    }
  }
  
  // unlocked a character who has been blocked by the "Power Of Ice"
  private func dispel(character: Character) {
    if character.isBlocked == true {
      character.isBlocked = false
      print("🔮 Your \(character.type) \"\(character.name)\" as been unfrozen by your \(type) \"\(name)\" !")
    }
  }
  
  override func attack(character: Character) {
        if character.life > 0 {
            character.life += weapon.heal
            print("⚡️ Your \(character.type) \"\(character.name)\" has recovered \(weapon.heal) points of life by the \(weapon.name) of your \(type) \"\(name)\" !⚡️")
            
            if character.life >= character.lifeMaxLimit {
                character.life = character.lifeMaxLimit
                print("The \(character.type) \"\(character.name)\" has reached its maximum life points : \(character.life)")
            }
        } else {
            print("The \(character.type) \"\(character.name)\" is dead and can't be healed")
        }
    }
  
  // display the special power "dispel" to release from a spell
  override func display(index: Int) {
    super.display(index: index)
    print("### 🔮 Dispel : ✨ Power that unlocks a character that has been frozen. ✨###")
  }
}

