import Foundation
import Vapor

// Initialisation du jeu
let game = Game()

// Configuration du serveur Vapor
let app = try Application(.detect())
defer { app.shutdown() }

// Route pour démarrer le jeu
app.get("start") { req in
    return game.start(req: req)
}

// Route pour créer les équipes
app.get("create-teams") { req in
    return game.createTeams(req: req)
}

// Route pour effectuer un tour de bataille
app.get("battle") { req in
    return game.battle(req: req)
}

// Route pour voir le statut du jeu
app.get("status") { req in
    return game.status(req: req)
}

// Démarrage du serveur
try app.run()