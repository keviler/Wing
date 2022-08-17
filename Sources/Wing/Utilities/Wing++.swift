//
//  Wing++.swift
//  Wing++
//
//  Created by 周朋毅 on 2022/1/6.
//

import UIKit
import SwiftUI

public extension Wing {
    
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


//public extension Wing {
//    struct Sheet: ViewModifier {
//
//    }
//
//}
//
//public extension Wing {
//    struct Tip: ViewModifier {
//
//    }
//
//}
