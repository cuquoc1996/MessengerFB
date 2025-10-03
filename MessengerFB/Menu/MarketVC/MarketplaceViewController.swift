//
//  marketplaceViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 01/07/2025.
//

import UIKit

class MarketplaceViewController: UIViewController {
    
    var isTabBarHidden = false // Theo dõi trạng thái tab bar
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Tạo stack view chứa các option
        let optionStack = UIStackView()
        optionStack.axis = .horizontal
        optionStack.alignment = .center
        optionStack.distribution = .fillEqually
        optionStack.spacing = 8
        //        optionStack.backgroundColor = .orange
        //        optionStack.translatesAutoresizingMaskIntoConstraints = true
        
        let titles = ["Tất cả", "Đến lượt bạn", "Đến lượt họ"]
        for title in titles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(.label, for: .normal)
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
            optionStack.addArrangedSubview(button)
            button.layer.cornerRadius = 15
            button.layer.borderWidth = 0.5
            button.layer.borderColor = UIColor.systemGray6.cgColor
            //            button.clipsToBounds = true
            button.backgroundColor = UIColor.systemGray6
        }
        
        // Tạo container view để đặt dưới navigation
        let containerView = UIView()
        containerView.addSubview(optionStack)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        optionStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // Constraint cho container view nằm ngay dưới navigation
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 30),
            
            optionStack.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 6),
            optionStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            optionStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            optionStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
        navigationItem.title = "Marketplace"
        
        // Tạo nút bên phải
        let rightButton = UIBarButtonItem(title: "Chỉnh sửa", style: .plain, target: self, action: #selector(toggleTabBar))
        
        // Gắn vào navigation bar
        navigationItem.rightBarButtonItem = rightButton
        rightButton.tintColor = .systemBlue
    }
    
    @objc func optionTapped(_ sender: UIButton) {
        guard let title = sender.title(for: .normal) else { return }
        print("Tapped option: \(title)")
        for case let button as UIButton in sender.superview?.subviews ?? [] {
            button.layer.borderColor = UIColor.label.cgColor
        }
        sender.layer.borderColor = UIColor.green.cgColor
    }
    
    @objc func toggleTabBar() {
        print("Bạn đã nhấn nút chỉnh sửa!")
        guard let tabBar = self.tabBarController?.tabBar else { return }
        isTabBarHidden.toggle()
        
        // Ẩn/hiện tab bar với animation
        UIView.animate(withDuration: 0.3) {
            tabBar.isHidden = self.isTabBarHidden
        }
        
        // Cập nhật title của nút
        navigationItem.rightBarButtonItem?.title = isTabBarHidden ? "Xong" : "Chỉnh sửa"
    }
}

