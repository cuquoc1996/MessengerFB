//
//  LanguagePickerViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 09/09/2025.
//

import UIKit

class LanguagePickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let languages = ["Tiếng Việt", "English", "日本語", "한국어", "中文"]
    
    let pickerView = UIPickerView()
    let containerView = UIView()
    let selectedLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        // Label hiển thị
        selectedLabel.text = "Chọn ngôn ngữ"
        selectedLabel.textAlignment = .center
        selectedLabel.font = .systemFont(ofSize: 20, weight: .medium)
        selectedLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(selectedLabel)
        
        NSLayoutConstraint.activate([
            selectedLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            selectedLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // Nút mở Picker
        let button = UIButton(type: .system)
        button.setTitle("Chọn ngôn ngữ", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.addTarget(self, action: #selector(showPicker), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: selectedLabel.bottomAnchor, constant: 30),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        // ContainerView (chứa Picker + nút đóng)
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 16
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        // PickerView
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(pickerView)
        
        // Nút đóng
        let closeButton = UIButton(type: .system)
        closeButton.setTitle("Đóng", for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        closeButton.addTarget(self, action: #selector(hidePicker), for: .touchUpInside)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(closeButton)
        
        // AutoLayout cho container
        NSLayoutConstraint.activate([
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            containerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
            containerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 300) // ẩn dưới màn hình
        ])
        
        // AutoLayout cho nút đóng + picker
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            pickerView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 8),
            pickerView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    // MARK: - Show / Hide Picker
    @objc func showPicker() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = CGAffineTransform(translationX: 0, y: -300) // trượt lên
        }
    }
    
    @objc func hidePicker() {
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = .identity // trở về dưới
        }
    }
    
    // MARK: - UIPickerView DataSource & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        languages[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLabel.text = "Ngôn ngữ: \(languages[row])"
    }
}
