//
//  TeamView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI

struct TeamView: View {
    
    @ObservedObject var coordinator = Coordinator()
    
    var createTeam = false
     
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            
            GeometryReader { geo in
                //if user is not a part of a team
                VStack {
                    Text("Are you a coach?")
                        .font(.title)
                        .padding()
                    
                    Text("Create a team, or join a previously created team as an assistant")
                        .font(.caption)
                        .padding()
                    
                    HStack {
                        NavigationLink(value: true) {
                            Text("Create Team")
                                .frame(maxWidth: .infinity, minHeight: 40)
                        }
                        .buttonStyle(.bordered)
                        
                        NavigationLink(value: true) {
                            Text("Join Team")
                                .frame(maxWidth: .infinity, minHeight: 40)
                        }
                        .buttonStyle(.bordered)
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
