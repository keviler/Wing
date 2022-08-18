//
//  ListNormalView.swift
//  WingDemo
//
//  Created by 周朋毅 on 2022/8/18.
//

import SwiftUI
import Wing

struct ListNormalView: View {
    @State var models = [[WListItem(icon: "sa", title: "sasa", actionMode: .navigationLink({
        AnyView(Text("sasas"))
    })),
                         WListItem(icon: "sa", title: "sasa1"),
                         WListItem(icon: "sa", title: "sasa2"),
                         WListItem(icon: "sa", title: "sasa3")],
                         [WListItem(icon: "sa", title: "sasa", actionMode: .navigationLink({
                             AnyView(Text("sasas"))
                         })),
                                              WListItem(icon: "sa", title: "sasa1"),
                                              WListItem(icon: "sa", title: "sasa2"),
                                              WListItem(icon: "sa", title: "sasa3")]]

    var body: some View {
        WList(models)
    }
}

struct ListNormalView_Previews: PreviewProvider {
    static var previews: some View {
        ListNormalView()
    }
}
