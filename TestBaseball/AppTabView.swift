//
//  AppTabView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI
import Firebase

struct AppTabView: View {
    
    @EnvironmentObject var teams: Teams
    @State private var selection = 0
    @State private var resetNavigationID = UUID()
    
    private func fetchTeams() {
        guard let user = Auth.auth().currentUser else { return }
        let reference = Firestore.firestore().collection("Users").document("\(user.uid)")
        
        reference.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let data = document.data() else { return }
                
                guard let teamsData = data["teams"] as? [DocumentReference] else { return }
                
                for team in teamsData {
                    team.getDocument { (document, error) in
                        guard let document = document, document.exists else { return }
                        guard let data = document.data() else { return }
                        let teamName = data["teamName"] as? String ?? ""
                        let mascotName = data["mascotName"] as? String ?? ""
                        let level = data["level"] as? String ?? ""
                        
                        let localTeam = Team(id: UUID(), documentID: document.documentID, teamName: teamName, mascotName: mascotName, players: nil, coaches: nil, level: level)
                        teams.teams.append(localTeam)
                    }
                }
            } else {
                print("Document does not exist")
            }
        }
    }
    
    var body: some View {
        
        var selectable = Binding(
            get: { self.selection },
            set: { self.selection = $0
                self.resetNavigationID = UUID()
        })
        
        return TabView(selection: selectable) {
            CreateView()
                .tabItem{
                    Label("Create Session", systemImage: "plus.square.fill")
                }
                .tag(0)
            
            TeamView()
                .tabItem{
                    Label("Team", systemImage: "person.3.fill")
                }
                .tag(1)
            
            StatsView()
                .tabItem{
                    Label("Stats", systemImage: "chart.xyaxis.line")
                }
                .tag(2)
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(3)
        }
        .accentColor(.cyan)
        .onAppear() {
            fetchTeams()
        }
        .onChange(of: selection) { newValue in
            self.resetNavigationID = UUID()
        }
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

class NavigationManager: ObservableObject {
    @Published var activeTab = 0
}

//struct FirebaseUser {
//    @Published var fbuser = Auth.auth().currentUser
//    
//    func checkUser() -> Bool {
//        if fbuser == nil { return false } else { return true }
//    }
//}
