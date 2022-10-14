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
            ZStack {
                if let isSignedIn = isSignedIn {
                    if isSignedIn == true {
                        ProfileFormView()
                    } else {
                        ProfileFormView()
                            .blur(radius: 3)
                        
                        SignInView(isSignedIn: $isSignedIn)
                    }
                }
            }
        }
        .onAppear() {
            if Auth.auth().currentUser != nil {
                isSignedIn = true
            } else {
                isSignedIn = false
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
