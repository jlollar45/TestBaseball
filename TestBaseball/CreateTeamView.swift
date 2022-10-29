//
//  CreateTeamView.swift
//  TestBaseball
//
//  Created by John Lollar on 10/22/22.
//

import SwiftUI
import Firebase

struct CreateTeamView: View {
    
    //@ObservedObject var coordinator = Coordinator()
    @State private var teamName: String = ""
    @State private var mascotName: String = ""
    @State private var level: String = ""
    @State private var coaches: [AppUser] = [AppUser]()
    @State private var players: [AppUser] = [AppUser]()
    let levels = ["", "Junior High School", "High School", "College"]
    
    enum AddOptions { case addCoach, addPlayer }
    
    var body: some View {
        GeometryReader { geo in
            Form {
                Section("Team Name") {
                    TextField("Team Name", text: $teamName, prompt: teamName == "" ? Text("Team Name (Ex: School Name)") : Text("\(teamName)"))
                    TextField("Mascot Name", text: $mascotName, prompt: mascotName == "" ? Text("Mascot Name (Ex: Tigers)") : Text("\(mascotName)"))
                }
                
                Section("Level") {
                    Picker("Level", selection: $level) {
                        ForEach(levels, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Coaches") {
                    List(coaches) { coach in
                        Text("\(coach.firstName ?? "") \(coach.lastName ?? "")")
                    }
                    NavigationLink(value: AddOptions.addCoach) {
                        Text("Add Coach +")
                            .foregroundColor(.cyan)
                    }
                }
                
                Section("Players") {
                    List(players) { player in
                        Text("\(player.firstName ?? "") \(player.lastName ?? "")")
                    }
                    NavigationLink(value: AddOptions.addPlayer) {
                        Text("Add Player +")
                            .foregroundColor(.cyan)
                    }
                }
            }
            .onAppear {
                if coaches.count == 0 {
                    let user = AppUser(id: UUID(), firstName: UserDefaults.standard.string(forKey: "firstName") ?? "", lastName: UserDefaults.standard.string(forKey: "lastName") ?? "")
                    coaches.append(user)
                }
            }
            .navigationDestination(for: AddOptions.self) { option in
                if option == .addPlayer {
                    AddTeamMember(isCoach: false, coaches: $coaches)
                } else {
                    AddTeamMember(isCoach: true, coaches: $coaches)
                }
            }
            .navigationTitle("Create Team")
        }
    }
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView()
    }
}
