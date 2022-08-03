//
//  UIButton++.swift
//  
//
//  Created by 周朋毅 on 2022/8/3.
//

import UIKit

public extension UIButton {

    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        self.setBackgroundImage(color.image(with: self.size), for: state)
    }

}
