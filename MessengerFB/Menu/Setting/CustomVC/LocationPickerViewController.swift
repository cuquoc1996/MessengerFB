//
//  LocationPickerViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 23/09/2025.
//

import UIKit

class LocationPickerViewController: UIViewController {
    
    // MARK: - Properties
    private let pickerView = UIPickerView()
    private var provinces: [ProvinceFlat] = []
    private var selectedProvinceIndex = 0
    private var selectedWardIndex = 0
    
    /// Callback khi chọn xong
    var completion: ((String, String) -> Void)? // (province, ward)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        provinces = DataVnSource.loadProvinces()
        
        setupToolbar()
        setupPicker()
        pickerView.reloadAllComponents()
    }
    
    // MARK: - Setup Toolbar
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
    
    // MARK: - Setup Picker
    private func setupPicker() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.selectRow(selectedProvinceIndex, inComponent: 0, animated: false)
        
        view.addSubview(pickerView)
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }
    
    // MARK: - Actions
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    @objc private func doneTapped() {
        guard provinces.indices.contains(selectedProvinceIndex),
              provinces[selectedProvinceIndex].wards.indices.contains(selectedWardIndex)
        else { return }
        
        let province = provinces[selectedProvinceIndex]
        let ward = province.wards[selectedWardIndex]
        completion?(province.name, ward)
        dismiss(animated: true)
    }
}

// MARK: - UIPickerView DataSource & Delegate
extension LocationPickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2 // Tỉnh – Xã/Phường
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0: return provinces.count
        case 1:
            guard provinces.indices.contains(selectedProvinceIndex) else { return 0 }
            return provinces[selectedProvinceIndex].wards.count
        default: return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0: return provinces[row].name
        case 1: return provinces[selectedProvinceIndex].wards[row]
        default: return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedProvinceIndex = row
            selectedWardIndex = 0
            pickerView.reloadComponent(1)
            pickerView.selectRow(0, inComponent: 1, animated: true)
        case 1:
            selectedWardIndex = row
        default: break
        }
    }
}

