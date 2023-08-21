//
//  Character.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import Foundation


struct Character: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String?
    let gender: CharacterGender
    let origin: Origin
    let location: SinleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    var displayType: String {
        return type?.isEmpty ?? true ? "None" : type!
    }
}

