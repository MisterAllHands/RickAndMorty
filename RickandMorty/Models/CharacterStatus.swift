//
//  CharacterStatus.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import UIKit


enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead  = "Dead"
    case `unknown` = "unknown"
    
    var color: UIColor {
            switch self {
            case .alive:
                return .green
            case .dead:
                return .red
            case .unknown:
                return .yellow
            }
        }
}
