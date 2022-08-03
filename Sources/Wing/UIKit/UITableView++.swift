//
//  UITableView++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import UIKit


private var UITableViewHeightsKey: UInt8 = 0
public extension UITableView {

    typealias Key = String

    private var heights: [Key: CGFloat] {
        get {
            return self.getAssociatedObject(key: &UITableViewHeightsKey) { return [ : ] } as! [Key: CGFloat]
        }
        set {
            self.setAssociateObject(key: &UITableViewHeightsKey, value: newValue)
        }
    }

    func cachedHeight(withKey key: Key, _ heightGenerator: () -> CGFloat) -> CGFloat {
        guard let height = self.heights[key] else {
            let height = heightGenerator()
            self.heights[key] = height
            return height
        }
        return height
    }

    func removeCachedHeight(forKey key: Key) {
        self.heights.removeValue(forKey: key)
    }

    func removeAllCachedHeights() {
        self.heights.removeAll()
    }

    func update(_ updateBlock: (UITableView) -> Void) {
        self.beginUpdates()
        updateBlock(self)
        self.endUpdates()
    }

    func scrollToIndexPath(_ indexPath: IndexPath , at position: UITableView.ScrollPosition = .top, animated: Bool = true) {
        self.scrollToRow(at: indexPath, at: position, animated: animated)
    }

}
