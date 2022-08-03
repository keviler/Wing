//
//  TextField.swift
//  Wing
//
//  Created by admin on 11/13/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit

public extension Wing {
    class TextField: UITextField {
        public enum PasswordStyle {
            case border(width: CGFloat, color: UIColor)
            case bottomLine(width: CGFloat, color: UIColor)
        }
        public enum Style {
            case normal
            case password(style: PasswordStyle, length: Int)
        }
        public var borderInsets: UIEdgeInsets?
        public var textInsets: UIEdgeInsets?
        public var placeholderInsets: UIEdgeInsets?
        public var editingInsets: UIEdgeInsets?
        public var clearButtonInsets: UIEdgeInsets?
        public var leftViewInsets: UIEdgeInsets?
        public var rightViewInsets: UIEdgeInsets?
        public var style: Style = .normal

        override public var leftView: UIView? {
            willSet {
                guard (newValue != nil) else { return }
                self.leftViewMode = .always
            }
        }
        override public var rightView: UIView? {
            willSet {
                guard (newValue != nil) else { return }
                self.leftViewMode = .always
            }
        }

        override public func borderRect(forBounds bounds: CGRect) -> CGRect {
            guard let insets = self.borderInsets else { return bounds }
            return bounds.inset(by: insets)
        }

        override public func textRect(forBounds bounds: CGRect) -> CGRect {
            guard let insets = self.textInsets else { return bounds }
            return bounds.inset(by: insets)
        }

        override public func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            guard let insets = self.placeholderInsets else { return bounds }
            return bounds.inset(by: insets)
        }

        override public func editingRect(forBounds bounds: CGRect) -> CGRect {
            guard let insets = self.editingInsets else { return bounds }
            return bounds.inset(by: insets)
        }

        override public func clearButtonRect(forBounds bounds: CGRect) -> CGRect {
            guard let insets = self.clearButtonInsets else { return bounds }
            return bounds.inset(by: insets)
        }

        override public func leftViewRect(forBounds bounds: CGRect) -> CGRect {
            guard let insets = self.leftViewInsets else { return bounds }
            return bounds.inset(by: insets)
        }

        override public func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            guard let insets = self.rightViewInsets else { return bounds }
            return bounds.inset(by: insets)
        }

        override public func draw(_ rect: CGRect) {
            switch self.style {
            case .normal:
                super.draw(rect)
            case .password(style: .border(width: let lineWidth, color: let color), length: let length):
                let context = UIGraphicsGetCurrentContext()
                context?.setLineWidth(lineWidth)
                context?.setStrokeColor(color.cgColor)
                let width = rect.height
                let height = rect.height
                let gap = (rect.width - width * length.cgFloat) / (length - 1).cgFloat
                var rects: [CGRect] = []
                for i in 0..<length {
                    rects.append(CGRect(x: i.cgFloat * (width + gap),
                                        y: 0,
                        width: width, height: height).insetBy(dx: lineWidth / 2, dy: lineWidth / 2))
                }
                context?.addRects(rects)
                context?.strokePath()
            case .password(style: .bottomLine(width: let lineWidth, color: let color), length: let length):
                let context = UIGraphicsGetCurrentContext()
                context?.setLineWidth(lineWidth)
                context?.setStrokeColor(color.cgColor)
                let width = rect.height
                let height = rect.height
                let gap = (rect.width - width * length.cgFloat) / (length - 1).cgFloat
                for i in 0..<length {
                    context?.move(to: CGPoint(x: i.cgFloat * (width + gap), y: height - lineWidth / 2))
                    context?.addLine(to: CGPoint(x: i.cgFloat * (width + gap) + width, y: height - lineWidth / 2))
                }
                context?.strokePath()

            default: break
            }
        }


    }



}

