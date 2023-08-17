//
//  Episodes.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import Foundation

struct Episode: Codable {
        let id: Int
        let name: String
        let  episode: String
        let  characters: [String]
        let  url: String
        let  created: String
}
