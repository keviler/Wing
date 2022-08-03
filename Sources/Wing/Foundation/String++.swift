//
//  String+Extensions.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation
import UIKit


//MARK: LocalizedString
public extension String {
    func localized(bundle: Bundle = Bundle.main, tableName: String? = nil, value: String = "", comment: String = "") -> String {
        return NSLocalizedString(self, tableName: tableName, bundle: bundle, value: value, comment: comment)
    }

    var localized: String {
        get {
            return self.localized()
        }
    }
}

//MARK: Date
public extension String {
    func date(with dateFormatter: DateFormatter) -> Date? {
        return dateFormatter.date(from: self)
    }

    func date(with dateFormat: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormat
        return self.date(with: dateFormatter)
    }

}

//MARK: file manager
public extension String {
    var fileExists: Bool {
        get { return FileManager.default.fileExists(atPath: self) }
    }

    var fileSize: Int64 {
        get { return FileManager.default.fileSize(of: self) }
    }

    func createDirectory() throws {
        do {
            try FileManager.default.createDirectory(atPath: self, withIntermediateDirectories: true, attributes: nil)
        } catch  {
            throw error
        }
    }

    func createSubDirectoryWithName(_ name: String) throws -> String {
        do {
            let fullPath = self + "/" + name
            try FileManager.default.createDirectory(atPath: fullPath, withIntermediateDirectories: true, attributes: nil)
            return fullPath
        } catch  {
            throw error
        }
    }

    func removeItem() throws {
        do {
            try FileManager.default.removeItem(atPath: self)
        } catch  {
            throw error
        }
    }

}

//MARK: boundingRect of text
public extension String {

    func size(for font: UIFont,
              maxSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude),
              lineBreakMode: NSLineBreakMode = .byWordWrapping,
              paragraphStyle: NSParagraphStyle? = nil) -> CGSize {
        var style = NSMutableParagraphStyle()
        style.lineBreakMode = lineBreakMode
        if paragraphStyle != nil { style = paragraphStyle as! NSMutableParagraphStyle}
        let rect = self.ns.boundingRect(with: maxSize,
                             options: .usesLineFragmentOrigin,
                             attributes: [NSAttributedString.Key.font: font,
                                          NSAttributedString.Key.paragraphStyle: style],
                             context: nil)
        return rect.size
    }

    func height(for font: UIFont,
                maxSize: CGSize = CGSize(width: UIScreen.main.bounds.width, height: .greatestFiniteMagnitude),
              lineBreakMode: NSLineBreakMode = .byWordWrapping,
              paragraphStyle: NSParagraphStyle? = nil) -> CGFloat {
        return size(for: font,
                    maxSize: maxSize,
                    lineBreakMode: lineBreakMode,
                    paragraphStyle: paragraphStyle).height
    }

    func height(for font: UIFont,
                width: CGFloat = UIScreen.main.bounds.width) -> CGFloat {
        return height(for: font,
                      maxSize: CGSize(width: width, height: .greatestFiniteMagnitude))
    }

    func width(for font: UIFont) -> CGFloat {
        return size(for: font, maxSize: CGSize(width: Double.greatestFiniteMagnitude, height: 30)).width
    }

}

//MARK: color
extension String: colorable {
    private var hex: String? {
        get {
            var hex = self.uppercased()
            if hex.hasPrefix("0X") {
                hex = String(hex[index(startIndex, offsetBy: 2) ..< endIndex])
            } else if hex.hasPrefix("#") {
                hex = String(hex[index(startIndex, offsetBy: 1) ..< endIndex])
            }
            switch hex.count {
                case 3...8: return hex
                case 9...: return String(hex[startIndex ..< index(startIndex, offsetBy: 8)])
                default: return nil
            }
        }
    }

    private var hexNumber: Int {
        get {
            var intNumber: UInt64 = 0
            Scanner(string: self).scanHexInt64(&intNumber)
            return Int(intNumber)
        }
    }

    public var color: UIColor {
        guard let hex = self.hex else { return .clear }
        switch hex.count {
        case 3...5:
            let rHex = String(hex[...startIndex])
            let gHex = String(hex[index(startIndex, offsetBy: 1) ... index(startIndex, offsetBy: 1)])
            let bHex = String(hex[index(startIndex, offsetBy: 2) ... index(startIndex, offsetBy: 2)])
            let alphaHex = String(String(hex[index(startIndex, offsetBy: 3)...]))

            let r = rHex.hexNumber
            let g = gHex.hexNumber
            let b = bHex.hexNumber
            let alpha = (alphaHex == "" ? "FF" : alphaHex).hexNumber
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha) / 255.0)
        case 6...8:
            let rHex = String(hex[...index(startIndex, offsetBy: 1)])
            let gHex = String(hex[index(startIndex, offsetBy: 2) ... index(startIndex, offsetBy: 3)])
            let bHex = String(hex[index(startIndex, offsetBy: 4) ... index(startIndex, offsetBy: 5)])
            let alphaHex = String(hex[index(startIndex, offsetBy: 6)...])

            let r = rHex.hexNumber
            let g = gHex.hexNumber
            let b = bHex.hexNumber
            let alpha = (alphaHex == "" ? "FF" : alphaHex).hexNumber
            return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(alpha) / 255.0)
        default: return .clear

        }
    }

}


public extension String {
    var isBlank: Bool {
        get { return self.noBlank.count == 0 }
    }

    var noBlank: String {
        get {
            let components = self.components(separatedBy: .whitespacesAndNewlines)
            return components.joined()
        }
    }

    mutating func removeString(_ substring: String) {
        self = self.replacingOccurrences(of: substring, with: "")
    }

}

//MARK: base64
public extension String {

    var base64Decoded: String? {
        get {
            guard let data = Data(base64Encoded: self) else { return nil }
            return String(data: data, encoding: .utf8)
        }
    }

    var base64Encoded: String {
        get { return Data(self.utf8).base64EncodedString() }
    }
}

//MARK: URL, Request
extension String {
    var url: URL? {
        get{
            return URL(string: self)
        }
    }
    var request: URLRequest? {
        get{
            return URLRequest(string: self)
        }
    }
}

extension String: NumericConvert {
    public var int: Int { get { return Int(self.ns.intValue) } }
    public var float: Float { get { return Float(self.ns.floatValue) } }
    public var double: Double { get { return Double(self.ns.doubleValue) } }
    public var cgFloat: CGFloat { get { return CGFloat(self.ns.floatValue) } }
}

//MARK: Identifiable
extension String: Identifiable {
    public var id: String {
        self
    }
}
