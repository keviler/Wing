//
//  UIColor+Extensions.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation
import UIKit

//MARK: color
public protocol colorable {
    var color: UIColor { get }
}

extension Int: colorable {
    var hex: String {
        get { return String(format: "%02X", self) }
    }

    public var color: UIColor {
        get { return self.hex.color }
    }
}

public extension UIColor {

    var image: UIImage? { get { return self.image() } }

    func image(with size: CGSize = UIScreen.main.bounds.size) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        context.setFillColor(self.cgColor)
        context.fill(UIScreen.main.bounds)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}
