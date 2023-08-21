//
//  CharacterListViewViewModel.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 18/08/2023.
//

import UIKit



protocol CharacterListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadAdditionalCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: Character)
}

final class CharacterListViewViewModel: NSObject {
    
    public weak var delegate: CharacterListViewViewModelDelegate?
    private var isLoadingMoreCharacters = false
    
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
    private var apiInfo: Info? = nil
    
    ///Fetch Initial set of characters (20)
   public func fetchCharacters() {
        ServiceAPI.shared.execute(.listCharacterRequests, expecting: GetAllCharactersResponse.self){[weak self] result in
            switch result {
            case .success(let response):
                let initialResult = response.results
                let info = response.info
                self?.apiInfo = info
                self?.characters.append(contentsOf: initialResult)
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    public func fetchAdditionalCharacters(url: URL) {
        
        guard !isLoadingMoreCharacters else {
            return
        }
        isLoadingMoreCharacters = true
        guard let request = APIRequest(url: url) else {
            isLoadingMoreCharacters = false
            return
        }
        
        ServiceAPI.shared.execute(request,expecting: GetAllCharactersResponse.self) {[weak self] result in
            guard let strongSelf = self else {
                return
            }

            switch result {
            case .success(let response):
                let additionalResult = response.results
                let info = response.info
                strongSelf.apiInfo = info
                
                let initialCount = strongSelf.characters.count
                let additionalCount = additionalResult.count
                print("Initial Count: \(initialCount)")
                print(additionalCount)
                let total = initialCount+additionalCount
                print("totoal: \(total)")
                let startingIndex = total - additionalCount
                print("starting index: \(startingIndex)")
                print("Array: \(startingIndex+additionalCount)")
                let indexPToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+additionalCount)).compactMap({
                    return IndexPath(row: $0, section: 0)
                })
                strongSelf.characters.append(contentsOf: additionalResult)
                
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadAdditionalCharacters(with: indexPToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                    
                    
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreCharacters = false
            }
        }
    }
    
    public var shouldLoadMoreCharacters: Bool {
        return apiInfo?.next != nil
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard  kind == UICollectionView.elementKindSectionFooter,
               let footer = collectionView.dequeueReusableSupplementaryView(
                               ofKind: kind,
                               withReuseIdentifier: FooterCollectionLoadingCollectionReusableView.identfier,
                               for: indexPath) as? FooterCollectionLoadingCollectionReusableView else {
                        fatalError("Unsupported")
        }
        footer.startAnimating() 
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldLoadMoreCharacters else{
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
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

//MARK: - ScrollView

extension CharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldLoadMoreCharacters,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString )else {
            return
        }
        
        //Gets executed after 0.2 sec when user scrolls to the end of the collectionview
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) {[weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalFixedHeight - 120) {
                self?.fetchAdditionalCharacters(url: url)
            }
            t.invalidate()
        }
    }
}
