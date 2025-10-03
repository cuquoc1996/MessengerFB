//
//  UserTableViewCell.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    @IBOutlet weak var userStt: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var iconUserStt: UILabel!
    @IBOutlet weak var viewContainerStt: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius =
        userImage.frame.width / 2
        userImage.layer.borderWidth = 0.5
        viewContainerStt.backgroundColor = .clear
        viewContainerStt.layer.cornerRadius = 5
        viewContainerStt.layer.shadowColor = UIColor.black.cgColor
        viewContainerStt.layer.shadowOpacity = 0.3
        viewContainerStt.layer.shadowOffset = CGSize(width: 2, height: 2)
        viewContainerStt.layer.shadowRadius = 2
        iconUserStt.layer.cornerRadius = 5
        iconUserStt.layer.masksToBounds = true
        
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
