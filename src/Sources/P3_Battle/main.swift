import Foundation
import Vapor

// Initialisation du jeu
private let game = Game()

// Configuration du serveur Vapor
let app = try Application(.detect())
defer { app.shutdown() }

// Route pour démarrer le jeu
app.get("start") { req -> String in
    // Capture la sortie standard
    let pipe = Pipe()
    let savedStandardOutput = FileHandle.standardOutput
    FileHandle.standardOutput = pipe
    
    // Exécute le jeu
    game.start()
    
    // Récupère la sortie
    FileHandle.standardOutput = savedStandardOutput
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8) ?? "Impossible de lire la sortie du jeu"
    
    return output
}

// Route par défaut
app.get { req in
    return "Bienvenue dans P3_Battle! Utilisez /start pour lancer le jeu."
}

// Démarrage du serveur
try app.run()