//
//  HalfModalViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 07/10/2025.
//

import UIKit

class HalfModalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        let label = UILabel()
        label.text = "Hello from Half Sheet!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.frame = view.bounds
        view.addSubview(label)
    }
}
