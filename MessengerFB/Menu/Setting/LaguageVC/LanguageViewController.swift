//
//  LanguageViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 29/08/2025.
//

import UIKit

class LanguageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    let languages = ["Tiếng Việt", "English", "日本語", "한국어"]
    var selectedLanguage = UserDefaults.standard.string(forKey: "AppLanguage") ?? "Tiếng Việt"
    
    @IBAction func chooseLanguageTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Chọn ngôn ngữ", message: "\n\n\n\n\n\n\n\n", preferredStyle: .alert)
        
        let picker = UIPickerView(frame: CGRect(x: 5, y: 20, width: 250, height: 140))
        picker.delegate = self
        picker.dataSource = self
        
        if let index = languages.firstIndex(of: selectedLanguage) {
            picker.selectRow(index, inComponent: 0, animated: false)
        }
        
        alert.view.addSubview(picker)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            let row = picker.selectedRow(inComponent: 0)
            self.selectedLanguage = self.languages[row]
            UserDefaults.standard.set(self.selectedLanguage, forKey: "AppLanguage")
            
            NotificationCenter.default.post(name: NSNotification.Name("LanguageChanged"), object: nil)
        }
        
        alert.addAction(okAction)
        alert.addAction(UIAlertAction(title: "Huỷ", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - UIPickerView DataSource & Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { languages.count }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return languages[row]
    }
}
