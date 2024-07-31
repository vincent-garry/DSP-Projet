import Foundation
import Vapor

class Game {
    private var arrayTeams = [Team]()
    private var battleIsEnded = false
    private var output = ""

    func start(req: Request) -> String {
        output = ""
        welcome()
        return output
    }

    func createTeams(req: Request) -> String {
        output = ""
        let teamFactory = TeamFactory()
        teamFactory.createTeams()
        arrayTeams = teamFactory.arrayTeams
        output += "Équipes créées avec succès.\n"
        return output
    }

    func battle(req: Request) -> String {
        output = ""
        if arrayTeams.count == 0 {
            output += "Veuillez d'abord enregistrer les joueurs\n"
        } else if battleIsEnded {
            output += "Jeu terminé\n"
        } else {
            displayStartBattle()
            // Simuler une seule attaque pour chaque équipe
            for nbTeam in 0..<arrayTeams.count {
                let myCharacter = arrayTeams[nbTeam].characters[0] // Prendre le premier personnage
                let enemyTeam = arrayTeams[(nbTeam + 1) % arrayTeams.count]
                let enemyCharacter = enemyTeam.characters[0] // Attaquer le premier personnage ennemi
                
                output += "L'équipe \(nbTeam + 1) attaque :\n"
                myCharacter.attack(character: enemyCharacter)
                output += "Le \(myCharacter.type) attaque le \(enemyCharacter.type)\n"
                output += "Points de vie restants du \(enemyCharacter.type) : \(enemyCharacter.life)\n"
                
                if enemyTeam.isDead() {
                    battleIsEnded = true
                    break
                }
            }
        }
        return output
    }

    func status(req: Request) -> String {
        output = ""
        for (index, team) in arrayTeams.enumerated() {
            output += "Équipe \(index + 1):\n"
            for character in team.characters {
                output += "- \(character.type): \(character.life) points de vie\n"
            }
        }
        if battleIsEnded {
            output += "La bataille est terminée.\n"
            displayWinner()
        } else {
            output += "La bataille est en cours.\n"
        }
        return output
    }

    private func welcome() {
        output += "**************************************\n"
        output += "\t\t   ESATIC FIGTH  \n"
        output += "**************************************\n"
        output += "Bienvenue dans le jeu. Utilisez les routes suivantes :\n"
        output += "/create-teams : pour créer les équipes\n"
        output += "/battle : pour effectuer un tour de bataille\n"
        output += "/status : pour voir l'état actuel du jeu\n"
    }

    private func displayStartBattle() {
        output += "\n**************************************\n"
        output += "\t\t Debut de la bataille\n"
        output += "**************************************\n"
    }

    private func displayWinner() {
        for (index, team) in arrayTeams.enumerated() {
            if !team.isDead() {
                output += "\n\n**************************************\n"
                output += "Vainqueur : Joueur : \(index + 1) - Equipe : \(index + 1)\n"
                output += "**************************************\n"
            }
        }
    }
}