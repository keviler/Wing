//
//  Encodable++.swift
//  FengKao
//
//  Created by 周朋毅 on 2022/1/21.
//

import Foundation

public extension Encodable {
    var jsonData: Data? {
        get {
            do {
                return try JSONEncoder().encode(self)
            } catch {
                return nil
            }
        }
    }

    var jsonObjcet: Any? {
        get {
            guard let data = self.jsonData else {
                return nil
            }
            do {
                return try JSONSerialization.jsonObject(with: data)
            } catch {
                return nil
            }
        }
    }

    var jsonDic: [String: Any]? {
        self.jsonObjcet as? [String: Any]
    }
    var jsonArray: [Any]? {
        self.jsonObjcet as? [Any]
    }
    var jsonString: String? {
        get {
            guard let data = self.jsonData else {
                return nil
            }
            return String(data: data, encoding: .utf8)
        }
    }

}

