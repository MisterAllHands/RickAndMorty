//
//  CharacterStatus.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import Foundation


enum CharacterStatus: String, Codable {
    case alive = "Alive"
    case dead  = "Dead"
    case `unknown` = "unknown"
}
