//
//  Bundle++.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation

func LocalizedString(_ key: String, tableName: String? = nil, bundle: Bundle = Bundle.main, value: String = "", comment: String = "") -> String {
    return NSLocalizedString(key, tableName: tableName, bundle: bundle, value: value, comment: comment)
}

//MARK: LocalizedString
public extension Bundle {
    func localizedString(_ key: String, tableName: String? = nil, value: String = "", comment: String = "") -> String {
        return NSLocalizedString(key, tableName: tableName, bundle: self, value: value, comment: comment)
    }
}
