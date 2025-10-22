//
//  SceneDelegate.swift
//  MessengerFB
//
//  Created by MacBook Pro on 12/05/2025.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let loginVC = LoginViewController()
    
    func changeRootViewController(_ vc: UIViewController, animated: Bool = true){
        guard let window = self.window else { return }
        window.rootViewController = loginVC
        if animated {
            UIView.transition(with: window, duration: 0.5, animations: nil,completion: nil)
        }
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = UINavigationController(rootViewController: LoginViewController())
        self.window = window
        window.makeKeyAndVisible()
        self.window?.makeKeyAndVisible()
        setupAppearance()
        // Đọc theme từ UserDefaults (nếu có)
        let theme = UserDefaults.standard.string(forKey: "AppTheme") ?? "system"
        switch theme {
        case "dark":
            window.overrideUserInterfaceStyle = .dark
        case "light":
            window.overrideUserInterfaceStyle = .light
        default:
            window.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    private func setupAppearance() {
        // MARK: - TabBar
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        
        UITabBar.appearance().tintColor = .systemBlue
        UITabBar.appearance().unselectedItemTintColor = .secondaryLabel
        UITabBar.appearance().standardAppearance = tabBarAppearance
        if #available(iOS 15.0, *) {
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        }
        
        // MARK: - NavigationBar
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithDefaultBackground()
        UINavigationBar.appearance().tintColor = .systemBlue
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }
    
    func sceneWillResignActive(_ scene: UIScene) {
        
    }
    
    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }
}

