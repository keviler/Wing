//
//  Wing++.swift
//  Wing++
//
//  Created by 周朋毅 on 2022/1/6.
//

import UIKit
import SwiftMessages

public extension Wing {
    struct Message {
        public static func showAlert(_ info: String) {
            showMSG(info)
        }
        
        public static func showError(_ errorMsg: String) {
            showMSG(errorMsg)
        }
        public static func showMSG(_ msg: String) {
            
            let label = UILabel()
            label.text = msg
            label.textColor = .white
            label.font = .systemFont(ofSize: 13)
            label.textAlignment = .center
            let messageView = BaseView(frame: .zero)
            do {
                let backgroundView = CornerRoundingView()
                backgroundView.layer.cornerRadius = 6
                backgroundView.layer.masksToBounds = true
                backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                messageView.installBackgroundView(backgroundView)
                messageView.installContentView(label, insets: UIEdgeInsets(horizontal: 15, vertical: 10))
                messageView.configureBackgroundView(width: msg.width(for: .systemFont(ofSize: 13)) + 30)
            }
            var config = SwiftMessages.defaultConfig
            config.presentationContext = .window(windowLevel: UIWindow.Level.statusBar)
            config.presentationStyle = .center
            SwiftMessages.show(config: config, view: messageView)

        }

        public static func showSuccess(_ successMsg: String) {
            showMSG(successMsg)
        }
    }
    
    struct View  {
        public static var systemBlur: UIView {
            get {
                let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
                let blurView = UIVisualEffectView(effect: blurEffect)
                return blurView
            }
        }
    }
}

