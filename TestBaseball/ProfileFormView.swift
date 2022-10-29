//
//  ProfileFormView.swift
//  TestBaseball
//
//  Created by John Lollar on 10/13/22.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileFormView: View {
    
    @ObservedObject var coordinator = Coordinator()
    @State private var firstName: String = UserDefaults.standard.string(forKey: "firstName") ?? ""
    @State private var lastName: String = UserDefaults.standard.string(forKey: "lastName") ?? ""
    @State private var hand: String = UserDefaults.standard.string(forKey: "throws") ?? ""
    @State private var bats: String  = UserDefaults.standard.string(forKey: "bats") ?? ""
    @State private var level: String = UserDefaults.standard.string(forKey: "level") ?? ""
    @State private var isCoach: Bool = UserDefaults.standard.bool(forKey: "isCoach")
    @State private var profileUpdated = false
    let handedness = ["", "Left", "Right"]
    let hits = ["", "Left", "Right", "Switch"]
    let levels = ["", "Junior High School", "High School", "College"]
    @Binding var isSignedIn: Bool
    @State private var showingCoachAlert = false
    
    private func checkUserDefaults() {
        var isValid = true
        
        if firstName == "" {
            isValid = false
            print("check first name")
        }
        
        if lastName == "" {
            isValid = false
            print("check last name")
        }
        
        if hand == "" {
            isValid = false
            print("check hand")
        }
        
        if bats == "" {
            isValid = false
            print("check bats")
        }
        
        if level == "" {
            isValid = false
            print("check level")
        }
        
        if isValid == true {
            writeUserData()
        } else {
            print("Check Fields")
        }
    }
    
    private func writeUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let reference = Firestore.firestore().collection("Users").document("\(user.uid)")
        
        UserDefaults.standard.set(firstName, forKey: "firstName")
        UserDefaults.standard.set(lastName, forKey: "lastName")
        UserDefaults.standard.set(hand, forKey: "throws")
        UserDefaults.standard.set(bats, forKey: "bats")
        UserDefaults.standard.set(level, forKey: "level")
        UserDefaults.standard.set(isCoach, forKey: "isCoach")
        
        reference.setData([
            "firstName": firstName,
            "lastName": lastName,
            "throws": hand,
            "bats": bats,
            "level": level,
            "isCoach": isCoach
        ], merge: true) { error in
            if let error = error {
                print("Error writing document: \(error)")
            } else {
                print("Document successfully written!")
            }
        }
    }
    
    private func firebaseSignOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            isSignedIn = false
            print("signed out")
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            GeometryReader { geo in
                VStack {
                    Form {
                        Section("Name") {
                            TextField("First Name", text: $firstName, prompt: firstName == "" ? Text("First Name") : Text("\(firstName)"))
                            
                            TextField("Last Name", text: $lastName, prompt: lastName == "" ? Text("Last Name") : Text("\(lastName)"))
                        }
                        
                        Section("Player or Coach") {
                            Toggle(isCoach ? "Coach" : "Player", isOn: $isCoach)
                                .onChange(of: isCoach, perform: { newValue in
                                    if isCoach {
                                        showingCoachAlert = true
                                    }
                                })
                                .tint(.cyan)
                        }
                        .alert(isPresented: $showingCoachAlert) {
                            Alert(title: Text("Confirm switch to Coach"), message: Text("Must be coach to create a team, but managing team comes at an extra cost. Confirm?"), primaryButton: .default(Text("Yes")), secondaryButton: .destructive(Text("No")) { isCoach = false })
                        }
                        
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
                        
                        Section("Level") {
                            Picker("Level", selection: $level) {
                                ForEach(levels, id: \.self) {
                                    Text($0)
                                }
                            }
                        }
                        
//                        Section("Teams") {
//
//                        }
                        
                        VStack {
                            Button {
                                checkUserDefaults()
                            } label: {
                                Text("Save Profile")
                                    .font(.title3)
                                    .foregroundColor(.cyan)
                                    .frame(width: geo.size.width, alignment: .center)
                                    .padding()
                            }
                            
                            Divider()
                            
                            Button {
                                firebaseSignOut()
                            } label: {
                                Text("Sign Out")
                                    .font(.title3)
                                    .foregroundColor(.red)
                                    .frame(width: geo.size.width, alignment: .center)
                                    .padding()
                            }
                        }
                    }
                    .navigationTitle("Profile")
                }
            }
        }
    }
}

struct ProfileFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFormView(isSignedIn: .constant(true))
    }
}
