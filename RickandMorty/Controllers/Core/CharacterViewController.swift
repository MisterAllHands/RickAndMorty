//
//  CharacterViewController.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import SwiftUI
import UIKit


///Controller to show and serach for characters
 final class CharacterViewController: UIViewController, CharacterListViewDelegate {
    
     private let characterListView = CharacterListView()

     
     private let imageView: UIImageView = {
         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 245, height: 120))
         imageView.image = UIImage(named: "charactertitle")
         return imageView
     }()
     
     private let portalImage: UIImageView = {
         let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 250, height: 300))
         imageView.image = UIImage(named: "portal")
         return imageView
     }()
     
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.isTranslucent = false

        view.backgroundColor = UIColor(named: "backgroundColor_app")
        view.addSubview(imageView)
        view.addSubview(characterListView)
        setUpConstraints()
    }
     
     
     private func setUpConstraints(){
         characterListView.delegate = self
         NSLayoutConstraint.activate([
             characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
             characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
             characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
             characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
         ])
     }
     
     //MARK: Delegate for CharacterListViewDelegate
     
     func rmCharacterListView(_ characterListView: CharacterListView, didSelectCharacter character: Character) {
         navigateToCharacterDetailView(character: character)
     }
     
     func navigateToCharacterDetailView(character: Character) {
         let characterDetailView = CharacterDetailView(character: character)
         let hostingController = UIHostingController(rootView: characterDetailView)
         navigationController?.pushViewController(hostingController, animated: true)
     }

}
