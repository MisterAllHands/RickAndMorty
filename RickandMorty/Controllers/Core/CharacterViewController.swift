//
//  CharacterViewController.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import UIKit


///Controller to show and serach for characters
 final class CharacterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        title = "Characters"
        
        ServiceAPI.shared.execute(.listCharacterRequests, expecting: String.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}
