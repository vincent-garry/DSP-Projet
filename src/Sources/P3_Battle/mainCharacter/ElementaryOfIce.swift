//
//  ElementaryOfIce.swift
//  P3_Battle
//
//  Created by Angelique Babin on 18/01/2019.
//  Copyright © 2019 Angelique Babin. All rights reserved.
//

import Foundation

class ElementaryOfIce: Character { // type attack
  
  //MARK: - Init
  init(name: String) {
    super.init(type: "Elementary Of Ice", life: 80, weapon: BatOfIce.init(), name: name, isBlocked: false)
  }
  
  
  //MARK: - Methodes
  //BONUS - POWER TO FREEZE : Randomly, inflict 5 points in less damage or healing for all weapons with more than 5 damage or healing points OR freeze a character of the enemy team and will be blocked in the next round.
  override func attack(character: Character) { // attack + one special power
    super.attack(character: character)
    if character.life > 0 {
      print("🥶 POWER TO FREEZE 🥶 :")
      let randomNumber = Int.random(in: 0 ... 100)
      if randomNumber <= 50 { // with 50 % of random
        damagedWeapon(character: character)
      } else { // freeze a character of the enemy team and will be blocked in the next round
        character.isBlocked = true
        print("The \(character.type) \"\(character.name)\" has been frozen 🥶 and will be blocked the next time he plays.")
      }
    }
  }
  
  // inflict 5 points in less damage or healing for all weapons with more than 5 damage or healing points
  private func damagedWeapon(character: Character) {
    if character.weapon is Scepter || character.weapon is StaffOfNordrassil || character.weapon is MoonLightGreatSword || character.weapon is StaffOfFire {
      let typeHealing = "healing"
      if character.weapon.heal > 5 {
        character.weapon.heal -= 5
        displayWeaponDamaged(character: character, typeCharacter: typeHealing)
      } else {
        displayWeaponNoEffect(character: character, typeCharacter: typeHealing)
      }
    } else {
      let typeDamaged = "damage"
      if character.weapon.damage > 5 {
        character.weapon.damage -= 5
        displayWeaponDamaged(character: character, typeCharacter: typeDamaged)
      } else {
        displayWeaponNoEffect(character: character, typeCharacter: typeDamaged)
      }
    }
  }
  
  // display the bonus to the POWER TO FREEZE
  override func display(index: Int) {
    super.display(index: index)
    print("### 🥶 POWER TO FREEZE : Randomly, inflict 5 points in less damage or healing for all weapons with more than 5 damage or healing points --- or freeze the enemy and will be blocked the next time he plays. ###")
  }
  
  // display if the character is of type attack
  private func displayWeaponDamaged(character: Character, typeCharacter: String) {
    print("💢 The \(character.weapon.nameWeapon) of the \(character.type) \"\(character.name)\" has been damaged by the \(type) \"\(name)\" and and loses 5 points of \(typeCharacter) !")
    print("---------------------------------------------------------------------------------------------------------")
  }
  
  // display if the character is of type heal
  private func displayWeaponNoEffect(character: Character, typeCharacter: String) {
    print("🚫 No effect : The \(character.weapon.nameWeapon) of the \(character.type) \"\(character.name)\" has only 5 points of \(typeCharacter) left and can't lose more.")
    print("--------------------------------------------------------------------------------------------------------")
  }
} // END class ElementaryOfIce

