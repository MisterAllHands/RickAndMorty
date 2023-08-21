//
//  CharacterCellViewViewModel.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import UIKit

final class CharacterCollectionCellViewModel: Hashable, Equatable {
    
     public let characterName: String
     public let characterStatus: CharacterStatus
     private let characterImageUrl: URL?
    
    // MARK: Init
    
    init(characterName: String,
         characterStatus: CharacterStatus,
         characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public func fetchImage(completion: @escaping(Result <Data,Error>) -> ()) {
        guard let url = characterImageUrl else {completion(.failure(URLError(.badURL)))
            return
        }
        //Downloading the image
        ImageLoader.shared.downloadImage(url, completion: completion)
    }
    
    //MARK: - Hashable
    
    static func == (lhs: CharacterCollectionCellViewModel, rhs: CharacterCollectionCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
}
