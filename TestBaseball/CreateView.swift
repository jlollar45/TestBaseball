//
//  CreateView.swift
//  TestBaseball
//
//  Created by John Lollar on 9/20/22.
//

import SwiftUI
import Firebase

struct CreateView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                firebaseTest()
            }
    }
    
    func firebaseTest() {
        let reference = Firebase.Firestore.firestore().collection("111").document("Firebase Buffer")
        
        reference.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
            } else {
                print("Document does not exist")
            }
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
    }
}
