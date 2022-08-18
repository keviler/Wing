//
//  ListView.swift
//  WingDemo
//
//  Created by 周朋毅 on 2022/8/18.
//

import SwiftUI
import Wing

struct ListView: View {
    @State var models = [[Model(name: "1", icon: "swift"),
                          Model(name: "2", icon: "square.and.arrow.up"),
                          Model(name: "3", icon: "swift"),
                          Model(name: "4", icon: "square.and.arrow.down.fill"),
                          Model(name: "5", icon: "swift"),
                          Model(name: "6", icon: "swift"),
                          Model(name: "7", icon: "swift")]]

    var body: some View {
        WList(data: models) { item in
            Text(item.name)
                .frame(maxWidth: .infinity)
                .frame(height: 40)
                .background(Color.blue)
        } header: {
            Text("sasas")
        } footer: {
            Text("sasas")
        }
        .headerView {

        }
        .footerView {

        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
