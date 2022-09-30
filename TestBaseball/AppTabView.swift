//
//  AppTabView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI

struct AppTabView: View {
    
    var body: some View {
        TabView {
            CreateView()
                .tabItem{
                    Label("Create Session", systemImage: "plus.square.fill")
                }
            
            TeamView()
                .tabItem{
                    Label("Team", systemImage: "person.3.fill")
                }
            
            StatsView()
                .tabItem{
                    Label("Stats", systemImage: "chart.xyaxis.line")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
        }
        .accentColor(.cyan)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}

class Coordinator: ObservableObject {
    @Published var path = NavigationPath()
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
