//
//  CollectionViewCell.swift
//  MessengerFB
//
//  Created by MacBook Pro on 16/05/2025.
//

import UIKit

class UserStoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameStory: UILabel!
    @IBOutlet weak var imageUser: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUser.layer.cornerRadius = imageUser.frame.width / 2
        imageUser.layer.borderWidth = 1.4
        imageUser.layer.borderColor = UIColor.green.cgColor
    }
}
