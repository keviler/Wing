//
//  UIWindow++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit

public extension UIWindow {
    class var key: UIWindow? {
        UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
    }
    class var topViewController: UIViewController? {
        key?.rootViewController?.topmostViewController
    }
    class var topNavigationController: UINavigationController? {
        topViewController?.navigationController
    }
}
