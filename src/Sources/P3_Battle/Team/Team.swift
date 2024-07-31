//
//  Team.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation

class Team {


  var characters: [Character] = []
  var playerName: String = ""
    
  init(playerName: String = "") {
      self.playerName = playerName
  }


  func displayTeam() {
    for i in 0..<characters.count {
      let character = characters[i]
      if character.life <= 0 {
        print(" ")
        print("\(i+1) -  \(character.type) est mort")
        print(" ")
      } else {
        character.display(index: i+1)
      }
    }
  }
  

  func isDead() -> Bool {
    var isDead = false
    for character in characters {
      if character.life <= 0 {
        isDead = true
      } else { 
        isDead = false
        return isDead
      }
    }
    return isDead
  }  
} 
