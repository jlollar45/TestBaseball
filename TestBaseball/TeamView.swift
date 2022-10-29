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
    
    private func fetchTeams(user: User) {
        let reference = Firestore.firestore().collection("Users").document("\(user.uid)")
        
        reference.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else { return }
                
                guard let teams = data["teams"] as? [DocumentReference] else { return }
                
//                do {
//                    if let data = UserDefaults.standard.data(forKey: "teams"),
//                       let myTeamList = try NSKeyedUnarchiver.unarchivedObject(ofClass: Teams.self, from: data) {
//                        print(myTeamList)
//                    }
//                } catch {
//                    print("Teams error: \(error)")
//                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    private func createTeam() {
        let teamReference = Firestore.firestore().collection("Teams").document()
        let userReference = Firestore.firestore().collection("Users").document("\(Auth.auth().currentUser!.uid)")
        var coachArray: [DocumentReference] = [DocumentReference]()
        coachArray.append(userReference)
        
        teamReference.setData([
            "name": "",
            "level": "",
            "players": [DocumentReference](),
            "coaches": coachArray
        ]) { error in
            if let error = error {
                print("Error: \(error)")
            } else {
                print("Team Document added")
                
                userReference.updateData([
                    "teams": FieldValue.arrayUnion([teamReference])
                ]) { error in
                    if let error = error {
                        print("Error: \(error)")
                    } else {
                        print("Team added to User document")
                    }
                }
            }
        }
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
                                    //list teams that are stored locally
                                }
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
            fetchTeams(user: user)
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
