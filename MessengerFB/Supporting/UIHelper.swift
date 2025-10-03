//
//  UIHelper.swift
//  MessengerFB
//
//  Created by MacBook Pro on 15/05/2025.
//

import UIKit

struct UIHelper {
    
    // MARK: - Button Appearance
    static func styleButton(
        _ button: UIButton,
        titleColor: UIColor = .white,
        backgroundColor: UIColor = .systemBlue,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat = 0,
        cornerRadius: CGFloat = 8
    ) {
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.layer.masksToBounds = true
        if let borderColor = borderColor {
            button.layer.borderColor = borderColor.cgColor
            button.layer.borderWidth = borderWidth
        }
    }
    
    // MARK: - Generic View Styling
    static func styleView(
        _ view: UIView,
        backgroundColor: UIColor = .clear,
        borderColor: UIColor? = nil,
        borderWidth: CGFloat = 0,
        cornerRadius: CGFloat = 0
    ) {
        view.backgroundColor = backgroundColor
        view.layer.cornerRadius = cornerRadius
        view.layer.masksToBounds = true
        
        if let borderColor = borderColor {
            view.layer.borderColor = borderColor.cgColor
            view.layer.borderWidth = borderWidth
        }
    }
    
    // MARK: - Label Text Color
    static func styleLabel(
        _ label: UILabel,
        textColor: UIColor,
        backgroundColor: UIColor = .clear,
        masksToBound: Bool = true
    ) {
        label.textColor = textColor
        label.backgroundColor = backgroundColor
        label.layer.masksToBounds = masksToBound
    }
    
    // MARK: - Add Shadow
    static func addShadow(
        to view: UIView,
        color: UIColor = .black,
        opacity: Float = 0.1,
        radius: CGFloat = 4,
        offset: CGSize = CGSize(width: 0, height: 2)
    ) {
        view.layer.shadowColor = color.cgColor
        view.layer.shadowOpacity = opacity
        view.layer.shadowRadius = radius
        view.layer.shadowOffset = offset
        view.layer.masksToBounds = false
    }
}

struct AppColors {
    static let primary = UIColor(red: 0.25, green: 0.47, blue: 0.85, alpha: 1)
    static let danger  = UIColor(red: 1.0, green: 0.23, blue: 0.19, alpha: 1)
    static let success = UIColor(red: 0.2, green: 0.7, blue: 0.3, alpha: 1)
    static let primaryColor = UIColor(red: 65/255, green: 105/255, blue: 225/255, alpha: 1)
    static let emeraldGreen = UIColor(red: 52/255, green: 168/255, blue: 83/255, alpha: 1)
    static let lightGray =  UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
    static let sunsetOrange =  UIColor(red: 255/255, green: 94/255, blue: 87/255, alpha: 1)
}

struct MyModel {
    let title: String
    let imageName: String
    let status: String
}

let dataUser: [MyModel] = [
    MyModel(title: "Van Ho Quoc", imageName: "friends", status: "Đang hoạt động"),
    MyModel(title: "Trần Công Sơn", imageName: "friends", status: "15p"),
    MyModel(title: "Du Thuỷ", imageName: "friends", status: "Đang hoạt động"),
    MyModel(title: "Trần Công Hoàng", imageName: "iconUser", status: "1 day"),
    MyModel(title: "Trần Thị Mai", imageName: "icons8-girl-50", status: "Đang hoạt động"),
    MyModel(title: "Hồ Hùng Ôtô", imageName: "iconUser", status: "1 day"),
    MyModel(title: "Linh Hồ", imageName: "iconUser", status: "1 day"),
    MyModel(title: "Hồ Lựu", imageName: "iconUser", status: "1 day"),
    MyModel(title: "Trần Thanh", imageName: "iconUser", status: "1 day"),
    MyModel(title: "Phạm Ngọc Hạnh", imageName: "iconUser", status: "Đang hoạt động"),
    MyModel(title: "Peter", imageName: "iconUser", status: "Đang hoạt động")
]

struct CellMenuType {
    let imageName: String
    let title: String
}

struct MenuGroup {
    let dataPofile: [MyModel]
    let dataMenu: [CellMenuType]
}

let menuGroupCell: [MenuGroup] = [
    MenuGroup(dataPofile: [MyModel(title: "Van Ho Quoc", imageName: "friends", status: "Chuyển trang cá nhân")], dataMenu: [CellMenuType(imageName: "", title: "")])
    ,
    MenuGroup(dataPofile: [MyModel(title: "", imageName: "", status: "")], dataMenu: [CellMenuType(imageName: "icons8-setting", title: "Cài đặt")]),
    MenuGroup(dataPofile: [MyModel(title: "", imageName: "", status: "")], dataMenu: [CellMenuType(imageName: "icons8-market", title: "Marketplace"), CellMenuType(imageName: "icons8-ask-question", title: "Hỗ trợ"), CellMenuType(imageName: "icons8-messenger-50", title: "Tin nhắn đang chờ"), CellMenuType(imageName: "icons8-save", title: "Kho lưu trữ")])
    ,
    MenuGroup(dataPofile: [MyModel(title: "", imageName: "", status: "")], dataMenu: [CellMenuType(imageName: "icons8-user-group", title: "Lời mời kết bạn")])
]

struct CellSettingType {
    let imageName: String
    let title: String
    let titleStt: String
}

struct CellCenterType {
    let title: String
}

struct SettingGroup {
    let dataSetting: [CellSettingType]
    let dataCenter: [CellCenterType]
}

let settingGroupCell: [SettingGroup] = [
    SettingGroup(dataSetting: [CellSettingType(imageName: "icons8-setting", title: "Trạng thái hoạt động", titleStt: "Đã bật"), CellSettingType(imageName: "", title: "Chế độ tối", titleStt: "Hệ thống"), CellSettingType(imageName: "", title: "Ngày sinh", titleStt: ""),CellSettingType(imageName: "", title: "Quốc tịch", titleStt: ""), CellSettingType(imageName: "", title: "Ngôn ngữ", titleStt: "Tiếng Việt")], dataCenter: [CellCenterType(title: "")]),
    SettingGroup(dataSetting: [CellSettingType(imageName: "", title: "Địa chỉ", titleStt: "")], dataCenter: [CellCenterType(title: "")]),
    SettingGroup(dataSetting: [CellSettingType(imageName: "", title: "Bản đồ", titleStt: ""), CellSettingType(imageName: "", title: "Avatar", titleStt: ""),CellSettingType(imageName: "", title: "Tên người dùng", titleStt: "@hvqzzzzz"),CellSettingType(imageName: "", title: "Thông báo và âm thanh", titleStt: "Đang bật"),CellSettingType(imageName: "", title: "Đơn đặt hàng", titleStt: ""),CellSettingType(imageName: "", title: "Ảnh và file phương tiện", titleStt: ""),CellSettingType(imageName: "", title: "Kỷ niệm", titleStt: "")], dataCenter: [CellCenterType(title: "")]),
    SettingGroup(dataSetting: [CellSettingType(imageName: "", title: "Báo cáo sự cố", titleStt: ""),CellSettingType(imageName: "", title: "Trợ giúp", titleStt: ""),CellSettingType(imageName: "", title: "Pháp lý và chính sách", titleStt: ""), CellSettingType(imageName: "icons8-log-out-50", title: "Đăng xuất", titleStt: "")], dataCenter: [CellCenterType(title: "")]),
    SettingGroup(dataSetting: [CellSettingType(imageName: "", title: "", titleStt: "")], dataCenter: [CellCenterType(title: "")])
]

struct Message {
    let text: String
    let isIncoming: Bool
}




