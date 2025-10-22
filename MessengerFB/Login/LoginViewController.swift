//
//  LoginViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import UIKit
//import FirebaseAuth
//import GoogleSignIn

class LoginViewController: UIViewController {
    @IBOutlet weak var registerEmailBt: UIButton!
    @IBOutlet weak var registerFbBt: UIButton!
    @IBOutlet weak var registerAppleBt: UIButton!
    @IBOutlet weak var registerGgBt: UIButton!
    @IBOutlet weak var toggleBt: UIButton!
    @IBOutlet weak var mesLabel: UILabel!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        UIHelper.styleButton(loginButton, titleColor: AppColors.lightGray, backgroundColor: AppColors.emeraldGreen, cornerRadius: 8)
        UIHelper.styleLabel(mesLabel, textColor: AppColors.lightGray,masksToBound: true)
        UIHelper.styleButton(cancelButton,titleColor: AppColors.lightGray, backgroundColor: AppColors.danger,cornerRadius: 8)
        UIHelper.styleView(view,backgroundColor: AppColors.primaryColor)
        
        //        UIHelper.styleButton(registerEmailBt,backgroundColor: AppColors.lightGray, cornerRadius: 25)
        //        UIHelper.styleButton(registerFbBt,backgroundColor: AppColors.lightGray, cornerRadius: 25)
        //        UIHelper.styleButton(registerAppleBt,backgroundColor: AppColors.lightGray, cornerRadius: 25)
        //        UIHelper.styleButton(registerGgBt,backgroundColor: AppColors.lightGray, cornerRadius: 25)
        
        //setting button hide/show password
        //        toggleBt.setImage(UIImage(named: "eyeToggle"), for: .selected)
        //        toggleBt.setImage(UIImage(named: "eyeToggleHide"), for: .normal)
        //        toggleBt.imageView?.contentMode = .scaleAspectFill
        //        passwordTextField.isSecureTextEntry = true
        //        passwordTextField.addTarget(self, action: #selector(passwordTypingEffect(_:)), for: .editingChanged)
    }
    
    //    @objc func passwordTypingEffect(_ textField: UITextField) {
    //        guard let currentFont = passwordTextField.font else { return }
    //
    //        // Tăng cỡ font
    //        UIView.animate(withDuration: 0.15, animations: {
    //            self.passwordTextField.font = currentFont.withSize(22) // Phóng to
    //        }) { _ in
    //            // Quay lại font ban đầu
    //            UIView.animate(withDuration: 0.15) {
    //                self.passwordTextField.font = currentFont.withSize(16) // Quay về bình thường
    //            }
    //        }
    //    }
    
    @IBAction func tapLoginBt(_ sender: Any) {
        //khai báo biến
        var tenDangNhap: String = "" , matKhau: String = ""
        //lấy thông tin từ giao diện
        tenDangNhap = userTextField.text!
        matKhau = passwordTextField.text!
        if tenDangNhap.count == 0 {
            //đưa ra thông báo
            Common.thongbao(object: self, tieuDe: "Thông báo", noiDung: "Bạn cần phải nhập tên đăng nhập")
            return
        }
        if matKhau.count == 0 {
            //đưa ra thông báo
            Common.thongbao(object: self, tieuDe: "Thông báo", noiDung: "Bạn cần phải nhập thông tin mật khẩu")
            passwordTextField.becomeFirstResponder()
            return
        }
        if tenDangNhap == "hetminhfc" && matKhau == "hvq130596" {
            let tabBarController = MainTabBarController()
            // Cách 1: Thay rootViewController (xoá login khỏi stack)
            if let sceneDelegate = UIApplication.shared.connectedScenes
                .first?.delegate as? SceneDelegate,
               let window = sceneDelegate.window {
                window.rootViewController = tabBarController
                window.makeKeyAndVisible()
            }
            Common.thongbao(object: self, tieuDe: "Thông báo", noiDung: "Đăng nhập thành công")
        } else {
            Common.thongbao(object: self, tieuDe: "Thông báo", noiDung: "Đăng nhập thất bại.Bạn vui lòng kiểm tra lại thông tin")
        }
    }
    
    @IBAction func tapCancelBt(_ sender: Any) {
        userTextField.text = ""
        passwordTextField.text = ""
        userTextField.becomeFirstResponder()
    }
    
    //
    //    @IBAction func tapToggleBtPassword(_ sender: UIButton) {
    //        //        chuyen doi nhung image ko chuyen doi duoc
    //        //        passwordTextField.isSecureTextEntry.toggle()
    //        toggleBt.isSelected = !toggleBt.isSelected
    //        passwordTextField.isSecureTextEntry = !toggleBt.isSelected
    //
    //        // Cách "hack" để cập nhật ngay text (tránh bị delay của isSecureTextEntry)
    //        let currentText = passwordTextField.text
    //        passwordTextField.text = ""
    //        passwordTextField.text = currentText
    //    }
    
    @IBAction func tapRegisterGmail(_ sender: Any) {
        //        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        //
        //        let config = GIDConfiguration(clientID: clientID)
        //        GIDSignIn.sharedInstance.configuration = config
        //
        //        guard let presentingVC = UIApplication.shared.windows.first?.rootViewController else { return }
        //
        //        GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
        //            guard error == nil else {
        //                print("Lỗi Google Sign-In: \(error!.localizedDescription)")
        //                return
        //            }
        //
        //            guard let user = result?.user,
        //                  let idToken = user.idToken?.tokenString else { return }
        //
        //            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
        //                                                           accessToken: user.accessToken.tokenString)
        //
        //            Auth.auth().signIn(with: credential) { authResult, error in
        //                if let error = error {
        //                    print("Lỗi đăng nhập Firebase: \(error.localizedDescription)")
        //                } else {
        //                    print("Đăng nhập Firebase bằng Google thành công!")
        //                }
        //            }
        //        }
    }
}

