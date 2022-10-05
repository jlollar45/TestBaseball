//
//  StrikeZoneViewModel.swift
//  TestBaseball
//
//  Created by John Lollar on 10/2/22.
//

import Foundation

final class StrikeZoneViewModel: ObservableObject {
    
    @Published var confirmationItem: ConfirmationItem?
    
    func finishSession() {
        confirmationItem = AlertContext.finishSession
    }
}
