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
    @State private var showAlert: Bool = false
    @State private var activeAlert: ActiveAlert = .incompleteForm
    let levels = ["", "Junior High School", "High School", "College"]
    
    enum AddOptions { case addCoach, addPlayer }
    enum ActiveAlert { case saveTeam, incompleteForm}
    
    private func checkForm() {
        var isValid = true
        
        if teamName == "" { isValid = false }
        if mascotName == "" { isValid = false }
        if level == "" { isValid = false }
        
        if isValid {
            self.activeAlert = .saveTeam
        } else {
            self.activeAlert = .incompleteForm
        }
        
        showAlert = true
    }
    
    private func saveCoaches() async -> [DocumentReference] {
        let reference = Firestore.firestore().collection("Temp Coaches")
        var coachArray = [DocumentReference]()
        coachArray.append(Firestore.firestore().collection("Users").document("\(Auth.auth().currentUser!.uid)"))
        
        coachArray = await withCheckedContinuation({ continuation in
            for i in 1 ..< coaches.count {
                let document = reference.document()
                coachArray.append(document)
                document.setData([
                    "id": document.documentID,
                    "firstName": coaches[i].firstName ?? "",
                    "lastName": coaches[i].lastName ?? "",
                    "isCoach": coaches[i].isCoach ?? true
                ])
            }
            
            continuation.resume(returning: coachArray)
        })
        
        return coachArray
    }
    
    private func savePlayers() async -> [DocumentReference] {
        let reference = Firestore.firestore().collection("Temp Players")
        var playerArray = [DocumentReference]()
        
        playerArray = await withCheckedContinuation({ continuation in
            for player in players {
                let document = reference.document()
                playerArray.append(document)
                document.setData([
                    "id": document.documentID,
                    "firstName": player.firstName ?? "",
                    "lastName": player.lastName ?? "",
                    "level": level,
                    "bats": player.bats ?? "",
                    "throws": player.hand ?? "",
                    "isCoach": false
                ])
            }
            
            continuation.resume(returning: playerArray)
        })
        
        return playerArray
    }
    
    private func writeDataToDB(coachArray: [DocumentReference], playerArray: [DocumentReference]) async {
        let teamReference = Firestore.firestore().collection("Teams").document()
        let userReference = Firestore.firestore().collection("Users").document("\(Auth.auth().currentUser!.uid)")
        
        teamReference.setData([
            "teamName": teamName,
            "mascotName": mascotName,
            "level": level,
            "players": playerArray,
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
    
    private func saveTeamToDB() {
        Task {
            let coachArray = await saveCoaches()
            let playerArray = await savePlayers()
            await writeDataToDB(coachArray: coachArray, playerArray: playerArray)
        }
    }
    
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
                
                Button {
                    checkForm()
                } label: {
                    Text("Save Team")
                        .font(.title3)
                        .foregroundColor(.cyan)
                        .frame(width: geo.size.width, alignment: .center)
                        .padding()
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
                    AddTeamMember(isCoach: false, coaches: $coaches, players: $players)
                } else {
                    AddTeamMember(isCoach: true, coaches: $coaches, players: $players)
                }
            }
            .navigationTitle("Create Team")
            .alert(isPresented: $showAlert) {
                switch activeAlert {
                case .saveTeam:
                    return Alert(title: Text("Save Team"),
                          message: Text("Are you ready to save this team? You will be able to add players and coaches later"),
                          primaryButton: .default(Text("Yes")) { saveTeamToDB() },
                          secondaryButton: .destructive(Text("No")))
                case .incompleteForm:
                    return Alert(title: Text("Incomplete Form"),
                          message: Text("Cannot save team. Team form is incomplete."),
                          dismissButton: .cancel())
                }
            }
        }
    }
}

struct CreateTeamView_Previews: PreviewProvider {
    static var previews: some View {
        CreateTeamView()
    }
}
