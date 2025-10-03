//
//  ChatViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 04/07/2025.
//

import UIKit

class ChatViewController: UIViewController {
    
    var user: MyModel?

    let tableView = UITableView()
    let inputContainerView = UIView()
    let inputTextView = UITextView()
    let sendButton = UIButton(type: .system)
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6 
        title = user?.title ?? "Chat"
        setupChatLabel()
        setupNavigationBarChat()
    }
    
    func setupChatLabel() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Đây là đoạn chat với \(user?.title ?? "người dùng")"
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupNavigationBarChat() {
        
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(named: "icons8-back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        let userImageBt = UIButton(type: .system)
        userImageBt.setImage(UIImage(named: "\(user?.imageName ?? "")"), for: .normal)
        userImageBt.addTarget(self, action: #selector(tapUserImageBt), for: .touchUpInside)
        
        let myLabel = UILabel()
        myLabel.text = user?.status
        myLabel.textColor = .systemGreen
        myLabel.font = UIFont.systemFont(ofSize: 10)
        myLabel.textAlignment = .center
        myLabel.numberOfLines = 0 // Cho phép nhiều dòng
        
        let stack = UIStackView(arrangedSubviews: [userImageBt,myLabel])
        stack.axis = .vertical
        stack.spacing = 2 // 👈 spacing giữa 2 nút
        
        let stackLeft = UIStackView(arrangedSubviews: [backButton,stack])
        stackLeft.axis = .horizontal
        stackLeft.spacing = 8
        
        let customBarItem = UIBarButtonItem(customView: stackLeft)
        navigationItem.leftBarButtonItem = customBarItem
        
        // 2 nút dùng làm custion view rightBarButton
        let videoPhoneBt = UIButton(type: .system)
        videoPhoneBt.setImage(UIImage(named: "icons8-video-50"), for: .normal)
        videoPhoneBt.addTarget(self, action: #selector(videoPhoneBtTapped), for: .touchUpInside)
        
        let phoneButton = UIButton(type: .system)
        phoneButton.setImage(UIImage(named: "icons8-telephone-50"), for: .normal)
        phoneButton.addTarget(self, action: #selector(phoneTapped), for: .touchUpInside)
        
        // Custom spacing bằng cách gói 2 button vào 1 stack view
        let stackRight = UIStackView(arrangedSubviews: [phoneButton,videoPhoneBt])
        stackRight.axis = .horizontal
        stackRight.spacing = 10 // 👈 spacing giữa 2 nút
        
        let customBarItemRight = UIBarButtonItem(customView: stackRight)
        navigationItem.rightBarButtonItem = customBarItemRight
        
    }
    
    @objc func tapUserImageBt() {
        print("User tapped")
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func videoPhoneBtTapped() {
        
    }
    
    @objc func phoneTapped() {
        
    }
}
