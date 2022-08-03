//
//  UILabel++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit

@IBDesignable public extension UILabel {
    @IBInspectable var kern: CGFloat {
        get { return self.attributedText?.attribute(NSAttributedString.Key.kern, at: 0, effectiveRange: nil) as? CGFloat ?? 0.0 }
        set {
            guard let text = self.attributedText?.string else {
                return
            }
            var attributes = self.attributedText?.attributes(at: 0, effectiveRange: nil) ?? [:]
            attributes[NSAttributedString.Key.kern] = newValue
            self.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    }
    @IBInspectable var underLine: Int {
        get { return self.attributedText?.attribute(NSAttributedString.Key.underlineStyle, at: 0, effectiveRange: nil) as? Int ?? 0 }
        set {
            guard let text = self.attributedText?.string, newValue > 0 else {
                return
            }
            var attributes = self.attributedText?.attributes(at: 0, effectiveRange: nil) ?? [:]
            attributes[NSAttributedString.Key.underlineStyle] = NSNumber(integerLiteral: newValue)
            self.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    }
    @IBInspectable var underlineColor: UIColor? {
        get { return self.attributedText?.attribute(NSAttributedString.Key.underlineColor, at: 0, effectiveRange: nil) as? UIColor }
        set {
            guard let text = self.attributedText?.string, newValue != nil else {
                return
            }
            var attributes = self.attributedText?.attributes(at: 0, effectiveRange: nil) ?? [:]
            attributes[NSAttributedString.Key.underlineColor] = newValue
            self.attributedText = NSAttributedString(string: text, attributes: attributes)
        }
    }

}
