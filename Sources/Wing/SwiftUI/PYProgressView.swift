//
//  PYProgressView.swift
//  Student
//
//  Created by 周朋毅 on 2022/4/2.
//

import SwiftUI

public struct PYProgressView: View {
    
    private struct FKUIProgressView: UIViewRepresentable {
        @State var value: Double
        @State var trackColor: Color?
        typealias UIViewType = UIProgressView
        func makeUIView(context: Context) -> UIProgressView {
            let view = UIProgressView()
            return view
        }
        func updateUIView(_ uiView: UIProgressView, context: Context) {
            uiView.progress = Float(value)
            uiView.tintColor = trackColor?.toUIColor()
        }

    }
    @State private var trackColor: Color?
    @State var value: Double
    public var body: some View {
        ZStack {
            if #available(iOS 14.0, *) {
                ProgressView(value: value)
                    .progressViewStyle(.linear)
                    .tintColor(trackColor)
            } else {
                PYProgressView(value: value)
            }
        }
    }
}

public extension PYProgressView {
    func trackColor(_ color: Color) -> PYProgressView {
        trackColor = color
        return self
    }
}
