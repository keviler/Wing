//
//  WGridLayout.swift
//  
//
//  Created by 周朋毅 on 2022/8/10.
//

import SwiftUI

public struct WGridLayout {
    public let columns: Int
    public let innerSpacing: CGFloat
    public let lineSpacing: CGFloat
    
    public init(columns: Int, innerSpacing: CGFloat, lineSpacing: CGFloat) {
        self.columns = columns
        self.innerSpacing = innerSpacing
        self.lineSpacing = lineSpacing
    }
}
