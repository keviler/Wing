//
//  WListCell.swift
//  
//
//  Created by 周朋毅 on 2022/3/24.
//

import SwiftUI

public struct WListCell: View {
    private var item: WListItem
    public init(item: WListItem) {
        self.item = item
    }
    public var body: some View {
        ZStack {
            switch item.actionMode {
            case .navigationLink(let destination):
                NavigationLink(destination: destination) {
                    content
                }
            case .presentation:
                NavigationLink {
//                    item.destination
                } label: {
                    content
                }
            case .action(let action):
                content
                    .onTapGesture(perform: action)
            default:
                content
            }
        }
    }
    
    var content: some View {
        VStack(spacing: 0) {
            HStack {
                if let icon = item.icon {
                    Image(icon)
                }
                VStack {
                    Text(item.title)
                        .font(.subheadline)
                    if let subtitle = item.subtitle {
                        Text(subtitle)
                            .font(.subheadline)
                            .foregroundColor(Color(UIColor.secondaryLabel))
                    }
                }
                Spacer()
                if let trailingDetail = item.trailingDetail {
                    Text(trailingDetail)
                        .font(.body)
                        .foregroundColor(Color(UIColor.secondaryLabel))
                }
                if item.showIndicator {
                    Image.disclosureIndicator
                }
            }
            .padding(.vertical)
            .contentShape(Rectangle())
        }
    }
}

