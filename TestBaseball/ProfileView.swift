//
//  ProfileView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/29/22.
//

import SwiftUI
import Firebase

//func isSignedIn() -> Bool {
//    if Auth.auth().currentUser != nil {
//        return true
//    } else {
//        return false
//    }
//}

struct ProfileView: View {
    
    @ObservedObject var coordinator = Coordinator()
    @State private var isSignedIn: Bool?
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            
            if let isSignedIn = isSignedIn {
                Text(isSignedIn ? "Signed In" : "Not Signed In")
            }
            
            SignInView(isSignedIn: $isSignedIn)
                .navigationTitle("Profile")
            
        }
        .onAppear() {
//            guard let user = Auth.auth().currentUser else { return }
//            let currentUser = User(id: user.uid)
//            print(currentUser.id)
            if Auth.auth().currentUser != nil {
                isSignedIn = true
            } else {
                isSignedIn = false
            }
        }
    }
    
    func checkUser() -> Bool {
        if Auth.auth().currentUser == nil { return false } else { return true }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
