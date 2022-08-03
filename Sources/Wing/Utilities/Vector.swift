//
//  Math.swift
//  Wing
//
//  Created by admin on 11/15/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation

public protocol Decreasing {
    static postfix func -- (value: inout Self) -> Self
}

public protocol Increasing {
    static postfix func ++ (value: inout Self) -> Self
}

public extension Decreasing where Self: BinaryInteger {
    @discardableResult
    static postfix func -- (value: inout Self) -> Self {
        value = value - 1
        return value
    }
}

public extension Increasing where Self: BinaryInteger {
    @discardableResult
    static postfix func ++ (value: inout Self) -> Self {
        value = value + 1
        return value
    }
}

typealias DeIncreasing = Decreasing & Increasing

extension Int: DeIncreasing{}
extension UInt: DeIncreasing{}

public protocol Vector {
    static prefix func - (vec: Self) -> Self
    static func + (lhs: Self, rhs: Self) -> Self
    static func += (lhs: inout Self, rhs: Self) -> Self
    static func - (lhs: Self, rhs: Self) -> Self
    static func -= (lhs: inout Self, rhs: Self) -> Self
    static func ... (lhs: Self, rhs: Self) -> Double
    func inRadius(_ radius: Double, of center: Self) -> Bool
}

public extension Vector {
    func inRadius(_ radius: Double, of center: Self) -> Bool {
        return self...center < radius
    }
}

public struct Vector2D {
    var x: Double = 0, y: Double = 0
    public init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}


extension Vector2D: Vector {
    public static prefix func - (vec: Vector2D) -> Vector2D {
        return Vector2D(x: -vec.x, y: -vec.y)
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    public static func += (lhs: inout Self, rhs: Self) -> Self {
        lhs = Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
        return lhs
    }
    public static func - (lhs: Self, rhs: Self) -> Self {
        return Vector2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    public static func -= (lhs: inout Self, rhs: Self) -> Self {
        lhs = Vector2D(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
        return lhs
    }
    public static func ... (lhs: Self, rhs: Self) -> Double {
        let distanceX = lhs.x - rhs.x
        let distanceY = lhs.y - rhs.y
        return sqrt(distanceX * distanceX + distanceY * distanceY)
    }
}

public struct Vector3D {
    var x: Double = 0, y: Double = 0, z: Double = 0
    public init(x: Double, y: Double, z: Double) {
        self.x = x
        self.y = y
        self.z = z
    }
}

extension Vector3D: Vector {
    public static prefix func - (vec: Self) -> Self {
        return Vector3D(x: -vec.x, y: -vec.y, z: -vec.z)
    }

    public static func + (lhs: Self, rhs: Self) -> Self {
        return Vector3D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }
    public static func += (lhs: inout Self, rhs: Self) -> Self {
        lhs = Vector3D(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
        return lhs
    }
    public static func - (lhs: Self, rhs: Self) -> Self {
        return Vector3D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }
    public static func -= (lhs: inout Self, rhs: Self) -> Self {
        lhs = Vector3D(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
        return lhs
    }
    public static func ... (lhs: Self, rhs: Self) -> Double {
        let distanceX = lhs.x - rhs.x
        let distanceY = lhs.y - rhs.y
        let distanceZ = lhs.z - rhs.z
        return sqrt(distanceX * distanceX + distanceY * distanceY + distanceZ * distanceZ)
    }
}

