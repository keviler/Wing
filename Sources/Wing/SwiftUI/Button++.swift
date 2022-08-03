//
//  Button++.swift
//  
//
//  Created by 周朋毅 on 2022/8/3.
//

import SwiftUI



struct CapsuleButtonStyle: ButtonStyle {
    var disabled: Bool = true
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(disabled ? Color.systemGray4 : Color.accentColor)
            .foregroundColor(disabled ? Color.systemGray2 : Color.label)
            .clipShape(Capsule())
    }
}

extension Button {
    func capsuleStyle(_ disabled: Bool = true) -> some View {
        buttonStyle(CapsuleButtonStyle(disabled: disabled))
            .disabled(disabled)
    }
}
