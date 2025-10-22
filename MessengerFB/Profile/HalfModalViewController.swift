//
//  HalfModalViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 07/10/2025.
//
import UIKit

class HalfModalViewController: UIViewController {
    
    private let tableView = UITableView(frame: .zero, style: .plain)
    
    // Danh sách mục chính
    private let items: [(icon: String, title: String)] = [
        ("house", "Khóa bảo vệ trang cá nhân"),
        ("rocket", "Thông tin trên trang cá nhân"),
        ("globe", "Cách tìm và liên hệ với bạn"),
        ("square.grid.2x2", "Bài viết"),
        ("chart.bar.xaxis", "Tin"),
        ("person.2", "Trang"),
        ("pi", "Reels"),
        ("bubble.left.and.bubble.right", "Avatar"),
        ("desktopcomputer", "Người theo dõi và nội dung công khai"),
        ("questionmark.circle", "Trang cá nhân và gắn thẻ"),
        ("doc.text", "Chặn"),
        ("message", "Trạng thái hoạt động"),
        ("person.crop.circle.badge.checkmark", "Thanh toán quảng cáo"),
        ("person", "Hồ sơ")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        // Thêm header + footer
        tableView.tableHeaderView = makeHeaderView()
        tableView.tableFooterView = makeFooterView()
    }
    
    private func makeHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 60))
        
        let titleLabel = UILabel()
        titleLabel.text = "Tài khoản của bạn"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        titleLabel.textAlignment = .left
        titleLabel.textColor = .label
        
        header.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: header.leadingAnchor, constant: 20),
            titleLabel.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -10)
        ])
        
        return header
    }
    
    private func makeFooterView() -> UIView {
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 120))
        
        let socialStack = UIStackView()
        socialStack.axis = .horizontal
        socialStack.alignment = .center
        socialStack.distribution = .equalSpacing
        socialStack.spacing = 16
        
        let socials = ["facebook", "instagram", "youtube", "xmark", "telegram"]
        for icon in socials {
            let imgView = UIImageView(image: UIImage(named: icon))
            imgView.tintColor = .systemBlue
            imgView.contentMode = .scaleAspectFit
            imgView.widthAnchor.constraint(equalToConstant: 24).isActive = true
            imgView.heightAnchor.constraint(equalToConstant: 24).isActive = true
            socialStack.addArrangedSubview(imgView)
        }
        
        let tosLabel = UILabel()
        tosLabel.text = "Messenger"
        tosLabel.textColor = .systemBlue
        tosLabel.font = .systemFont(ofSize: 14)
        tosLabel.isUserInteractionEnabled = true
        
        let privacyLabel = UILabel()
        privacyLabel.text = "Privacy Policy"
        privacyLabel.textColor = .systemBlue
        privacyLabel.font = .systemFont(ofSize: 14)
        privacyLabel.isUserInteractionEnabled = true
        
        let linkStack = UIStackView(arrangedSubviews: [tosLabel, privacyLabel])
        linkStack.axis = .horizontal
        linkStack.spacing = 30
        linkStack.distribution = .equalSpacing
        
        let mainStack = UIStackView(arrangedSubviews: [socialStack, linkStack])
        mainStack.axis = .vertical
        mainStack.spacing = 14
        mainStack.alignment = .center
        footer.addSubview(mainStack)
        
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStack.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            mainStack.centerYAnchor.constraint(equalTo: footer.centerYAnchor)
        ])
        
        return footer
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension HalfModalViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        cell.imageView?.image = UIImage(systemName: item.icon)
        cell.textLabel?.font = .systemFont(ofSize: 13)
        cell.textLabel?.textColor = .label
        cell.backgroundColor = .clear
        cell.selectionStyle = .gray
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selected = items[indexPath.row]
        
        var destinationVC: UIViewController?
        
        switch indexPath.row {
        case 0:
            destinationVC = MenuViewController()
            //               case 1:
            //                   destinationVC = PersonalInfoViewController()
            //               case 2:
            //                   destinationVC = ContactPrivacyViewController()
            //               case 3:
            //                   destinationVC = PostsSettingsViewController()
            //               case 4:
            //                   destinationVC = StoriesSettingsViewController()
            //               case 5:
            //                   destinationVC = PagesViewController()
            //               case 6:
            //                   destinationVC = ReelsSettingsViewController()
            //               case 7:
            //                   destinationVC = AvatarSettingsViewController()
            //               case 8:
            //                   destinationVC = FollowersSettingsViewController()
            //               case 9:
            //                   destinationVC = TaggingSettingsViewController()
            //               case 10:
            //                   destinationVC = BlockListViewController()
                           case 11:
                               destinationVC = ActiveStatusViewController()
            //               case 12:
            //                   destinationVC = AdsPaymentViewController()
            //               case 13:
            //                   destinationVC = ProfileViewController()
        default:
            break
        }
        
        if let vc = destinationVC {
            vc.title = selected.title
            navigationController?.pushViewController(vc, animated: true)
            debugPrint("navigationController:", navigationController as Any) // 👈 in ra xem có nil không
        }
    }
}

