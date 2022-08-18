//
//  GridView.swift
//  WingDemo
//
//  Created by 周朋毅 on 2022/8/18.
//

import SwiftUI
import Wing

struct GridView: View {
    @State var models = [Model(name: "1", icon: "swift"),
                        Model(name: "2", icon: "square.and.arrow.up"),
                        Model(name: "3", icon: "swift"),
                        Model(name: "4", icon: "square.and.arrow.down.fill"),
                        Model(name: "5", icon: "swift"),
                        Model(name: "6", icon: "swift"),
                        Model(name: "7", icon: "swift")]

    var body: some View {
        WGrid(models, cell: { model in
            VStack {
                Text(model.name)
                Image(systemName: model.icon)
            }
            .frame(height: 100)
            .frame(maxWidth: .infinity)
            .background(Color.gray)
            .cornerRadius(8, antialiased: true)
        })
        .layout(WGridLayout(columns: 4, innerSpacing: 20, lineSpacing: 10, spareSpace: false))
        .gridHeaderView(gridHeaderView: {
            Text("xxxx")
                .frame(maxWidth: .infinity)
                .padding(50)
                .background(Color.blue)
        })
        .contentInsets(.init(top: 0, leading: 16, bottom: 0, trailing: 16))
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView()
    }
}
