//
//  TeamView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI

struct TeamView: View {
    
    @ObservedObject var coordinator = Coordinator()
    private var isCoach: Bool = UserDefaults.standard.bool(forKey: "isCoach")
    
    var createTeam = false
     
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            
            GeometryReader { geo in
                VStack {
                    
                    if isCoach {
                        //Create team
                        //Search for team to be added to as assistant coach
                    } else {
                        
                    }
                    
                }
                .navigationTitle("Teams")
                .frame(width: geo.size.width * 0.9)
                .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY - 20)
                .buttonStyle(.bordered)
            }
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
