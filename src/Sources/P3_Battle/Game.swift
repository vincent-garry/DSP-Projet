//
//  Game.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation

class Game {
  

  private var arrayTeams = [Team]()
  private var endlessLoop = true
  private var battleIsEnded = false


  func start() {
    var userChoice = 0
    repeat {
      welcome()
      repeat {
        if let data = readLine() {
          if let dataToInt = Int(data) {
            userChoice = dataToInt
          }
        }
      } while userChoice != 1 && userChoice != 2 && userChoice != 3
      
      switch userChoice {
      case 1:
        endlessLoop = true
        battleIsEnded = false
        let teamFactory = TeamFactory()
        teamFactory.createTeams()
        arrayTeams = teamFactory.arrayTeams
        battle()
        endOfBattle()
      case 2:
          exitGame()
      default:
        break
      }
      userChoice = 0
    } while endlessLoop
  }
  
 
  private func welcome() {
    print("")
    print("**************************************")
   print("\t\t   ESATIC FIGTH  ")
    print("**************************************\n")
    print("Veuillez faire un choix")

    print("1. Commencer la partie")
    print("2. Quitter ")
    print("\n**************************************")
  }



  private func battle() {
    if arrayTeams.count == 0 {
      print("Veuillez d'abord enregistrer les joueurs ")
    } else if battleIsEnded == true {
      print(" ")
      print("Jeu terminé")
    } else {
      displayStartBattle()
      
      var myCharacter: Character
      repeat {
        for nbTeam in 0..<arrayTeams.count {
          choiceMyCharacter(nbTeam: nbTeam)
          myCharacter = arrayTeams[nbTeam].characters[userChoice() - 1]
          
          if myCharacter.life > 0 {

            if nbTeam == 0 {
              let myTeamEnemy = arrayTeams[nbTeam+1]
              fightAttack(myCharacter: myCharacter, myTeamEnemy: myTeamEnemy, nbTeam: nbTeam)
              if myTeamEnemy.isDead() {
                return
              }
            } else {
              let myTeamEnemy = arrayTeams[nbTeam-1]
              fightAttack(myCharacter: myCharacter, myTeamEnemy: myTeamEnemy, nbTeam: nbTeam)
              if myTeamEnemy.isDead() {
                return
              }
            }
              
          } else {
            displayCharacterIsDead(myCharacter: myCharacter)
          }
        }
      } while battleIsEnded == false
    }
  }
  

  private func displayStartBattle() {
    print("\n**************************************")
    print("\t\t Debut de la bataille")
    print("**************************************")
  }
  
  
  private func fightAttack(myCharacter: Character, myTeamEnemy: Team, nbTeam: Int) {
    print("\n**************************************")
    print("\t\tQuel personnage adverse attaquer ?")
    print("**************************************")
    
    switch nbTeam {
    case 0:
      arrayTeams[nbTeam+1].displayTeam()
      let myEnemy = myTeamEnemy.characters[userChoice() - 1]
      myCharacter.attack(character: myEnemy)
    case 1:
      arrayTeams[nbTeam-1].displayTeam()
      let myEnemy = myTeamEnemy.characters[userChoice() - 1]
      myCharacter.attack(character: myEnemy)
    default:
      break
    }
  }
  
  private func choiceMyCharacter(nbTeam: Int) {
    print("\n\n**************************************")
    print("TOUR DU JOUEUR \(nbTeam+1) - Equipe \(nbTeam+1) :")
    print("**************************************")
    let team = arrayTeams[nbTeam]
    team.displayTeam()
    print("\n**************************************")
    print("Joueur \(nbTeam+1) : Qui doit attaquer ?")
    print("**************************************")
  }
  
  private func userChoice() -> Int {
    var characterChoice = 0
    repeat {
      if let data = readLine() {
        if let dataToInt = Int(data) {
          characterChoice = dataToInt
        }
      }
    } while characterChoice != 1 && characterChoice != 2 && characterChoice != 3
    return characterChoice
  }
  
 
  private func displayCharacterIsDead(myCharacter: Character) {
    print("\n**************************************")
    print("Le \(myCharacter.type) est mort ")
    print("**************************************")
  }
  

  private func displayWinner() {
    for i in 0..<arrayTeams.count {
      let team = arrayTeams[i]
      if team.isDead() == false {
        print("\n\n**************************************")
        print("Vainqueur : Joueur : \(i+1) - Equipe : \(i+1) ")
        print("**************************************")
      }
    }
  }
  

  private func resumeGame() {
    if arrayTeams.count == 0 {
      print("Aucun joueur enregistré")
    } else if arrayTeams.count != 0 && battleIsEnded == false {
      print("Aucune bataille terminé")
    } else {
      print("\n\n**************************************")
      print("\t\t FIN DE COMBAT")
      print("**************************************")
      displayWinner()
    }
  }
  
  private func endOfBattle() {
    for i in 0..<arrayTeams.count {
      let team = arrayTeams[i]
      if team.isDead() == true && arrayTeams.count != 0 {
        battleIsEnded = true
      }
    }
    resumeGame()
  }
  

  private func exitGame() {
    var userExit = 0
    if arrayTeams.count == 0 || battleIsEnded == true {
      print(" ➡︎ Exit of game")
      endlessLoop = false
    } else {
      print("Voulez vous vraimment quitter ?")
      print("1 - Oui")
      print("2 - Non")
      repeat {
        if let data = readLine() {
          if let dataToInt = Int(data) {
            userExit = dataToInt
          }
        }
      } while userExit != 1 && userExit != 2
    
      switch userExit {
      case 1:
        print(" Fermeture en cours ")
        endlessLoop = false
      case 2:
        print("Continuer ...")
        endlessLoop = true
      default:
        break
      }
      userExit = 0
    }
  }
} 
