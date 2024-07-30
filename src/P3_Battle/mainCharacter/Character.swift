//
//  Character.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation

class Character {
  

  let type: String
  var life: Int
  var weapon: Weapon

  
  init(type: String, life: Int, weapon: Weapon) {
    self.type = type
    self.life = life
    self.weapon = weapon
  }
  

  private func receive(damage: Int) {
    self.life -= damage
    if self.life <= 0 {
      self.life = 0
    }
  }
  
  func attack(character: Character) {
    if life > 0 {
      if character.life > 0 {
        character.receive(damage: weapon.damage)
        print("\n**************************************")
        print("\(type) utilise \(weapon.name) pour attaquer")
        print("\(character.type) perds \(weapon.damage) de point de vie")
        print("**************************************")
          
        if character.life <= 0 {
          print("Le personnage \(character.type) n'a plus de point de vie ")
        }
          
      } else {
        print("\n**************************************")
        print("Le personnage \(character.type)  n'a plus de point de vie !")
        print("**************************************")
      }
    } else {
      print("\n**************************************")
      print(" Le personnage \(type) ne peut pas lançer d'attaque car il est mort")
      print("**************************************")
    }
  }
  

  func display(index: Int) {
    print(" ")
    print("\(index) - \(type)  - Points de vie: \(life) - Arme : \(weapon.name) - Dégats : \(weapon.damage)")
  }
}


