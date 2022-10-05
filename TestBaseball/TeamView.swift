//
//  TeamView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI

struct TeamView: View {
    
    @ObservedObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
                .navigationTitle("Teams")
        }
    }
}

struct TeamView_Previews: PreviewProvider {
    static var previews: some View {
        TeamView()
    }
}

struct NoTeamView: View {
    var body: some View {
        Text("No Team")
    }
}
