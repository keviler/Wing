//
//  View++.swift
//  View++
//
//  Created by 周朋毅 on 2022/1/11.
//

import SwiftUI
import SwiftUIX
import MJRefresh
import Introspect

public extension View {
    func isLoading(_ isLoading: Binding<Bool>) -> some View {
        modifier(IsLoadingModifier(isLoading: isLoading))
    }
}

struct IsLoadingModifier: ViewModifier {
    @Binding var isLoading: Bool
    init(isLoading: Binding<Bool>) {
        self._isLoading = isLoading
    }
    
    func body(content: Content) -> some View {
        content
            .overlay {
                if isLoading {
                    Color.secondarySystemBackground
                        .overlay {
                            ActivityIndicator()
                        }
                }
            }
    }
}

public extension View {
    func onLoad(perform action: (() -> Void)? = nil) -> some View {
        modifier(ViewDidLoadModifier(perform: action))
    }
    
    func insetGrouped() -> some View {
        self
            .padding(.horizontal)
            .background(Color.tertiarySystemBackground)
            .cornerRadius(8)
            .padding([.horizontal, .bottom])
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

struct FKCell: View {
    var icon: String? = nil
    var title: String
    var subTitle: String? = nil
    var body: some View {
        HStack(spacing: 0) {
            HStack(spacing: 0) {
                if icon != nil {
                    Image(icon!)
                        .resizable()
                        .frame(width: 30, height: 30)
                }
                Text(title)
                    .font(Font.system(size: 17))
                    .foregroundColor(Color.label)
                    .padding(.leading)
                Spacer()
                if subTitle != nil {
                    Text(subTitle!)
                        .font(.system(size: 15))
                        .foregroundColor(Color.secondaryLabel)
                }
                Image(systemName: "chevron.forward")
                  .font(Font.system(.caption).weight(.bold))
                  .foregroundColor(Color(UIColor.tertiaryLabel))
            }
        }
        .height(44)
        .maxWidth(.infinity)
    }
}

extension FKCell {
    func showDivider(_ show: Bool = true) -> some View {
        Group {
            if show {
                VStack(spacing: 0) {
                    self
                    Divider()
                        .padding(.leading)
                        .padding(.leading, 30)
                }
            } else {
                self
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

//public extension View {
//    func sheet<PopupContent: View>(
//        isPresented: Binding<Bool>,
//        title: String = "",
//        confirmCallback: @escaping () -> () = {},
//        dismissCallback: @escaping () -> () = {},
//        @ViewBuilder view: @escaping () -> PopupContent) -> some View {
//            self
//                .popup(isPresented: isPresented,
//                       type: .toast,
//                       dragToDismiss: true,
//                       closeOnTap: false,
//                       closeOnTapOutside: true,
//                       backgroundColor: Color(UIColor.black.withAlphaComponent(0.6)),
//                       dismissCallback: dismissCallback) {
//                    FKSheetCardView {
//                        VStack {
//                            HStack {
//                                Image(systemName: "xmark")
//                                    .resizable()
//                                    .width(15)
//                                    .height(15)
//                                    .padding()
//                                    .onTapGesture {
//                                        isPresented.wrappedValue = false
//                                    }
//                                Text(title)
//                                    .maxWidth(.infinity)
//                                Button {
//                                    confirmCallback()
//                                    isPresented.wrappedValue = false
//                                } label: {
//                                    Text("确定")
//                                        .foregroundColor(.theme)
//                                        .padding(.horizontal)
//                                }
//                            }
//                            view()
//                        }
//                    }
//                }
//        }
//}




// refresh load more
public extension View {
    func onRefresh(_ refresh: ((UIScrollView?)->Void)?,
                   loadMore:((UIScrollView?)->Void)?) -> some View {
        self
            .introspectScrollView { scrollView in
                if let refresh = refresh {
                    if scrollView.mj_header == nil {
                        scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: {
                            refresh(scrollView)
                        })
                    }
                }
                if let loadMore = loadMore {
                    if scrollView.mj_footer == nil {
                        scrollView.mj_footer = MJRefreshBackFooter(refreshingBlock: {
                            loadMore(scrollView)
                        })
                    }
                }
            }
    }
}

public extension View {
    func secondarySystemBackground() ->some View {
        background {
            Color.secondarySystemBackground
                .edgesIgnoringSafeArea(.all)
        }
    }
    
    @ViewBuilder func blurBackground() -> some View {
        if #available(iOS 15.0, *) {
            self
                .background(.ultraThinMaterial, ignoresSafeAreaEdges: .all)
        } else {
            self
                .background(
                    BlurEffectView(style: .systemUltraThinMaterial)
                        .edgesIgnoringSafeArea(.all)
                )
        }
    }
}

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

public extension ScrollView {
    func bottomView<V>(@ViewBuilder content: () -> V) -> some View where V : View {
        Group {
            if #available(iOS 15.0, *) {
                self
                    .background (
                        Color.secondarySystemBackground
                            .edgesIgnoringSafeArea(.all)
                    )
                    .safeAreaInset(edge: .bottom) {
                        content()
                            .blurBackground()
                    }
            } else {
                VStack(spacing: 0) {
                    self
                        .maxHeight(.infinity)
                        .background (
                            Color.secondarySystemBackground
                                .edgesIgnoringSafeArea(.all)
                        )
                    content()
                        .blurBackground()
                }
            }
        }
    }
    
}
public struct CapsuleRoundedRectangle: Shape {
    public let corners: [RectangleCorner]
    
    public init(corners: [RectangleCorner]) {
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        Path(
            AppKitOrUIKitBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: rect.height / 2
            )
            .cgPath
        )
    }
}

public extension View {
    @inlinable
    func capsuleCorners(
        _ corners: [RectangleCorner], width: CGFloat = 1, color: Color) -> some View {
            overlay {
                CapsuleRoundedRectangle(corners: corners)
                    .stroke(color, lineWidth: width)
            }
    }
}


public extension View {
    func hideNavigationBackButton() -> some View {
        introspectViewController(customize: { con in
//            let backItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self.nav, action: #selector(UINavigationController.popViewControllerWithAnimation))
//            backItem.tintColor = .label
//            con.navigationItem.leftBarButtonItem = backItem
        })
    }
}
