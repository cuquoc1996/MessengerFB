//
//  LanguagePickerViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 22/09/2025.
//

import UIKit

class LanguagePickerViewController: UIViewController {
    var languages: [String] = []
    var selectedIndex: Int = 0
    var completion: ((String?) -> Void)?
    
    private let picker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupToolbar()
        setupPicker()
    }
    
    private func setupToolbar() {
        let toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain,
                                     target: self, action: #selector(cancelTapped))
        let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                   target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .done,
                                   target: self, action: #selector(doneTapped))
        toolbar.setItems([cancel, flex, done], animated: false)
        
        view.addSubview(toolbar)
        NSLayoutConstraint.activate([
            toolbar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
    
    private func setupPicker() {
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        picker.selectRow(selectedIndex, inComponent: 0, animated: false)
        
        view.addSubview(picker)
        NSLayoutConstraint.activate([
            picker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            picker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            picker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            picker.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true) {
            self.completion?(nil)
        }
    }
    
    @objc private func doneTapped() {
        dismiss(animated: true) {
            let lang = self.languages[self.picker.selectedRow(inComponent: 0)]
            self.completion?(lang)
        }
    }
}

extension LanguagePickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return languages.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
}

