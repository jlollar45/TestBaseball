//
//  AlertItem.swift
//  TestBaseball
//
//  Created by John Lollar on 10/2/22.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let dismissButton: Alert.Button
}

struct ConfirmationItem: Identifiable {
    let id = UUID()
    let title: Text
    let message: Text
    let primaryButton: Alert.Button
    let secondaryButton: Alert.Button
}

struct AlertContext {
    
    //MARK: - Session Alerts
    static let finishSession = ConfirmationItem(title: Text("Confirm Finish Session"),
                                                message: Text("Are you sure you want to finish the session?"),
                                                primaryButton: .default(Text("Yes")),
                                                secondaryButton: .cancel(Text("No")))
    
    
}
