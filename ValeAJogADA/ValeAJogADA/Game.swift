//
//  Games.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 16/05/24.
//

import Foundation

struct GamePair : Identifiable, Equatable, Hashable, Comparable {
    static func < (lhs: GamePair, rhs: GamePair) -> Bool {
        lhs.result < rhs.result
    }
    
    let id = UUID()
    static func == (lhs: GamePair, rhs: GamePair) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
    
    var result: Double
    var game: Game
}

class Game: Identifiable, Equatable, Hashable {
    static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.id == rhs.id
    }
    func hash(into hasher: inout Hasher) {
        
    }
    
    let id = UUID()
    var name: String
    var playerCount: (Int, Int)
    var hasTeams: Bool
    var mechanics: [Mechanics]
    var complexity: Double
    var hasMiniObjectives: Bool
    var hasPointSalad: Bool
    var hasNegativeInteractions: Bool
    var numberMechanics: Int {
        return self.mechanics.count
    }
    var time: Int
    
    
    init(name: String, playerCount: (Int, Int), hasTeams: Bool, mechanics: [Mechanics], complexity: Double,
         hasMiniObjectives: Bool, hasPointSalad: Bool, hasNegativeInteractions: Bool, time: Int) {
        self.name = name
        self.playerCount = playerCount
        self.hasTeams = hasTeams
        self.mechanics = mechanics
        self.complexity = complexity
        self.hasMiniObjectives = hasMiniObjectives
        self.hasPointSalad = hasPointSalad
        self.hasNegativeInteractions = hasNegativeInteractions
        self.time = time
    }
    
    // assassino, socializador, explorer, achiever
    func pontuation() -> [Double] {
        var pont: [Double] = [0,0,0,0]
        
        if self.hasTeams {
            pont[1] += 10
        }
        
        if self.playerCount.1 >= 6 {
            pont[1] += Double(self.playerCount.1 - 5)*5
        }
        
        pont[2] += max(complexity - 2, 0)*5
        
        if self.hasPointSalad {
            pont[3] += 10
        }
        if self.hasNegativeInteractions {
            pont[0] += 10
        }
        
        for mechanic in mechanics {
            for i in 0..<4 {
                pont[i] += mechanic.pontuation[i]
            }
            
        }
        return pont
    }
    
    
}

enum Mechanics {
    case dice
    case tiles
    case areaControl
    case drafting
    case workerPlacement
    case auction
    case deckBuilding
    case setCollection
    case negotiation
    case socialDeduction
    case cooperative
    case strategy
    case wordGame
    case routeBuilding
    
    // assassino, socializador, explorer, achiever
    var pontuation: [Double] {
        switch self {
        case .dice:
            return [-5, 0, 0, 0]
        case .tiles:
            return [0,0,5,2]
        case .areaControl:
            return [8,0,0,8]
        case .drafting:
            return [0,0,10,10]
        case .workerPlacement:
            return [0,0,10,10]
        case .auction:
            return [0,8,0,10]
        case .deckBuilding:
            return [0,0,8,8]
        case .setCollection:
            return [0,0,0,10]
        case .negotiation:
            return [0,10,0,8]
        case .socialDeduction:
            return [10,12,0,5]
        case .cooperative:
            return [-5,10,5,8]
        case .strategy:
            return [5,0,5,5]
        case .wordGame:
            return [0,0,0,5]
        case .routeBuilding:
            return [0,0,3,5]
        }
    }
}

func calculate(games: [Game], game5: Game) -> Double {
    
    let styles = calculateStyles(games: games)
    
    let stylePontuation: Double = stylePontuation(styles: styles, game: game5)
    let mechanicPontuation: Double = mechanicPontuation(games: games, game: game5)
    var result: Double
    
    
    result = min(stylePontuation + mechanicPontuation, 100)
    return result
}

func calculateStyles(games: [Game]) -> [Double]
{
    var result: [Double] = [0,0,0,0]
    
    var totalMechanics = 0
    
    for game in games {
        for i in 0..<4 {
            result[i] += game.pontuation()[i]
        }
        totalMechanics += game.numberMechanics
    }
    
    //result = result.map({$0*100 / Double(totalMechanics)})
    result = result.map({min($0, 100)})
    
    print("Styles: \(result)")
    
    return result
}

func stylePontuation(styles: [Double], game: Game) -> Double
{
    var result: Double = 0
    
    let gamePontuation = game.pontuation()
    
    for i in 0..<4 {
        let dif = styles[i] - abs(styles[i] - gamePontuation[i])
        result += dif * 100 / styles[i]
    }
    
    print("StylePontuation: \(result)")

    return result / 4
}

func mechanicPontuation(games: [Game], game: Game) -> Double{
    var mechanics: Set<Mechanics> = []
    var game5Mechanics: Set<Mechanics> = []
    var mecArray: [Mechanics] = []
    mecArray += games[0].mechanics
    mecArray += games[1].mechanics
    mecArray += games[2].mechanics
    mecArray += games[3].mechanics
    
    for elem in mecArray {
        mechanics.insert(elem)
    }
    
    for elem in game.mechanics {
        game5Mechanics.insert(elem)
    }
    
    let result = (Double(mechanics.intersection(game5Mechanics).count) * 100) / Double(mechanics.count)
    
    print("MechanicPontuation: \(result)")
    
    return result
}

