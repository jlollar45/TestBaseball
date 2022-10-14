//
//  ProfileFormView.swift
//  TestBaseball
//
//  Created by John Lollar on 10/13/22.
//

import SwiftUI

struct ProfileFormView: View {
    
    @ObservedObject var coordinator = Coordinator()
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            Form {
                Section("Name") {
                    
                }
                
                Section("Handedness") {
                    
                }
                
                Section("Level") {
                    
                }
                
                Section("Teams") {
                    
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct ProfileFormView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileFormView()
    }
}
