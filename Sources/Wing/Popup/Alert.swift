//
//  File.swift
//  
//
//  Created by 周朋毅 on 2022/8/8.
//

import SwiftUI

final class WAlertManager {
    static let shared = WAlertManager()
    var alerts: [UIViewController] = []
}

final class WAlertController<Content>: UIHostingController<Content> where Content: View {
    override init(rootView: Content) {
        super.init(rootView: rootView)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
    }
    @MainActor required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

public struct WAlert<ContentView, Background>: ViewModifier where ContentView: View, Background: View {
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
        ZStack(alignment: .center) {
            content
            if isPresented {
                alertView
                    .zIndex(Double.infinity)
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

public extension WAlert {
    @discardableResult
    static func show(@ViewBuilder _ content: ()->ContentView) -> some View where Background == Color {
        return show(content) {
            Color.black.opacity(0.6)
        }
    }

    @discardableResult
    static func show(@ViewBuilder _ content: ()->ContentView, @ViewBuilder background: ()->Background) -> some View {
        let contentView = ZStack(alignment: .center) {
            background()
                .edgesIgnoringSafeArea(.all)
                .contentShape(Rectangle())
                .onTapGesture {
                    WAlert.dismiss()
                }
            content()
                .contentShape(Rectangle())
                .onTapGesture {
                }
        }

        if let rootViewController = UIWindow.key?.rootViewController {
            let alertController = WAlertController(rootView: contentView)
            rootViewController.addChild(alertController)
            rootViewController.view.addSubview(alertController.view)
            rootViewController.view.bringSubviewToFront(alertController.view)
            WAlertManager.shared.alerts.append(alertController)
            alertController.view.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                alertController.view.leftAnchor.constraint(equalTo: rootViewController.view.leftAnchor),
                alertController.view.rightAnchor.constraint(equalTo: rootViewController.view.rightAnchor),
                alertController.view.topAnchor.constraint(equalTo: rootViewController.view.topAnchor),
                alertController.view.bottomAnchor.constraint(equalTo: rootViewController.view.bottomAnchor)
            ])
        }
        return contentView
    }
    
}

public extension WAlert {
    static func dismiss() {
        if let alertController = WAlertManager.shared.alerts.popLast() {
            alertController.removeFromParent()
            alertController.view.removeFromSuperview()
        }
    }
    
    static func dismissAll() {
        WAlertManager.shared.alerts.forEach { alertController in
            alertController.removeFromParent()
            alertController.view.removeFromSuperview()
        }
        WAlertManager.shared.alerts = []
    }
}
