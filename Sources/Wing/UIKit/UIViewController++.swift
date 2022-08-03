//
//  UIViewController++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit

public extension UIViewController {
    func recreateGesture() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
    }
}
