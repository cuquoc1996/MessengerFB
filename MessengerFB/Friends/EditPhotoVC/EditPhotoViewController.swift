//
//  EditPhotoViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 20/06/2025.
//

import UIKit

class EditPhotoViewController: UIViewController {
    
    @IBOutlet weak var imageViewStr: UIImageView! 
    // Ảnh được truyền từ màn hình trước
    weak var delegate: EditPhotoDelegate? 
    // Gán từ màn trước
    var selectedImage: UIImage?
    @IBOutlet weak var btAddStr: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIHelper.styleButton(btAddStr,backgroundColor: AppColors.sunsetOrange,cornerRadius: 4)
        if let image = selectedImage {
            imageViewStr.image = image
        } else {
            print("⚠️ Không có ảnh được truyền sang")
        }
        view.backgroundColor = .white
        title = "Chỉnh sửa ảnh"
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        guard let image = imageViewStr.image else { return }
        delegate?.didFinishEditing(image: image) // Gửi ảnh về màn trước
        navigationController?.popViewController(animated: true)
    }
}

protocol EditPhotoDelegate: AnyObject {
    func didFinishEditing(image: UIImage)
}

