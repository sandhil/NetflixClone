//
//  TabBar.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI

struct TabBar: View {
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
        case comingSoon
        case search
        case downloads
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            
            UpComing()
                .tabItem {
                    Label("Coming Soon", systemImage: "play.circle")
                }
                .tag(Tab.comingSoon)
            Search()
                .tabItem {
                    Label("Searches", systemImage: "magnifyingglass")
                }
                .tag(Tab.search)
            
            Downloads()
                .tabItem {
                    Label("Downloads", systemImage: "arrow.down.circle")
                }
                .tag(Tab.downloads)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor(named:"BackgroundColor")
        }
    }
}

#Preview {
    TabBar()
}
