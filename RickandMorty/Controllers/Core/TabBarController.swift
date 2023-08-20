//
//  ViewController.swift
//  RickandMorty
//
//  Created by TTGMOTSF on 17/08/2023.
//

import UIKit



///Controller to house tabs and root tab controllers
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .white
        // Configure the tab bar appearance
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.backgroundColor = UIColor(named: "backgroundColor_app")
        tabBar.standardAppearance = tabBarAppearance
        setUpTabs()
    }
    
  private func setUpTabs(){
      let characterVC = CharacterViewController()
      let locationVC = LocationViewController()
      let episodesVC = EpisodesViewController()
      
      characterVC.navigationItem.largeTitleDisplayMode = .automatic
      locationVC.navigationItem.largeTitleDisplayMode = .automatic
      episodesVC.navigationItem.largeTitleDisplayMode = .automatic

      let nav1 = UINavigationController(rootViewController: characterVC)
      let nav2 = UINavigationController(rootViewController: locationVC)
      let nav3 = UINavigationController(rootViewController: episodesVC)
      
      nav1.tabBarItem = UITabBarItem(title: "Characters",
                                     image: UIImage(systemName: "person"),
                                     tag: 1)
      nav2.tabBarItem = UITabBarItem(title: "Locations",
                                     image: UIImage(systemName: "globe"),
                                     tag: 2)
      nav3.tabBarItem = UITabBarItem(title: "Episodes",
                                     image: UIImage(systemName: "play"),
                                     tag: 3)
      
      for nav in [nav1, nav2, nav3] {
          nav.navigationBar.prefersLargeTitles = true
      }

      setViewControllers([nav1, nav2, nav3], animated: true)
    }
}
