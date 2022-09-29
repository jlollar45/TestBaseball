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
        }
        .accentColor(.cyan)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}

struct RootPresentationModeKey: EnvironmentKey {
    static let defaultValue: Binding<RootPresentationMode> = .constant(RootPresentationMode())
}

extension EnvironmentValues {
    var rootPresentationMode: Binding<RootPresentationMode> {
        get { return self[RootPresentationModeKey.self] }
        set { self[RootPresentationModeKey.self] = newValue }
    }
}

typealias RootPresentationMode = Bool

extension RootPresentationMode {
    
    public mutating func dismiss() {
        self.toggle()
    }
}
