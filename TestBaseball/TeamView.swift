//
//  TeamView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI
import Firebase

struct TeamView: View {
    
    @ObservedObject var coordinator = Coordinator()
    @State private var isCoach: Bool = UserDefaults.standard.bool(forKey: "isCoach")
    @State private var isSignedIn: Bool = true
    @EnvironmentObject var teams: Teams
    
    enum TeamPageOptions {
        case create, search, select
    }
     
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            GeometryReader { geo in
                VStack {
                    if isSignedIn {
                        if isCoach {
                            List {
                                if teams.teams.count == 0 {
                                    Text("No current teams!")
                                } else {
                                    Section("Manage Teams") {
                                        ForEach(teams.teams, id: \.self) { team in
                                            NavigationLink(value: team) {
                                                Text("\(team.teamName ?? "") \(team.mascotName ?? "")")
                                            }
                                        }
                                    }
                                }
                            }
                            .navigationDestination(for: Team.self) { team in
                                ManageTeamView(team: team)
                            }
                            
                            NavigationLink(value: TeamPageOptions.create) {
                                Text("Create New Team")
                                    .font(.title3)
                                    .foregroundColor(.cyan)
                                    .frame(width: geo.size.width * 0.7, alignment: .center)
                                    .padding()
                            }
                            .buttonStyle(.bordered)
                            
                            NavigationLink(value: TeamPageOptions.search) {
                                Text("Search for Team")
                                    .font(.title3)
                                    .foregroundColor(.cyan)
                                    .frame(width: geo.size.width * 0.7, alignment: .center)
                                    .padding()
                            }
                            .buttonStyle(.bordered)
                        } else {
                            //if is player, worry about that later
                        }
                    } else {
                        //Sign in to create or join a team!
                        //Button leading to Profile page
                    }
                }
                .navigationTitle("Teams")
                .frame(width: geo.size.width)
                .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                .padding(.bottom, 40)
                .navigationDestination(for: TeamPageOptions.self) { option in
                    switch option {
                    case .create:
                        CreateTeamView()
                    case .search:
                        CreateTeamView()
                    case .select:
                        CreateTeamView()
                    }
                }
            }
            .environmentObject(coordinator)
        }
        .onAppear() {
            guard let user = Auth.auth().currentUser else {
                isSignedIn = false
                return
            }
            
            isSignedIn = true
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
