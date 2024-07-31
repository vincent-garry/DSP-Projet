//
//  TeamFactory.swift
//  Esatic_Fight
//
//  Created by SEKONGO  on 10/01/2022.
//  Copyright © 2022 SEKONGO. All rights reserved.
//

import Foundation

class TeamFactory {
    var arrayTeams = [Team]()
    
    func createTeam() -> Team {
        let characters: [Character] = [
            SpiderMan(name: "Peter Parker"),
            CaptainMan(name: "Steve Rogers"),
            SuperMan(name: "Clark Kent")
        ]
        let team = Team()
        team.characters = characters
        return team
    }
    
    func createTeams() {
        let numberOfTeams = 2
        
        for i in 0..<numberOfTeams {
            var namePlayer = ""
            print("")
            print("=============================")
            print("Entrer le nom du joueur \(i+1) : ")
            print("=============================")
            repeat {
                if let data = readLine() {
                    namePlayer = data
                }
            } while namePlayer == ""
            
            let team = createTeam()
            team.playerName = namePlayer
            arrayTeams.append(team)
        }
    }
}
