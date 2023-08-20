//
//  CharacterListViewViewModel.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import UIKit



protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadCharacters()
    func didSelectCharacter(_ character: Character)
}

final class CharacterListViewViewModel: NSObject {
    
    public weak var delegate: CharacterListViewViewModelDelegate?
    
    
    private var characters: [Character] = [] {
        didSet{
            for character in characters {
                let vm = CharacterCollectionCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                cellViewModels.append(vm)
            }
        }
    }
    private var cellViewModels: [CharacterCollectionCellViewModel] = []
    
    func fetchCharacters() {
        ServiceAPI.shared.execute(.listCharacterRequests, expecting: GetAllCharactersResponse.self){
            [weak self] result in
            switch result {
            case .success(let response):
                let results = response.results
                self?.characters = results
                DispatchQueue.main.async {
                    self?.delegate?.didLoadCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

extension CharacterListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
            for: indexPath) as? CharacterCollectionViewCell else {fatalError("Unsupported Cell")}
        let vm = cellViewModels[indexPath.row]
        cell.configure(with: vm)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        return CGSize(
            width: (bounds.width-30)/2,
            height: (bounds.width-30)/2 * 1.4
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}
