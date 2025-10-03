//
//  SettingViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/06/2025.
//

import UIKit

class SettingViewController: UIViewController {
    // MARK: - Properties
    var selectedDate: Date?
    var selectedLanguage: String?
    var selectedCountry: String?
    var selectedProvince: String?
    var selectedWard: String?
    
    
    /// Danh sách ngôn ngữ (code + hiển thị)
    let languages = DataLanguageSource.commonLanguages
    
    /// Danh sách quốc gia (code + tên hiển thị)
    let countries = DataCountrySource.allCountries
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var ProfileBt: UIButton!
    @IBOutlet weak var adressProfile: UILabel!
    @IBOutlet weak var nameProfileSetting: UILabel!
    @IBOutlet weak var tableViewSetting: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Thông tin cá nhân"
        
        nameProfileSetting.text = "HVDH"
        imageProfile.layer.cornerRadius = 40
        tableViewSetting.isScrollEnabled = false
        setupTableView()
        
        // Load ngày đã lưu
        if let savedDate = UserDefaults.standard.object(forKey: "dob") as? Date {
            selectedDate = savedDate
        }
        // Load ngôn ngữ đã lưu
        if let savedCode = UserDefaults.standard.string(forKey: "languageCode"),
           let lang = languages.first(where: { $0.code == savedCode }) {
            selectedLanguage = lang.name
        }
        // Lưu quốc gia đã chọn
        if let savedCountry = UserDefaults.standard.string(forKey: "countryCode"),
           let country = countries.first(where: { $0.code == savedCountry }) {
            selectedCountry = country.name
        }
        // Load địa phương ở VN
        selectedProvince = UserDefaults.standard.string(forKey: "selectedProvince")
        selectedWard = UserDefaults.standard.string(forKey: "selectedWard")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableViewSetting.reloadData()
    }
}

