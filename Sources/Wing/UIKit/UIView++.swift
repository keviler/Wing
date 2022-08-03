//
//  UIView++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit


//MARK: View Coordinator
public extension UIView {

    var size: CGSize {
        set { self.bounds = CGRect(x: 0, y: 0, width: newValue.width, height: newValue.height) }
        get { return self.bounds.size }
    }

    var width: CGFloat {
        set { self.bounds = CGRect(x: 0, y: 0, width: newValue, height: self.height) }
        get { return self.bounds.width }
    }

    var height: CGFloat {
        set { self.bounds = CGRect(x: 0, y: 0, width: self.width, height: newValue) }
        get { return self.bounds.height }
    }

    var x: CGFloat {
        set { self.bounds = CGRect(x: newValue, y: self.y, width: self.width, height: newValue) }
        get { return self.bounds.minX }
    }

    var y: CGFloat {
        set { self.bounds = CGRect(x: self.x, y: newValue, width: self.width, height: self.height) }
        get { return self.bounds.minY }
    }
}

// view snapshot
public extension UIView {
    var snapShot: UIImage? {
        get {
            UIGraphicsBeginImageContext(self.size)
            guard let context = UIGraphicsGetCurrentContext() else { return nil }
            self.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image
        }
    }
}

//MARK: view layer xib Inspecter
@IBDesignable public extension UIView {
    @IBInspectable var borderColor:UIColor? {
        set { layer.borderColor = newValue!.cgColor }
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            else {
                return nil
            }
        }
    }
    @IBInspectable var borderWidth:CGFloat {
        set { layer.borderWidth = newValue }
        get { return layer.borderWidth }
    }
    @IBInspectable var cornerRadius:CGFloat {
        set { layer.cornerRadius = newValue; clipsToBounds = newValue > 0 }
        get { return layer.cornerRadius }
    }
}

public extension UIView {
    // remove all subviews
    func removeSubviews() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
}

// View Hint Text
private var UIViewHitAreaInsetsKey: UInt8 = 0
public extension UIView {
    class func initializeHitCaptor() {
        UIView.swizzle(instanceMethod: #selector(hitTest(_:with:)), with: #selector(swizzling_hitTest(_:with:)))
    }
    class func deinitializeHitCaptor() {
        UIView.swizzle(instanceMethod: #selector(hitTest(_:with:)), with: #selector(swizzling_hitTest(_:with:)))
    }

    var hitAreaInsets: UIEdgeInsets {
        get {
            return self.getAssociatedObject(key: &UIViewHitAreaInsetsKey) { return UIEdgeInsets.zero } as! UIEdgeInsets
        }
        set {
            self.setAssociateObject(key: &UIViewHitAreaInsetsKey, value: newValue)
        }
    }

    @objc func swizzling_hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        guard !self.isHidden,
//            self.isUserInteractionEnabled,
//            self.alpha >= 0.01,
//            self.bounds.inset(by: self.hitAreaInsets).contains(point) else {
//                return nil
//        }
        return self
    }
}
