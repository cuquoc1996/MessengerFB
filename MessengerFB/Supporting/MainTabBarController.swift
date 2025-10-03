//
//  MainTabBarViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import UIKit
class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
    }
    
    //setup TabBar
    func setupTabs() {
        
        let messageVC = MessengerViewController()
        messageVC.tabBarItem.title = "Massage"
        messageVC.navigationItem.title = ""
        messageVC.tabBarItem.image = UIImage(named: "icons8-message-50")
        messageVC.tabBarItem.badgeValue = "60"
        messageVC.tabBarItem.badgeColor = .systemBlue
        
        let friendVC = FriendViewController()
        friendVC.tabBarItem.title = "Friend"
        friendVC.navigationItem.title = ""
        friendVC.tabBarItem.image = UIImage(named: "friends")
        friendVC.tabBarItem.badgeValue = "11"
        friendVC.tabBarItem.badgeColor = .systemBlue
        
        let menuVC = MenuViewController()
        menuVC.tabBarItem.title = "Menu"
        menuVC.navigationItem.title = ""
        menuVC.tabBarItem.image = UIImage(named: "icons8-menu-50")
        viewControllers = [
            UINavigationController(rootViewController: messageVC),
            UINavigationController(rootViewController: friendVC),UINavigationController(rootViewController: menuVC)
        ]
    }
}


