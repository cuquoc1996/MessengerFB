//
//  FriendViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import UIKit
import Photos
import PhotosUI

class FriendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, EditPhotoDelegate
{
    
    var images: [UIImage] = []
    @IBOutlet weak var collectionViewStr: UICollectionView!
    @IBOutlet weak var tableViewStt: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewStt.register(UINib(nibName: "StatusFriendTableViewCell", bundle: nil), forCellReuseIdentifier: "StatusFriendTableViewCell")
        tableViewStt.delegate = self
        tableViewStt.dataSource = self
        collectionViewStr.register(UINib(nibName: "StoryFriendCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "StoryFriendCollectionViewCell")
        collectionViewStr.delegate = self
        collectionViewStr.dataSource = self
        setupNavigationBar()
        
    }
    
    func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Friend"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .label
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1 + images.count
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            let editVC = EditPhotoViewController()
            editVC.selectedImage = image
            editVC.delegate = self
            navigationController?.pushViewController(editVC, animated: true)
            print("Đã chọn ảnh")
        }
        picker.dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryFriendCollectionViewCell", for: indexPath) as! StoryFriendCollectionViewCell
            //            let ỉtem = dataUser[indexPath.row]
            cell.nameUser.text = "Thêm vào tin"
            cell.imageUser.image = UIImage(named: "icons8-add")
            cell.imageStory.image = UIImage(named: "friends")
            cell.layer.cornerRadius = 16
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryFriendCollectionViewCell", for: indexPath) as! StoryFriendCollectionViewCell
            let item = dataUser[indexPath.row - 1]
            let image = images[indexPath.row - 1] // ✅ Trừ đi 1 vì đã dùng 1 ô đầu tiên
            cell.imageUser.image = UIImage(named: item.imageName)
            cell.nameUser.text = item.title
            cell.imageStory.image = image
            cell.layer.cornerRadius = 16
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 90, height: 180)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StatusFriendTableViewCell", for: indexPath) as! StatusFriendTableViewCell
        let item = dataUser[indexPath.row]
        cell.nameUser.text = item.title
        cell.SttUser.text = item.status
        cell.imageUser.image = UIImage(named: item.imageName)
        cell.imageUser.layer.cornerRadius = 22
        // Xử lý callback khi chọn cảm xúc
        cell.onEmotionSelected = { emoji in
            print("User selected: \(emoji) for row: \(indexPath.row)")
            // Cập nhật dữ liệu nếu cần
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let picker = UIImagePickerController()
            picker.delegate = self
            picker.sourceType = .photoLibrary
            present(picker, animated: true, completion: nil)
        } else {
            print("Da chon \(indexPath.row)")
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    func didFinishEditing(image: UIImage) {
        images.insert(image, at: 0)              // ✅ Thêm ảnh vào đầu
        collectionViewStr.reloadData()              // ✅ Cập nhật collection
        if images.count > 0 {
            collectionViewStr.scrollToItem(at: IndexPath(item: 1, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
}


