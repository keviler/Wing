//
//  NSObject+Extensions.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation

public extension NSObject {

    @discardableResult
    static func swizzle(instanceMethod originalSel: Selector, with newSel: Selector) -> Bool {
        guard let originalMethod = class_getInstanceMethod(self, originalSel) else {
            return false
        }
        guard let newMethod = class_getInstanceMethod(self, newSel) else {
            return false
        }

        method_exchangeImplementations(originalMethod, newMethod)
        return true

    }

    @discardableResult
    static func swizzle(classMethod originalSel: Selector, with newSel: Selector) -> Bool {
        guard let originalMethod = class_getClassMethod(self, originalSel) else {
            return false
        }
        guard let newMethod = class_getClassMethod(self, newSel) else {
            return false
        }
        method_exchangeImplementations(originalMethod, newMethod)
        return true
    }

    func getAssociatedObject(key: UnsafePointer<UInt8>, initialiser: () -> Any) -> Any {
        guard let associated = objc_getAssociatedObject(self, key) else {
            let associated = initialiser()
            setAssociateObject(key: key, value: associated)
            return associated
        }
        return associated
    }

    func setAssociateObject(key: UnsafePointer<UInt8>, value: Any) {
        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN)
    }

    func removeAssociatedValues() {
        objc_removeAssociatedObjects(self)
    }

}
