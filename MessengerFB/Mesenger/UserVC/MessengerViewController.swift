//
//  MessengerViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import UIKit

class MessengerViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    @IBOutlet weak var searchBarUser: UISearchBar!
    var filteredData: [MyModel] = []
    @IBOutlet weak var collectionViewUser: UICollectionView!
    @IBOutlet weak var tableViewMessage: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        filteredData = dataUser
        tableViewMessage.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        tableViewMessage.delegate = self
        tableViewMessage.dataSource = self
        
        collectionViewUser.register(UINib(nibName: "UserStoryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UserStoryCollectionViewCell")
        collectionViewUser.delegate = self
        collectionViewUser.dataSource = self
        searchBarUser.delegate = self
        setupButtonNavigationBar()
    }
    
    func setupButtonNavigationBar() {
        //label dùng làm custom view cho leftBarButtonItem
        let titleLabel = UILabel()
        titleLabel.text = "messenger"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .label
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftItem
        // 2 nút dùng làm custion view rightBarButton
        let noteButton = UIButton(type: .system)
        noteButton.setImage(UIImage(named: "icons8-note"), for: .normal)
        noteButton.addTarget(self, action: #selector(tapUserImageBt), for: .touchUpInside)
        
        let logoFbButton = UIButton(type: .system)
        logoFbButton.setImage(UIImage(named: "icons8-facebook"), for: .normal)
        logoFbButton.addTarget(self, action: #selector(tapBackProfileBt), for: .touchUpInside)
        
        // Custom spacing bằng cách gói 2 button vào 1 stack view
        let stack = UIStackView(arrangedSubviews: [noteButton, logoFbButton])
        stack.axis = .horizontal
        stack.spacing = 8 // 👈 spacing giữa 2 nút
        
        let customBarItem = UIBarButtonItem(customView: stack)
        navigationItem.rightBarButtonItem = customBarItem
        navigationController?.navigationBar.tintColor = .darkText
    }
    
    @objc func tapUserImageBt() {
        print("Nhấn vào avatar")
    }
    
    @objc func tapBackProfileBt() {
        print("logo FB tapped")
    }
    //setupTableView
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
        let item = filteredData[indexPath.row]
        cell.userName.text = item.title
        cell.userStt.text = item.status
        cell.userImage.image = UIImage(named: item.imageName)
        if cell.userStt.text == "Đang hoạt động" {
            cell.iconUserStt.backgroundColor = .green
        } else {
            cell.iconUserStt.backgroundColor = .clear
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedUser = dataUser[indexPath.row]
        let chatVC = ChatViewController()
        chatVC.hidesBottomBarWhenPushed = true
        chatVC.user = selectedUser
        print("Đã chọn user \(selectedUser.title)")
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //    setupCollectionView
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataUser.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UserStoryCollectionViewCell", for: indexPath) as! UserStoryCollectionViewCell
        let item = filteredData[indexPath.row]
        cell.nameStory.text = item.title
        cell.imageUser.image = UIImage(named: item.imageName)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 50, height: 62)
        // 👈 set chiều rộng & chiều cao tại đây
        // Gắn UI:UICollectionViewDelegateFlowLayout này vào class
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedUser = dataUser[indexPath.row]
        let chatVC = ChatViewController()
        chatVC.user = selectedUser
        chatVC.hidesBottomBarWhenPushed = true
        print("Đã chọn user \(selectedUser.title)")
        navigationController?.pushViewController(chatVC, animated: true)
    }
    
    func removeDiacritics(_ string: String) -> String {
        return string.folding(options: .diacriticInsensitive, locale: .current).lowercased()
        //        lọc ko phân biệt dấu
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredData = dataUser
        } else {
            let searchTextNormalized = removeDiacritics(searchText)
            filteredData = dataUser.filter {
                removeDiacritics($0.title).contains(searchTextNormalized) ||
                removeDiacritics($0.status).contains(searchTextNormalized)
            }
        }
        tableViewMessage.reloadData()
        //        collectionViewUser.reloadData() (dùng lọc cho collectionview)
    }
    
    func createImageWithTextAndIcon(imageName: String, text: String) -> UIImage? {
        guard let icon = UIImage(named: imageName) else { return nil }
        
        // Label cấu hình
        let label = UILabel()
        label.text = text
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        
        let spacing: CGFloat = 4
        let width = max(icon.size.width, label.frame.width)
        let height = icon.size.height + spacing + label.frame.height
        let size = CGSize(width: width, height: height)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        // Vẽ icon
        let iconX = (width - icon.size.width) / 2
        icon.draw(in: CGRect(x: iconX, y: 0, width: icon.size.width, height: icon.size.height))
        
        // Vẽ chữ
        let textX = (width - label.frame.width) / 2
        label.drawText(in: CGRect(x: textX, y: icon.size.height + spacing, width: label.frame.width, height: label.frame.height))
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return finalImage
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        //        Action xem thêm
        let watchAddAction = UIContextualAction(style: .normal, title: nil) { [weak self]
            action, view , completionHandler in
            guard let self = self else { return }
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
            
            //            Action chưa đọc
            let missMessageAction = UIAlertAction(title: "Đánh dấu là chưa đọc", style:.default, handler: { _ in
                completionHandler(true)
            })
            missMessageAction.setValue(UIImage(named: "icons8-message-24"), forKey: "image")
            alert.addAction(missMessageAction)
            //            Action tắt thông báo
            let turnOffMessage = UIAlertAction(title: "Tắt thông báo", style:.default, handler: { _ in
                completionHandler(false)})
            turnOffMessage.setValue(UIImage(named: "icons8-notification"), forKey: "image")
            alert.addAction(turnOffMessage)
            
            //            Action hạn chế
            let noLimitAction = UIAlertAction(title: "Hạn chế", style:.default, handler: { _ in
                completionHandler(false)})
            noLimitAction.setValue(UIImage(named: "icons8-chat-message"), forKey: "image")
            alert.addAction(noLimitAction)
            
            //            Action xoá
            let deleteAction = UIAlertAction(title: "Xoá", style:.destructive, handler: { _ in
                completionHandler(false)})
            deleteAction.setValue(UIImage(named: "icons8-delete"), forKey: "image")
            alert.addAction(deleteAction)
            
            //      Action chặn
            let blockAction = UIAlertAction(title: "Chặn", style:.destructive, handler: { _ in
                completionHandler(false)})
            blockAction.setValue(UIImage(named: "icons8-block"), forKey: "image")
            alert.addAction(blockAction)
            
            self.present(alert, animated: true, completion: nil)
            print("Đã nhấn xem thêm \(indexPath.row)")
            //            completionHandler(true)
        }
        
        watchAddAction.image = createImageWithTextAndIcon(imageName: "icons8-messenger-50", text: "Khác")
        watchAddAction.backgroundColor = .lightGray
        //        Action Ghim
        let pinAction = UIContextualAction(style: .normal, title: nil) {
            action, view , completionHandler in
            print("Đã nhấn ghim \(indexPath.row)")
            //            completionHandler(true)
        }
        pinAction.image = createImageWithTextAndIcon(imageName: "icons8-pin-50", text: "Ghim")
        pinAction.backgroundColor = .orange
        //        Action Lưu trữ
        let saveAction = UIContextualAction(style: .normal, title: nil) {
            action, view , completionHandler in
            print("Đã nhấn lưu trữ \(indexPath.row)")
            //            completionHandler(true)
        }
        saveAction.image = createImageWithTextAndIcon(imageName: "icons8-save", text: "Lưu trữ")
        saveAction.backgroundColor = .purple
        //        trả về cấu hình
        let configuration = UISwipeActionsConfiguration(actions: [saveAction, pinAction, watchAddAction])
        configuration.performsFirstActionWithFullSwipe = false //vuốt hết ko tự chạy
        return configuration
    }
}
