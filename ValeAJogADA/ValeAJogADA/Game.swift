//
//  Games.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 16/05/24.
//

import Foundation

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
    
    
    init(name: String, playerCount: (Int, Int), hasTeams: Bool, mechanics: [Mechanics], complexity: Double,
         hasMiniObjectives: Bool, hasPointSalad: Bool, hasNegativeInteractions: Bool) {
        self.name = name
        self.playerCount = playerCount
        self.hasTeams = hasTeams
        self.mechanics = mechanics
        self.complexity = complexity
        self.hasMiniObjectives = hasMiniObjectives
        self.hasPointSalad = hasPointSalad
        self.hasNegativeInteractions = hasNegativeInteractions
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
        
        pont[2] += max(complexity - 2,0)*5
        
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
    
    // assassino, socializador, explorer, achiever
    var pontuation: [Double] {
        switch self {
        case .dice:
            return [-5, 0, 0, 0]
        case .tiles:
            return [0,0,5,5]
        case .areaControl:
            return [10,0,0,10]
        case .drafting:
            return [0,0,10,10]
        case .workerPlacement:
            return [0,0,10,10]
        case .auction:
            return [0,10,0,10]
        case .deckBuilding:
            return [0,0,10,10]
        case .setCollection:
            return [0,0,0,10]
        case .negotiation:
            return [0,15,0,10]
        case .socialDeduction:
            return [10,15,0,5]
        case .cooperative:
            return [-5,15,10,10]
        case .strategy:
            return [10,0,5,10]
        }
    }
}

func calculate(games: [Game]) -> Double {
    
    let styles = calculateStyles(games: games)
    
    let stylePontuation: Double = stylePontuation(styles: styles, game: games[4])
    let mechanicPontuation: Double = mechanicPontuation(games: games)
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
    
    var gamePontuation = game.pontuation()
    
    for i in 0..<4 {
        var dif = styles[i] - abs(styles[i] - gamePontuation[i])
        result += dif * 100 / styles[i]
    }
    
    print("StylePontuation: \(result)")

    return result / 4
}

func mechanicPontuation(games: [Game]) -> Double{
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
    
    for elem in games[4].mechanics {
        game5Mechanics.insert(elem)
    }
    
    let result = (Double(mechanics.intersection(game5Mechanics).count) * 100) / Double(mechanics.count)
    
    print("MechanicPontuation: \(result)")
    
    return result
}

func addGames() -> [Game] {
    var games: [Game] = []
    
    games.append(Game(name: "Selecionar", playerCount: (0,0), hasTeams: false, mechanics: [], complexity: 0, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: false))
    
    games.append(Game(name: "Catan", playerCount: (3,4), hasTeams: false, mechanics: [Mechanics.dice, Mechanics.negotiation, Mechanics.strategy], complexity: 2.3, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: true))
    games.append(Game(name: "Carcassonne", playerCount: (2,5), hasTeams: false, mechanics: [Mechanics.tiles, Mechanics.strategy], complexity: 1.9, hasMiniObjectives: false, hasPointSalad: true, hasNegativeInteractions: true))
    games.append(Game(name: "Pandemic", playerCount: (2,4), hasTeams: false, mechanics: [Mechanics.setCollection, Mechanics.cooperative], complexity: 2.4, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: false))
    games.append(Game(name: "7 Wonders", playerCount: (3,7), hasTeams: false, mechanics: [Mechanics.drafting, Mechanics.setCollection], complexity: 2.3, hasMiniObjectives: false, hasPointSalad: true, hasNegativeInteractions: false))
    games.append(Game(name: "Codenames", playerCount: (3,8), hasTeams: true, mechanics: [Mechanics.socialDeduction], complexity: 1.3, hasMiniObjectives: true, hasPointSalad: false, hasNegativeInteractions: false))
    games.append(Game(name: "Azul", playerCount: (2,4), hasTeams: false, mechanics: [Mechanics.setCollection, Mechanics.tiles], complexity: 1.8, hasMiniObjectives: true, hasPointSalad: true, hasNegativeInteractions: true))
    games.append(Game(name: "Ticket to Ride", playerCount: (2,5), hasTeams: false, mechanics: [Mechanics.setCollection], complexity: 1.8, hasMiniObjectives: true, hasPointSalad: true, hasNegativeInteractions: true))
    games.append(Game(name: "Dixit", playerCount: (3,8), hasTeams: false, mechanics: [Mechanics.socialDeduction], complexity: 1.2, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: false))
    games.append(Game(name: "Coup", playerCount: (3,10), hasTeams: false, mechanics: [Mechanics.socialDeduction], complexity: 1.4, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: true))
    games.append(Game(name: "The Resistance", playerCount: (5,10), hasTeams: true, mechanics: [Mechanics.negotiation, Mechanics.socialDeduction], complexity: 1.6, hasMiniObjectives: false, hasPointSalad: false, hasNegativeInteractions: true))
    
    return games
}


