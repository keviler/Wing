//
//  Color++.swift
//  
//
//  Created by 周朋毅 on 2022/8/3.
//

import SwiftUI


public extension Color {
    init(_ hex: String) {
        let scanner = Scanner(string: hex)
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(red: Double(r) / 0xff, green: Double(g) / 0xff, blue: Double(b) / 0xff)
    }
    
    init(_ intValue: Int32) {
        self.init(String(intValue))
    }
}
