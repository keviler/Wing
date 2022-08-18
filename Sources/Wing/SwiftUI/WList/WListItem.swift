//
//  WListItem.swift
//  
//
//  Created by 周朋毅 on 2022/3/24.
//

import SwiftUI


public struct WListItem: Hashable, Identifiable {
    public enum Action {
        case none
        case presentation
        case navigationLink(()->AnyView)
    //    case popup
        case action(_ action: ()->())
    }

    public static func == (lhs: WListItem, rhs: WListItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    public func hash(into hasher: inout Hasher) {
        hasher.combine(icon)
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(trailingDetail)
    }
    public var id: Int { hashValue }
    
    let icon: String?
    let title: String
    let subtitle: String?
    let trailingDetail: String?
    let showIndicator: Bool
    let actionMode: WListItem.Action

    public init(icon: String? = nil,
         title: String,
         subtitle: String? = nil,
         trailingDetail: String? = nil,
         showIndicator: Bool = true,
                actionMode: WListItem.Action = WListItem.Action.none) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.trailingDetail = trailingDetail
        self.actionMode = actionMode
        self.showIndicator = showIndicator
    }

}

extension Array: Identifiable where Element: Hashable {
   public var id: Int { self.hashValue }
}
