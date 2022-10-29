//
//  CreateView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI
import Firebase

struct CreateView: View {
    
    //@State private var isModal: Bool = false
    @State private var bullpenSelected = false
    @State private var bpSelected = false
    @State private var sessionSelected = false
    @State private var path = NavigationPath()
    
    @ObservedObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path){
            GeometryReader { geo in
                
                VStack (spacing: 20){
                    
                    NavigationLink(value: false) {
                        Text("Bullpen")
                            .font(.title)
                            .frame(width: geo.size.width * 0.7)
                            .padding()
                    }
                    .buttonStyle(CustomButton())
                    .navigationTitle("Create Session")
                    
                    NavigationLink(value: true) {
                        Text("Batting Practice")
                            .font(.title)
                            .frame(width: geo.size.width * 0.7)
                            .padding()
                    }
                    .buttonStyle(CustomButton())
                    .navigationTitle("Create Session")
                }
                .navigationDestination(for: Bool.self) { isBP in
                    if isBP {
                        BPSelectView()
                    } else {
                        TeamPicker(isBattingPractice: isBP)
                    }
                }
                .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
            }
            .environmentObject(coordinator)
        }
    }
    
//    func firebaseTest() {
//        let reference = Firebase.Firestore.firestore().collection("111").document("Firebase Buffer")
//
//        reference.getDocument { (document, error) in
//            if let document = document, document.exists {
//                let data = document.data()
//            } else {
//                print("Document does not exist")
//            }
//        }
//    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}

struct CustomButton: ButtonStyle {
    
    @Environment(\.colorScheme) var colorScheme
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(
                    Capsule()
                        .fill(.cyan)
                        .shadow(color: colorScheme == .dark ? Color.white.opacity(0.3) : Color.black.opacity(0.2), radius: 10, x: colorScheme == .dark ? -5 : 10, y: colorScheme == .dark ? -5 : 10)
                )
    }
}

//
//extension Color {
//    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
//    static let offWhiteButton = Color(red: 205 / 255, green: 205 / 255, blue: 235 / 255)
//}
