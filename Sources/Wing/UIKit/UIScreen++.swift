//
//  UIScreen++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit

public extension UIScreen {
    var statusBarHeight: CGFloat {
        get {
            guard let statusBarManager = UIWindow.key?.windowScene?.statusBarManager else { return 0 }
            return statusBarManager.statusBarFrame.size.height
        }
    }
}
