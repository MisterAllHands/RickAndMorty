//
//  CharacterListViewViewModel.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import UIKit


final class CharacterListViewViewModel: NSObject {
    
    func fetchCharacters() {
        ServiceAPI.shared.execute(.listCharacterRequests, expecting: GetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds

        return CGSize(
            width: (bounds.width-30)/3,
            height: (bounds.width-30)/3 * 1.5
        )
    }
}
