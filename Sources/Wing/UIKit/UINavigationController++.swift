//
//  UINavigationController++.swift
//  
//
//  Created by 周朋毅 on 2022/8/3.
//

import UIKit

//MARK: fix interactive pop gesture useless issue
public extension UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

public extension UINavigationController {
    
    @objc func popViewControllerWithAnimation() {
        popViewController(animated: true)
    }
}
