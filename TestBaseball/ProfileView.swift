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
    @State private var isSignedIn: Bool = false
    @State private var optionSelected: Bool = false
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                GeometryReader { geo in
                    
                    ProfileFormView(isSignedIn: $isSignedIn)
//                    if isSignedIn == true {
//                        ProfileFormView(isSignedIn: $isSignedIn)
//                    } else {
//                        ProfileFormView(isSignedIn: $isSignedIn)
//                            .blur(radius: 12)
//
//                        SignInView(isSignedIn: $isSignedIn)
//                            .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY - 40)
                        
    //                    VStack {
    //                        Text("Sign in as a Player or Coach")
    //                            .font(.title)
    //                            .padding()
    //
    //                        HStack {
    //
    //                            Button {
    //                                optionSelected = true
    //                                isCoach = false
    //                            } label: {
    //                                Text("Player")
    //                                    .frame(maxWidth: .infinity, minHeight: 40)
    //                            }
    //                            .buttonStyle(.bordered)
    //
    //
    //                            Button {
    //                                optionSelected = true
    //                                isCoach = true
    //                            } label: {
    //                                Text("Coach")
    //                                    .frame(maxWidth: .infinity, minHeight: 40)
    //                            }
    //                            .buttonStyle(.bordered)
    //                        }
    //
    //                        if optionSelected {
    //                            Text(isCoach ? "Coach Selected" : "Player Selected")
    //                                .padding()
    //
    //                            SignInView(isSignedIn: $isSignedIn, isCoach: isCoach)
    //                        }
    //                    }
    //                }
                }
            }
        }
        .onAppear() {
            print("on appear")
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
