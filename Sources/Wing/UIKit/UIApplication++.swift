//
//  File.swift
//  
//
//  Created by 周朋毅 on 2022/8/3.
//

import UIKit

// application storeage info
public extension UIApplication {
    var size: Int64 { get { return FileManager.default.fileSize(of: NSHomeDirectory()) } }
    var documentsURL: URL { get { return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last! } }
    var documentsPath: String { get { return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first! } }
    var cachesURL: URL { get { return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).last! } }
    var cachesPath: String { get { return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first! } }
    var libraryURL: URL { get { return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).last! } }
    var libraryPath: String { get { return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first! } }
}

// application bundleInfo
public extension UIApplication {
    var bundleInfo: [String: Any] { get { return Bundle.main.infoDictionary ?? [:] } }
    var bundleName: String { get { return Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as! String } }
    var bundleID: String { get { return Bundle.main.object(forInfoDictionaryKey: "CFBundleIdentifier") as! String } }
    var version: String { get { return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String } }
    var bundleBuildVersion: String { get { return Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String } }
}


// application fun
public extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
