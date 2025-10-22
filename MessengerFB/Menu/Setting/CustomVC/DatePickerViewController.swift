//
//  BirthdatePickerViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 22/09/2025.
//

import UIKit

// MARK: - DatePickerViewController
class DatePickerViewController: UIViewController {
    var initialDate: Date?
    var completion: ((Date?) -> Void)?
    
    private let datePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setupToolbar()
        setupDatePicker()
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
    
    private func setupDatePicker() {
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        }
        datePicker.maximumDate = Date()
        
        if let date = initialDate {
            datePicker.date = date
        }
        
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            datePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            datePicker.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true) {
            self.completion?(nil)
        }
    }
    
    @objc private func doneTapped() {
        dismiss(animated: true) {
            self.completion?(self.datePicker.date)
        }
    }
}

