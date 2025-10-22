//
//  HalfModalViewController.swift
//  MessengerFB
//
//  Created by MacBook Pro on 07/10/2025.
//

import UIKit

class HalfWidthPresentationController: UIPresentationController {
    private let widthRatio: CGFloat = 2/3
    
    // 🔹 Nền màu bình thường (không blur)
    private lazy var dimmingView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.25) // 👈 đen trong suốt nhẹ
        v.alpha = 0
        v.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // Tap ngoài để đóng panel
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissController))
        v.addGestureRecognizer(tap)
        return v
    }()
    
    // Xác định khung panel (½ chiều rộng, trượt từ phải)
    override var frameOfPresentedViewInContainerView: CGRect {
        guard let container = containerView else { return .zero }
        let width = container.bounds.width * widthRatio
        let height = container.bounds.height
        return CGRect(x: container.bounds.width - width,
                      y: 0,
                      width: width,
                      height: height)
    }
    
    // Hiển thị nền khi panel mở
    override func presentationTransitionWillBegin() {
        guard let container = containerView else { return }
        dimmingView.frame = container.bounds
        container.addSubview(dimmingView)
        
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1
        })
    }
    
    // Ẩn nền khi panel đóng
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: { _ in
            self.dimmingView.removeFromSuperview()
        })
    }
    
    @objc private func dismissController() {
        presentedViewController.dismiss(animated: true)
    }
}
