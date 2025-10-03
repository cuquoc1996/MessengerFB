//
//  ActiveStatusViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 31/07/2025.
//

import UIKit
import SafariServices

class ActiveStatusViewController: UIViewController {
    @IBOutlet weak var note1: UILabel!
    @IBOutlet weak var note2: UILabel!
    @IBOutlet weak var viewBt: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var toggleSwitch: UISwitch!
    var tappableRange: NSRange!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Trạng thái hoạt động"
        titleLabel.text = "Hiển thị trạng thái hoạt động"
        note2.text = "Bạn vẫn có thể sử dụng dịch vụ của chúng tôi nếu tắt trạng thái hoạt động."
        titleLabel.font = UIFont.systemFont(ofSize: 15)
        viewBt.backgroundColor = .lightGray
        viewBt.layer.cornerRadius = 12
        textContentOn()
        
        // Load trạng thái cũ
        let isOn = UserDefaults.standard.bool(forKey: "ActiveStatusEnabled")
        toggleSwitch.isOn = isOn
    }
    
    func textContentOn() {
        let fullText = "Bạn bè và các quan hệ kết nối có thể biết khi nào bạn đang hoạt động hoặc hoạt động gần đây trên trang cá nhân này. Bạn cũng có thể xem thông tin này về họ. Nếu bạn muốn thay đổi cài đặt này thì hãy tắt đi mỗi khi dùng Messenger hoặc Facebook để trạng thái hoạt động của bạn không hiển thị nữa. Tìm hiểu thêm"
        let attributedText = NSMutableAttributedString(string: fullText,
                                                       attributes: [
                                                        .font: UIFont(name: "Times New Roman", size: 14)!,
                                                        .foregroundColor: UIColor.label
                                                       ])
        
        // Set style cho đoạn "Tìm hiểu thêm"
        let tappableText = "Tìm hiểu thêm"
        tappableRange = (fullText as NSString).range(of: tappableText)
        attributedText.addAttributes([
            .foregroundColor: UIColor.link,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: tappableRange)
        
        note1.attributedText = attributedText
        note1.isUserInteractionEnabled = true
        
        // Thêm gesture tap
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        note1.addGestureRecognizer(tapGesture)
    }
    
    func textContentOff() {
        let fullText = "Bạn sẽ không biết khi nào bạn bè và các quan hệ kết nối đang hoạt động hoặc hoạt động gần đây trên ứng dụng này. Nếu bạn muốn đảm bảo rằng họ không thể xem thông tin này về bạn, hãy tắt cài đặt này mỗi khi dùng Messenger hoặc Facebook để trạng thái hoạt động của bạn không hiển thị nữa. Tìm hiểu thêm"
        let attributedText = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont(name: "Times New Roman", size: 14)!,
                .foregroundColor: UIColor.label
            ]
        )
        
        let tappableText = "Tìm hiểu thêm"
        tappableRange = (fullText as NSString).range(of: tappableText)
        
        attributedText.addAttributes([
            .foregroundColor: UIColor.link,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ], range: tappableRange)
        
        note1.attributedText = attributedText
        note1.isUserInteractionEnabled = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapOnLabel(_:)))
        note1.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTapOnLabel(_ gesture: UITapGestureRecognizer) {
        guard let label = gesture.view as? UILabel,
              let attributedText = label.attributedText else { return }
        
        // Setup để tính vị trí ký tự
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: .zero) // ban đầu .zero
        let textStorage = NSTextStorage(attributedString: attributedText)
        
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        textContainer.lineFragmentPadding = 0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        textContainer.size = CGSize(width: label.bounds.width, height: .greatestFiniteMagnitude) // ✅ đúng width của label
        
        let location = gesture.location(in: label)
        let index = layoutManager.characterIndex(
            for: location,
            in: textContainer,
            fractionOfDistanceBetweenInsertionPoints: nil
        )
        
        // ✅ Nếu tap trong vùng hyperlink → push WebViewController
        if tappableRange.contains(index) {
            print("Tap vào ký tự cuối cùng")
            openLink("https://www.apple.com")
        } else {
            print("Tap vào ký tự khác")
        }
    }
    
    func openLink(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true)
    }
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "ActiveStatusEnabled")
        print("Đã nhấn: \(sender.isOn)")
        if sender.isOn {
            self.textContentOn()
            // Nếu bật lưu luôn
            UserDefaults.standard.set(true, forKey: "ActiveStatusEnabled")
        } else {
            let alert = UIAlertController(
                title: "Tắt trạng thái hoạt động?",
                message: "Bạn sẽ không biết khi bạn bè và các quan hệ kết nối của mình đang hoạt động, hoạt động gần đây hoặc tham gia cùng đoạn chat với bạn.",
                preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Huỷ", style: .default) {_ in
                // Giữ nguyên bật
                sender.setOn(true, animated: true)
                // 🔑 Fix: đồng bộ lại UserDefaults về true
                UserDefaults.standard.set(true, forKey: "ActiveStatusEnabled")
                self.textContentOn()
            })
            alert.addAction(UIAlertAction(title: "Tắt", style: .destructive) {_ in
                self.textContentOff()
                // Xác nhận tắt
                UserDefaults.standard.set(false, forKey: "ActiveStatusEnabled")
            })
            present(alert, animated: true)
        }
    }
}

