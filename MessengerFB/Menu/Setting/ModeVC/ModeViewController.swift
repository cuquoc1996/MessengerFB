//
//  ModeViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 25/07/2025.
//

import UIKit

class ModeViewController: UIViewController {
    let titles = [
        0: "Bật",
        1: "Tắt",
        2: "Hệ thống"
    ]
    var selectedIndex: Int {
        get { UserDefaults.standard.integer(forKey: "SelectedThemeIndex") }
        set { UserDefaults.standard.set(newValue, forKey: "SelectedThemeIndex") }
    }
    
    @IBOutlet weak var viewMode: UIStackView!
    @IBOutlet var optionButtons: [UIButton]! // gom nhiều nút
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Chế độ tối"
        setupButtons()
        addSeparators()
    }
    
    private func setupButtons() {
        for button in optionButtons {
            if let title = titles[button.tag] {
                button.setTitle(title, for: .normal)
                let attrTitle = NSAttributedString(
                    string: title,
                    attributes: [
                        .font: UIFont(name: "Times New Roman", size: 14)!,
                        .foregroundColor: UIColor.label
                    ]
                )
                button.setAttributedTitle(attrTitle, for: .normal)
            }
            button.contentHorizontalAlignment = .left
            //            button.setTitleColor(.label, for: .normal)
            
            // tạo checkmark
            let checkmark = UIImageView(image: UIImage(systemName: "checkmark"))
            checkmark.tintColor = .systemBlue
            checkmark.tag = 1
            checkmark.isHidden = true
            checkmark.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(checkmark)
            
            // constraint checkmark luôn bên phải
            NSLayoutConstraint.activate([
                checkmark.centerYAnchor.constraint(equalTo: button.centerYAnchor),
                checkmark.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: -12),
                checkmark.widthAnchor.constraint(equalToConstant: 18),
                checkmark.heightAnchor.constraint(equalToConstant: 18)
            ])
            
            button.addTarget(self, action: #selector(optionTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc func optionTapped(_ sender: UIButton) {
        selectedIndex = sender.tag
        // Ẩn hết checkmark
        for button in optionButtons {
            if let checkmark = button.subviews.first(where: { $0.tag == 1 }) as? UIImageView {
                checkmark.isHidden = true
            }
            
            if let title = button.title(for: .normal) {
                let attrTitle = NSAttributedString(
                    string: title,
                    attributes: [
                        .font: UIFont(name: "Times New Roman", size: 14)!,
                        .foregroundColor: UIColor.label
                    ]
                )
                button.setAttributedTitle(attrTitle, for: .normal)
            }
        }
        
        // Hiện checkmark của nút vừa nhấn
        if let checkmark = sender.subviews.first(where: { $0.tag == 1 }) as? UIImageView {
            checkmark.isHidden = false
        }
        
        if let title = sender.title(for: .normal) {
            let attrTitle = NSAttributedString(
                string: title,
                attributes: [
                    .font: UIFont(name: "TimesNewRomanPS-BoldMT", size: 14)!,
                    .foregroundColor: UIColor.label
                ]
            )
            sender.setAttributedTitle(attrTitle, for: .normal)
        }
        
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        switch sender.tag {
        case 0: // Nút Dark
            window.overrideUserInterfaceStyle = .dark
            UserDefaults.standard.set("dark", forKey: "AppTheme")
        case 1: // Nút Light
            window.overrideUserInterfaceStyle = .light
            UserDefaults.standard.set("light", forKey: "AppTheme")
        case 2: // System
            window.overrideUserInterfaceStyle = .unspecified
            UserDefaults.standard.set("system", forKey: "AppTheme")
        default:
            break
        }
    }
    
    func addSeparators() {
        for (index, button) in optionButtons.enumerated() {
            // bỏ qua nút cuối cùng
            if index == optionButtons.count - 1 { continue }
            
            let line = UIView()
            line.backgroundColor = .lightGray
            line.translatesAutoresizingMaskIntoConstraints = false
            button.addSubview(line)
            
            // AutoLayout cho line nằm dưới button
            NSLayoutConstraint.activate([
                line.heightAnchor.constraint(equalToConstant: 1),
                line.leadingAnchor.constraint(equalTo: button.leadingAnchor, constant: 10),
                line.trailingAnchor.constraint(equalTo: button.trailingAnchor),
                line.bottomAnchor.constraint(equalTo: button.bottomAnchor)
            ])
        }
    }
}