// MARK: - TableView
extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { settingGroupCell.count }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settingGroupCell[section].dataSetting.count
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat { 10 }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? { UIView() }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.section == 4 ? 170 : 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 4 {
            return tableView.dequeueReusableCell(withIdentifier: "SettingCenterTableViewCell", for: indexPath)
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let item = settingGroupCell[indexPath.section].dataSetting[indexPath.row]
        
        // Default
        cell.nameCellMenu.text = item.title
        cell.imageCellMenu.image = UIImage(named: item.imageName)
        cell.customInCell.text = nil
        cell.customInCell.isHidden = true
        
        if indexPath.section == 1 && indexPath.row == 0 { // Cell chọn địa phương
            if let province = selectedProvince, let ward = selectedWard {
                cell.customInCell.text = "\(ward) - \(province)"
            } else {
                cell.customInCell.text = "Chọn địa phương"
            }
            if cell.customInCell.text != nil {
                cell.customInCell.textColor = .secondaryLabel
                cell.customInCell.font = .systemFont(ofSize: 14)
                cell.customInCell.isHidden = false
            }
        }
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0: // Active Status
                let isActive = UserDefaults.standard.bool(forKey: "ActiveStatusEnabled")
                cell.customInCell.text = isActive ? "Bật" : "Tắt"
            case 1: // Dark Mode
                let idx = UserDefaults.standard.integer(forKey: "SelectedThemeIndex")
                let options = [0: "Bật", 1: "Tắt", 2: "Hệ thống"]
                cell.customInCell.text = options[idx] ?? "Hệ thống"
            case 2: // Picker Date
                if let date = selectedDate {
                    let formatter = DateFormatter()
                    formatter.dateStyle = .medium
                    formatter.locale = Locale(identifier: "vi_VN")
                    cell.customInCell.text = formatter.string(from: date)
                } else {
                    cell.customInCell.text = "Chọn ngày sinh"
                }
            case 3: // Country
                cell.customInCell.text = selectedCountry ?? "Chọn quốc gia"
                
            case 4: // Language
                cell.customInCell.text = selectedLanguage ?? "Chọn ngôn ngữ"
            default: break
            }
            
            if cell.customInCell.text != nil {
                cell.customInCell.textColor = .secondaryLabel
                cell.customInCell.font = .systemFont(ofSize: 14)
                cell.customInCell.isHidden = false
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        if indexPath.section == 3 && indexPath.row == 3 {
            showConfirmAlert(title: "Đăng xuất",
                             message: "Bạn muốn thoát Messenger?",
                             okTitle: "Tiếp tục") {
                if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
                    sceneDelegate.changeRootViewController(LoginViewController())
                }
            }
        }
        
        if indexPath.section == 1 {
            let locationVC = LocationPickerViewController()
            locationVC.completion = { [weak self] province, ward in
                guard let self = self else { return }
                self.selectedProvince = province
                self.selectedWard = ward
                
                // Lưu UserDefaults nếu muốn
                UserDefaults.standard.set(province, forKey: "selectedProvince")
                UserDefaults.standard.set(ward, forKey: "selectedWard")
                
                // Reload cell để hiển thị
                self.tableViewSetting.reloadRows(at: [indexPath], with: .none)
            }
            // Tùy chọn trình bày sheet
            if let sheet = locationVC.sheetPresentationController {
                sheet.detents = [.custom { $0.maximumDetentValue * 0.4 }]
                sheet.prefersGrabberVisible = true
                sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            }
            present(locationVC, animated: true)
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let mapVC = MapViewController()
            navigationController?.pushViewController(mapVC, animated: true)
        }
        
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                navigationController?.pushViewController(ActiveStatusViewController(), animated: true)
            case 1:
                navigationController?.pushViewController(ModeViewController(), animated: true)
            case 2:
                let pickerVC = DatePickerViewController()
                pickerVC.initialDate = selectedDate
                pickerVC.completion = { [weak self] date in
                    if let date = date {
                        self?.selectedDate = date
                        UserDefaults.standard.set(date, forKey: "dob")
                        self?.tableViewSetting.reloadRows(at: [indexPath], with: .none)
                    }
                }
                if let sheet = pickerVC.sheetPresentationController {
                    sheet.detents = [.custom { $0.maximumDetentValue * 0.4 }]
                    sheet.prefersGrabberVisible = true
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                }
                present(pickerVC, animated: true)
                
            case 3: // Country
                let pickerVC = LanguagePickerViewController() // ✅ tái sử dụng luôn
                pickerVC.languages = countries.map { $0.name }
                pickerVC.selectedIndex = countries.firstIndex { $0.name == (selectedCountry ?? "") } ?? 0
                
                pickerVC.completion = { [weak self] countryName in
                    guard let self = self else { return }
                    if let country = self.countries.first(where: { $0.name == countryName }) {
                        self.selectedCountry = country.name
                        UserDefaults.standard.set(country.code, forKey: "countryCode")
                        self.tableViewSetting.reloadRows(at: [indexPath], with: .none)
                    }
                }
                
                if let sheet = pickerVC.sheetPresentationController {
                    sheet.detents = [.custom { $0.maximumDetentValue * 0.4 }]
                    sheet.prefersGrabberVisible = true
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                }
                present(pickerVC, animated: true)
                
            case 4: // Language
                let pickerVC = LanguagePickerViewController()
                pickerVC.languages = languages.map { $0.name }
                pickerVC.selectedIndex = languages.firstIndex { $0.name == (selectedLanguage ?? "") } ?? 0
                
                // Nhận về ngôn ngữ user chọn
                pickerVC.completion = { [weak self] langName in
                    guard let self = self else { return }
                    if let lang = self.languages.first(where: { $0.name == langName }) {
                        self.showConfirmAlert(
                            title: "Khởi động lại",
                            message: "Ứng dụng sẽ khởi động lại để áp dụng ngôn ngữ \(lang.name)?"
                        ) {
                            self.selectedLanguage = lang.name
                            UserDefaults.standard.set(lang.code, forKey: "languageCode")
                            self.tableViewSetting.reloadRows(at: [indexPath], with: .none)
                        }
                    }
                }
                
                if let sheet = pickerVC.sheetPresentationController {
                    sheet.detents = [.custom { $0.maximumDetentValue * 0.4 }]
                    sheet.prefersGrabberVisible = true
                    sheet.prefersScrollingExpandsWhenScrolledToEdge = false
                }
                present(pickerVC, animated: true)
            default: break
            }
        }
    }
}

// MARK: - Private Helpers
private extension SettingViewController {
    func setupTableView() {
        tableViewSetting.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        tableViewSetting.register(UINib(nibName: "SettingCenterTableViewCell", bundle: nil), forCellReuseIdentifier: "SettingCenterTableViewCell")
        tableViewSetting.delegate = self
        tableViewSetting.dataSource = self
    }
    
    /// ✅ Alert confirm dùng chung
    func showConfirmAlert(title: String,
                          message: String,
                          okTitle: String = "Đồng ý",
                          cancelTitle: String = "Huỷ",
                          okHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel))
        alert.addAction(UIAlertAction(title: okTitle, style: .default) { _ in
            okHandler?()
        })
        present(alert, animated: true)
    }
}