func addGames() -> [Game] {
    var games: [Game] = []
    
    games.append(Game(name: "Selecionar", playerCount: (0,0), hasTeams: false, mechanics: [], complexity: 0, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: false, time: 0))
    
    games.append(Game(name: "Catan", playerCount: (3,4), hasTeams: false, mechanics: [Mechanics.dice, Mechanics.negotiation, Mechanics.strategy, Mechanics.routeBuilding], complexity: 2.3, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: true, time: 120))
    games.append(Game(name: "Carcassonne", playerCount: (2,5), hasTeams: false, mechanics: [Mechanics.tiles, Mechanics.strategy], complexity: 1.9, hasMiniObjectives: false, hasPointSalad: true, hasNegativeInteractions: true, time: 35))
    games.append(Game(name: "Pandemic", playerCount: (2,4), hasTeams: false, mechanics: [Mechanics.setCollection, Mechanics.cooperative], complexity: 2.4, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: false, time: 45))
    games.append(Game(name: "7 Wonders", playerCount: (3,7), hasTeams: false, mechanics: [Mechanics.drafting, Mechanics.setCollection], complexity: 2.3, hasMiniObjectives: false, hasPointSalad: true, hasNegativeInteractions: false, time: 30))
    games.append(Game(name: "Codenames", playerCount: (3,8), hasTeams: true, mechanics: [Mechanics.socialDeduction, Mechanics.wordGame], complexity: 1.3, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: false, time: 15))
    games.append(Game(name: "Azul", playerCount: (2,4), hasTeams: false, mechanics: [Mechanics.setCollection, Mechanics.tiles], complexity: 1.8, hasMiniObjectives: true, hasPointSalad: true, hasNegativeInteractions: true, time: 45))
    games.append(Game(name: "Ticket to Ride", playerCount: (2,5), hasTeams: false, mechanics: [Mechanics.setCollection, Mechanics.routeBuilding], complexity: 1.8, hasMiniObjectives: true, hasPointSalad: true, hasNegativeInteractions: true, time: 60))
    games.append(Game(name: "Dixit", playerCount: (3,8), hasTeams: false, mechanics: [Mechanics.socialDeduction], complexity: 1.2, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: false, time: 30))
    games.append(Game(name: "Coup", playerCount: (3,10), hasTeams: false, mechanics: [Mechanics.socialDeduction], complexity: 1.4, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: true, time: 15))
    games.append(Game(name: "The Resistance", playerCount: (5,10), hasTeams: true, mechanics: [Mechanics.negotiation, Mechanics.socialDeduction], complexity: 1.6, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: true, time: 30))
    games.append(Game(name: "Monopoly", playerCount: (2,8), hasTeams: false, mechanics: [Mechanics.auction, Mechanics.negotiation, Mechanics.setCollection, Mechanics.dice], complexity: 1.6, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: true, time: 180))
    games.append(Game(name: "War", playerCount: (2,6), hasTeams: false, mechanics: [Mechanics.areaControl, Mechanics.dice, Mechanics.setCollection], complexity: 2, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: true, time: 120))
    games.append(Game(name: "Jogo da Vida", playerCount: (2,6), hasTeams: false, mechanics: [Mechanics.dice], complexity: 1.1, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: false, time: 60))
    games.append(Game(name: "Xadrez", playerCount: (2,2), hasTeams: false, mechanics: [], complexity: 3.6, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: true, time: 30))
    games.append(Game(name: "Decrypto", playerCount: (3,8), hasTeams: true, mechanics: [Mechanics.socialDeduction, Mechanics.wordGame], complexity: 1.8, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: false, time: 45))
    games.append(Game(name: "Bohnanza", playerCount: (3,5), hasTeams: false, mechanics: [Mechanics.negotiation, Mechanics.setCollection], complexity: 1.6, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: false, time: 45))
    games.append(Game(name: "Trio", playerCount: (3,6), hasTeams: false, mechanics: [Mechanics.setCollection], complexity: 1, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: false, time: 15))
    games.append(Game(name: "Taco Gato Cabra Queijo Pizza", playerCount: (2,8), hasTeams: false, mechanics: [], complexity: 1, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: false, time: 20))
    games.append(Game(name: "Sushi Go Party!", playerCount: (2,8), hasTeams: false, mechanics: [Mechanics.drafting, Mechanics.setCollection], complexity: 1.3, hasMiniObjectives: false, hasPointSalad: true, hasNegativeInteractions: false, time: 20))
    games.append(Game(name: "Saboteur", playerCount: (3,10), hasTeams: true, mechanics: [Mechanics.socialDeduction, Mechanics.routeBuilding], complexity: 1.3, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: true, time: 30))
    
    return games
}


