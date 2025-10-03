//
//  ChatMessageTableViewCell.swift
//  MessengerFB
//
//  Created by MacBook Pro on 10/07/2025.
//

import UIKit

class ChatMessageTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let bubbleView = UIView()
        let messageLabel = UILabel()

        var leadingConstraint: NSLayoutConstraint!
        var trailingConstraint: NSLayoutConstraint!
        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            addSubview(bubbleView)
            bubbleView.layer.cornerRadius = 12
            bubbleView.translatesAutoresizingMaskIntoConstraints = false
            
            bubbleView.addSubview(messageLabel)
            messageLabel.numberOfLines = 0
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                messageLabel.topAnchor.constraint(equalTo: bubbleView.topAnchor, constant: 8),
                messageLabel.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor, constant: -8),
                messageLabel.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 12),
                messageLabel.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -12),
                
                bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
                bubbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
                bubbleView.widthAnchor.constraint(lessThanOrEqualToConstant: 250)
            ])
            
            leadingConstraint = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
            trailingConstraint = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setMessage(_ message: Message) {
            messageLabel.text = message.text
            if message.isIncoming {
                bubbleView.backgroundColor = UIColor(white: 0.90, alpha: 1)
                messageLabel.textColor = .black
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
            } else {
                bubbleView.backgroundColor = UIColor.systemBlue
                messageLabel.textColor = .white
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
            }
        }
}
