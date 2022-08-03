//
//  UIScrollView++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit

public extension UIScrollView {
    func scrollToTop(animated: Bool = true) {
        self.setContentOffset(CGPoint(x: self.contentOffset.x, y: 0), animated: animated)
    }
    func scrollToBottom(animated: Bool = true) {
        self.setContentOffset(CGPoint(x: self.contentOffset.x, y: self.contentSize.height - self.height), animated: animated)
    }
    func scrollToLeft(animated: Bool = true) {
        self.setContentOffset(CGPoint(x: 0, y: self.contentSize.height), animated: animated)
    }
    func scrollToRight(animated: Bool = true) {
        self.setContentOffset(CGPoint(x: self.contentSize.width - self.width, y: self.contentSize.height), animated: animated)
    }
    func scrollToOrigin(animated: Bool = true) {
        self.setContentOffset(.zero, animated: animated)
    }
}
