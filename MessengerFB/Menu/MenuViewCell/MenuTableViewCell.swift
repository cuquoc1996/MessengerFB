//
//  MenuTableViewCell.swift
//  MessengerFB
//
//  Created by MacBook Pro on 06/06/2025.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    @IBOutlet weak var imageCellMenu: UIImageView!
    @IBOutlet weak var customInCell: UILabel!
    @IBOutlet weak var nameCellMenu: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
//        configure()
        
    }
//    func configure() {
//        let themeTitle = UserDefaults.standard.string(forKey: "ThemeTitle") ?? "Hệ thống"
//        textLabel?.text = "Chế độ hiện tại: \(themeTitle)"
//    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
}
