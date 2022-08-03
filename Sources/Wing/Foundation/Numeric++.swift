//
//  MathExtensions.swift
//  Wing
//
//  Created by admin on 11/5/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation
import CoreGraphics

/*
 covert all kinds of numeric, int floar double string
 */

public extension Numeric where Self: NumericConvert {
    var isNegetive: Bool { return self.double < 0.0 }
    var isPositive: Bool { return self.double > 0.0 }
}

public protocol NumericConvert {
    var int: Int { get }
    var float: Float { get }
    var double: Double { get }
    var cgFloat: CGFloat { get }
}

public extension NumericConvert where Self: BinaryInteger {
    var int: Int { get { return Int(self) } }
    var float: Float { get { return Float(self) } }
    var double: Double { get { return Double(self) } }
    var cgFloat: CGFloat { get { return CGFloat(self) } }
}

public extension NumericConvert where Self: BinaryFloatingPoint {
    var int: Int { get { return Int(self) } }
    var float: Float { get { return Float(self) } }
    var double: Double { get { return Double(self) } }
    var cgFloat: CGFloat { get { return CGFloat(self) } }
}

extension Double: NumericConvert {}
extension Float: NumericConvert {}
extension Int: NumericConvert {}
extension CGFloat: NumericConvert {}

public protocol BytesConvertable {
    var bytes: String { get }
}

public extension BytesConvertable where Self: BinaryFloatingPoint  {
    var bytes: String {
        get {
            let KB = Double(self) / 1024.0
            let MB = KB / 1024
            let GB = MB / 1024

            if GB >= 1 {
                return String(format: "%.2f GB", GB)
            } else if MB >= 1 {
                return String(format: "%.2f MB", MB)
            } else {
                return String(format: "%.2f KB", KB)
            }
        }
    }
}


extension NumericConvert {
    var hm: String {
        return DateFormatter.hmFormatter.string(from: Date(timeIntervalSinceReferenceDate: self.double))
    }
    var hms: String {
        return DateFormatter.hmsFormatter.string(from: Date(timeIntervalSinceReferenceDate: self.double))
    }

    var bytes: String {
        ByteCountFormatter.string(fromByteCount: Int64(self.double), countStyle: .file)
    }
    var durationString: String {
        let hours:Int = Int(self.double.truncatingRemainder(dividingBy: 86400) / 3600)
        let minutes:Int = Int(self.double.truncatingRemainder(dividingBy: 3600) / 60)
        let seconds:Int = Int(self.double.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", hours, minutes, seconds)
        } else {
            return String(format: "%02i:%02i", minutes, seconds)
        }
    }

}

struct FKCurrency {
    private var value: Double?
    init(_ value: Double?) {
        self.value = value
    }
}

extension FKCurrency {
    var full: String {
        get {
            let number = NSNumber(value: self.value ?? 0)
            //创建一个NumberFormatter对象
            let numberFormatter = NumberFormatter()
            numberFormatter.maximumFractionDigits = 2 //设置小数点后最多2位
            numberFormatter.minimumFractionDigits = 0 //设置小数点后最少0位（不足补0）
            //格式化
            return numberFormatter.string(from: number) ?? "0"
        }
    }
    var int: String {
        String(self.full.split(separator: ".").first ?? "0")
    }
    var decimal: String {
        if self.full.contains(".") {
            return String(self.full.split(separator: ".").last ?? "")
        }
        return ""
    }
}
