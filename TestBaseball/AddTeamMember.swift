//
//  AddTeamMember.swift
//  TestBaseball
//
//  Created by John Lollar on 10/29/22.
//

import SwiftUI

struct AddTeamMember: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var isCoach: Bool
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var bats: String = ""
    @State private var hand: String = ""
    
    @Binding var coaches: [AppUser]
    @Binding var players: [AppUser]
    
    let hits = ["", "Left", "Right", "Switch"]
    let handedness = ["", "Left", "Right"]
    
    private func checkForm() {
        var isValid = true
        
        if firstName == "" { isValid = false }
        if lastName == "" { isValid = false }
            
        if isCoach == false {
            if bats == "" { isValid = false }
            if hand == "" { isValid = false }
        }
        
        if isValid {
            saveUser()
        } else {
            print("There is an error in the Add User Form")
        }
    }
    
    private func saveUser() {
        if isCoach {
            coaches.append(AppUser(id: UUID(), firstName: firstName, lastName: lastName))
        } else {
            players.append(AppUser(id: UUID(), firstName: firstName, lastName: lastName, bats: bats, hand: hand))
        }
        
        self.presentationMode.wrappedValue.dismiss()
    }
    
    var body: some View {
        GeometryReader { geo in
            Form {
                Section("Name") {
                    TextField("First Name", text: $firstName, prompt: firstName == "" ? Text("First Name") : Text("\(firstName)"))
                    TextField("Last Name", text: $lastName, prompt: lastName == "" ? Text("Last Name") : Text("\(lastName)"))
                }
                
                if isCoach == false {
                    Section("Handedness") {
                        Picker("Throws", selection: $hand) {
                            ForEach(handedness, id: \.self) {
                                Text($0)
                            }
                        }
                        
                        Picker("Bats", selection: $bats) {
                            ForEach(hits, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }
                
                Button {
                    checkForm()
                } label: {
                    Text(isCoach ? "Save Coach" : "Save Player")
                        .font(.title3)
                        .foregroundColor(.cyan)
                        .frame(width: geo.size.width, alignment: .center)
                        .padding()
                }
            }
            .navigationTitle(isCoach ? "Add Coach" : "Add Player")
        }
    }
}

//struct AddTeamMember_Previews: PreviewProvider {
//    static var previews: some View {
//        AddTeamMember(isCoach: false)
//    }
//}
