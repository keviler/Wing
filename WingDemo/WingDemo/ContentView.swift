//
//  ContentView.swift
//  WingDemo
//
//  Created by 周朋毅 on 2022/8/17.
//

import SwiftUI
import Wing

struct Model: Identifiable {
    var id: String {
        name
    }
    var name: String
    var icon: String
}

struct ContentView: View {

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink("grid") {
                    GridView()
                }
                NavigationLink("list") {
                    ListView()
                }
                .frame(height: 100)
                NavigationLink("list") {
                    ListNormalView()
                }
                .frame(height: 100)

            }

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
