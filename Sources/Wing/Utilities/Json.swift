//
//  Json.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation
import UIKit

//MARK: JSON
public protocol JsonConvertable {
    var json: String? { get }
    var jsonData: Data? { get }
}

public extension JsonConvertable {
    var json: String? {
        get {
            guard let jsonData = self.jsonData else { return nil }
            return String(data: jsonData, encoding: .utf8)
        }
    }

    var jsonData: Data? {
        get {
            do {
                let data = try JSONSerialization.data(withJSONObject: self, options: [])
                return data
            } catch  {
                return nil
            }
        }
    }
}

extension Array: JsonConvertable {}
extension Dictionary: JsonConvertable {}
//extension String: JsonConvertable {}
extension NSNumber: JsonConvertable {}
//extension Int: JsonConvertable {}
//extension Float: JsonConvertable {}
//extension Double: JsonConvertable {}
//extension CGFloat: JsonConvertable {}
