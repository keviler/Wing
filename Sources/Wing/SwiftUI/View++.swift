//
//  View++.swift
//  View++
//
//  Created by 周朋毅 on 2022/1/11.
//

import SwiftUI

public extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
}

struct ViewDidLoadModifier: ViewModifier {

    @State private var didLoad = false
    private let action: (() -> Void)?

    init(perform action: (() -> Void)? = nil) {
        self.action = action
    }

    func body(content: Content) -> some View {
        content.onAppear {
            if didLoad == false {
                didLoad = true
                action?()
            }
        }
    }

}

//struct ScrollView<Content: View>: View {
//    let axes: Axis.Set
//    let showsIndicators: Bool
//    let offsetChanged: (CGPoint) -> Void
//    let content: Content
//
//    init(
//        axes: Axis.Set = .vertical,
//        showsIndicators: Bool = true,
//        offsetChanged: @escaping (CGPoint) -> Void = { _ in },
//        @ViewBuilder content: () -> Content
//    ) {
//        self.axes = axes
//        self.showsIndicators = showsIndicators
//        self.offsetChanged = offsetChanged
//        self.content = content()
//    }
//
//    var body: some View {
//        SwiftUI.ScrollView(axes, showsIndicators: showsIndicators) {
//            GeometryReader { geometry in
//                Color.clear.preference(
//                    key: ScrollOffsetPreferenceKey.self,
//                    value: geometry.frame(in: .named("scrollView")).origin
//                )
//            }.frame(width: 0, height: 0)
//            content
//        }
//        .coordinateSpace(name: "scrollView")
//        .onPreferenceChange(ScrollOffsetPreferenceKey.self, perform: offsetChanged)
//    }
//
//}


public extension View {

    @ViewBuilder
    func applyIf<T: View>(_ condition: Bool, apply: (Self) -> T) -> some View {
        if condition {
            apply(self)
        } else {
            self
        }
    }

    #if os(iOS)
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
    #endif
}

#if os(iOS)
struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
#endif

public extension View {
    @ViewBuilder func listRowSeparatorHidden() -> some View {
        if #available(iOS 15.0, *) {
            self.listRowSeparator(.hidden)
        } else {
            self
        }
    }
}

public extension View {
    
    @ViewBuilder
    func embedInNavigationLinkIfPossible<Destination: View>(_ condition: Bool, destination: ()-> Destination) -> some View {
        if condition {
            NavigationLink(destination: destination) {
                self
            }
        } else {
            self
        }
    }
}
