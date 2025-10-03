//
//  StatusFriendTableViewCell.swift
//  MessengerFB
//
//  Created by MacBook Pro on 19/06/2025.
//

import UIKit

class StatusFriendTableViewCell: UITableViewCell {
    
    var popupView: UIStackView?
    let emotions = ["❤️", "😂", "😮", "😢", "😡", "👍", "👎"]
    var onEmotionSelected: ((String) -> Void)? // Gọi về ViewController nếu cần
    @IBOutlet weak var reactButton: UIButton!
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var SttUser: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        reactButton.setTitle("🤍", for: .normal)
        //        reactButton.titleLabel?.font = .systemFont(ofSize: 30)
        reactButton.addTarget(self, action: #selector(showEmotionPopup), for: .touchUpInside)
        //        reactButton.imageView?.contentMode = .scaleAspectFill
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @objc func showEmotionPopup() {
        // Nếu popup đã hiện thì ẩn đi
        if let existing = popupView {
            hidePopup(existing)
            return
        }
        // Tạo popup mới
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        stack.distribution = .equalSpacing
        stack.backgroundColor = .systemGray6
        stack.layer.cornerRadius = 25
        //        stack.layer.borderWidth = 1
        stack.layer.borderColor = UIColor.lightGray.cgColor
        stack.layoutMargins = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 6)
        stack.isLayoutMarginsRelativeArrangement = true
        stack.alpha = 0
        
        for emo in emotions {
            let btn = UIButton(type: .system)
            btn.setTitle(emo, for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 28)
            btn.addTarget(self, action: #selector(emotionTapped(_:)), for: .touchUpInside)
            stack.addArrangedSubview(btn)
        }
        contentView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        // Gắn dưới reactButton
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: reactButton.topAnchor, constant: -16),
            stack.trailingAnchor.constraint(equalTo: reactButton.trailingAnchor),
            stack.heightAnchor.constraint(equalToConstant: 50),
            stack.widthAnchor.constraint(lessThanOrEqualToConstant: 300)
        ])
        popupView = stack
        UIView.animate(withDuration: 0.2) {
            stack.alpha = 1
        } completion: { _ in
            // Animate từng icon bay ra
            for (index, view) in stack.arrangedSubviews.enumerated() {
                UIView.animate(
                    withDuration: 0.4,
                    delay: 0.05 * Double(index),
                    usingSpringWithDamping: 0.5,
                    initialSpringVelocity: 0.5,
                    options: [],
                    animations: {
                        view.alpha = 1
                        view.transform = .identity
                    },
                    completion: nil
                )
            }
        }
    }
    
    @objc func emotionTapped(_ sender: UIButton) {
        guard let emoji = sender.titleLabel?.text else { return }
        print("Emotion selected in cell: \(emoji)")
        
        // Cập nhật icon trên nút react ngay lập tức
        reactButton.setTitle(emoji, for: .normal)
        
        // Gọi callback nếu cần ViewController biết
        onEmotionSelected?(emoji)
        if let popup = popupView {
            hidePopup(popup)
        }
    }
    
    private func hidePopup(_ popup: UIStackView) {
        UIView.animate(withDuration: 0.2, animations: {
            popup.alpha = 0
            popup.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }) { _ in
            popup.removeFromSuperview()
            self.popupView = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        if let popup = popupView {
            popup.removeFromSuperview()
            popupView = nil
        }
    }
}

