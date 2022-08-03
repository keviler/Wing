//
//  Image++.swift
//  
//
//  Created by 周朋毅 on 2022/8/3.
//

import SwiftUI

public extension Image {
    static var disclosureIndicator: some View {
        Image(systemName: "chevron.forward")
            .font(.caption.weight(.bold))
            .foregroundColor(Color(UIColor.tertiaryLabel))
    }
}
