//
//  Games.swift
//  ValeAJogADA
//
//  Created by Pedro Vitor de Oliveira Monte on 16/05/24.
//

import Foundation

class Games {
    var playerCount: (Int, Int)
    var hasTeams: Bool
    var mechanics: [Mechanics]
    var complexity: Double
    var hasMiniObjectives: Bool
    var hasAssimetry: Bool
    var hasPointSalad: Bool
    var negativeInteractions: Bool
    
    
    init(playerCount: (Int, Int), hasTeams: Bool, mechanics: [Mechanics], complexity: Double, hasMiniObjectives: Bool, hasAssimetry: Bool, hasPointSalad: Bool, negativeInteractions: Bool) {
        self.playerCount = playerCount
        self.hasTeams = hasTeams
        self.mechanics = mechanics
        self.complexity = complexity
        self.hasMiniObjectives = hasMiniObjectives
        self.hasAssimetry = hasAssimetry
        self.hasPointSalad = hasPointSalad
        self.negativeInteractions = negativeInteractions
    }
    
    func pontuation() -> [Double] {
        var pont: [Double] = [0,0,0,0]
        
        if self.hasTeams {
            pont[1] += 1
        }
        
        if self.playerCount.1 >= 6 {
            pont[1] += Double(self.playerCount.1 / 6)
        }
        if self.complexity >= 2 {
            pont[2] += 1
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
    
    // assassino, socializador, explorer, achiever
    var pontuation: [Double] {
        switch self {
        case .dice:
            return [-1, 0, 0, 0]
        case .tiles:
            return [0,0,0,0]
        case .areaControl:
            return [1,0,0,1]
        case .drafting:
            return [0,0,1,1]
        case .workerPlacement:
            return [0,0,1,1]
        case .auction:
            return [0,1,0,1]
        case .deckBuilding:
            return [0,0,1,1]
        case .setCollection:
            return [0,0,0,1]
        case .negotiation:
            return [0,1,0,1]
        case .socialDeduction:
            return [1,1,0,1]
        case .cooperative:
            return [0,1,1,1]
        }
    }
}

func calculate(games: [Games]) -> Int{
    
    var stylePontuation: Int = calculateStyle(games: games)
    var mechanicPontuation: Int = mechanicPontuation(games: games)
    var result: Int
    
    
    result = (stylePontuation + mechanicPontuation) / 2
    return result
}

func calculateStyle(games: [Games]) -> Int
{
    var result: Int = 0
    
    return result
}

func mechanicPontuation(games: [Games]) -> Int{
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
    
    var result = (mechanics.intersection(game5Mechanics).count * 100) / mechanics.count
    
    return result
}
