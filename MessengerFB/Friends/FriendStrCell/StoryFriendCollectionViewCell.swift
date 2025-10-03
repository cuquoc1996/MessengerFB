//
//  StoryFriendCollectionViewCell.swift
//  MessengerFB
//
//  Created by MacBook Pro on 19/06/2025.
//

import UIKit

class StoryFriendCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var imageStory: UIImageView!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageUser.layer.cornerRadius = 20
        imageUser.backgroundColor = .gray
        // Initialization code
    }

}
