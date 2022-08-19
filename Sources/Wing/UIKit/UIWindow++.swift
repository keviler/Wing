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
        guard let rootViewController = key?.rootViewController else { return nil }
        if let controller = (rootViewController as? UINavigationController)?.visibleViewController {
            return controller
        } else if let controller = (rootViewController as? UITabBarController)?.selectedViewController {
            return controller
        } else if let controller = rootViewController.presentedViewController {
            return controller
        } else {
            return rootViewController
        }
    }
    class var topNavigationController: UINavigationController? {
        topViewController?.navigationController
    }
}
