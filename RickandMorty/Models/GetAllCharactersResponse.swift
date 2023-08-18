//
//  GetCharactersResponse.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import Foundation


struct GetAllCharactersResponse: Codable {
    
    let info: Info
    let results: [Character]
}

struct Info: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
