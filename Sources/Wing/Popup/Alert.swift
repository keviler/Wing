//
//  File.swift
//  
//
//  Created by 周朋毅 on 2022/8/8.
//

import SwiftUI

struct WAlert<ContentView, Background>: ViewModifier where ContentView: View, Background: View {
    @Binding var isPresented: Bool
    private var contentView: ContentView
    private var background: Background
    private var onTapOutsideToDismiss: Bool = true

    init(isPresented: Binding<Bool>,
        @ViewBuilder content: ()->ContentView,
        @ViewBuilder background: ()->Background) {
        self._isPresented = isPresented
        self.contentView = content()
        self.background = background()
    }
    
    public func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                alertView
            }
        }
    }

    var alertView: some View {
        ZStack {
            background
                .edgesIgnoringSafeArea(.all)
                .contentShape(Rectangle())
                .transition(.opacity)
                .onTapGesture {
                    if onTapOutsideToDismiss {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            contentView
                .transition(AnyTransition.scale.combined(with: .opacity))
        }
    }
    
}

public extension View {
    func wAlert<Content>(isPresented: Binding<Bool>,
                         @ViewBuilder _ content: ()->Content) -> some View where Content: View {
        modifier(WAlert(isPresented: isPresented,
                        content: content,
                        background: {
            Color.black.opacity(0.6)
        }))
    }
    
    func wAlert<Content, Background>(isPresented: Binding<Bool>,
                                     @ViewBuilder content: ()->Content,
                                     @ViewBuilder background: ()->Background) -> some View where Content: View, Background: View  {
        modifier(WAlert(isPresented: isPresented,
                        content: content,
                        background: background))
    }

}
