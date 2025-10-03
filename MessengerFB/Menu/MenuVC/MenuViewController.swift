//
//  MenuViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 14/05/2025.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableViewMenu: UITableView!
    @IBOutlet weak var logOutBt: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewMenu.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: "MenuTableViewCell")
        tableViewMenu.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserTableViewCell")
        navigationItem.backButtonTitle = ""
        navigationController?.navigationBar.tintColor = .black
        tableViewMenu.delegate = self
        tableViewMenu.dataSource = self
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        let titleLabel = UILabel()
        titleLabel.text = "Menu"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 26)
        titleLabel.textColor = .label
        
        let leftItem = UIBarButtonItem(customView: titleLabel)
        navigationItem.leftBarButtonItem = leftItem
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuGroupCell[section].dataMenu.count
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menuGroupCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserTableViewCell", for: indexPath) as! UserTableViewCell
            let item = menuGroupCell[indexPath.section].dataPofile[indexPath.row]
            cell.userName.text = item.title
            cell.userImage.image = UIImage(named: item.imageName)
            cell.userStt.text = item.status
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell", for: indexPath) as! MenuTableViewCell
        let item = menuGroupCell[indexPath.section].dataMenu[indexPath.row]
        cell.nameCellMenu.text = item.title
        cell.imageCellMenu.image = UIImage(named: item.imageName)
        //            cell.contentView.layer.borderWidth = 0.2
        //            cell.contentView.layer.borderColor = UIColor.lightGray.cgColor
        //            cell.contentView.layer.cornerRadius = 8
        //            cell.contentView.clipsToBounds = true
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let settingVC = SettingViewController()
            navigationController?.pushViewController(settingVC, animated: true)
        }
        
        if indexPath.section == 2 && indexPath.row == 0 {
            let marketVC = MarketplaceViewController()
            navigationController?.pushViewController(marketVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        } else {
            return 25
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == 0 {
            return nil
        } else {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 70
        } else {
            return 45
        }
    }
}
