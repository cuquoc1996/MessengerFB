//
//  MainTabBarViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import UIKit
class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    private let halfDelegate = HalfWidthTransitioningDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabs()
        delegate = self
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
        
        let panelVC = UIViewController()
        panelVC.tabBarItem = UITabBarItem(title: "Panel", image: UIImage(systemName: "sidebar.right"), tag: 3)
        
        viewControllers = [
            UINavigationController(rootViewController: messageVC),
            UINavigationController(rootViewController: friendVC),
            UINavigationController(rootViewController: menuVC),
            UINavigationController(rootViewController: panelVC)
        ]
    }
    
    // Ngăn TabBar chuyển tab, chỉ show panel
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController.tabBarItem.tag == 3 {
            presentHalfWidthPanel()
            return false // Không chuyển tab thật
        }
        return true
    }
    
    private func presentHalfWidthPanel() {
        let halfVC = HalfModalViewController()
        let nav = UINavigationController(rootViewController: halfVC) // 👈 bọc trong Navigation
        nav.modalPresentationStyle = .custom
        nav.transitioningDelegate = halfDelegate
        present(nav, animated: true)
    }
}
