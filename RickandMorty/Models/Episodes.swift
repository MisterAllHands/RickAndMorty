//
//  Episodes.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import Foundation

struct EpisodeInfo: Codable {
    let count: Int
    let pages: Int
    let next: URL?
    let prev: URL?
}

struct EpisodeCharacter: Codable {
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [URL]
    let url: URL
    let created: String
}

struct EpisodeResults: Codable {
    let info: EpisodeInfo
    let results: [EpisodeCharacter]
}
