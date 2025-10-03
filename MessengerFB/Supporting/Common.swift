//
//  Common.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import Foundation
import UIKit
public class Common

{
    //hàm đưa ra thông báo
    public static func thongbao(object: UIViewController,tieuDe:String, noiDung: String)
    {
        let alert = UIAlertController(title: tieuDe, message: noiDung, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Đóng", style: .default, handler: nil)
        alert.addAction(btnOK)
        //hiển thị nội dung thông báo
        object.present(alert, animated: true, completion: nil)
    }
}

