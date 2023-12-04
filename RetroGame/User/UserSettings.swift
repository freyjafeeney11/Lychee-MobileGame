//
//  UserSettings.swift
//  RetroGame
//
//  Created by Chase on 12/3/23.
//

import Foundation
import SwiftUI

class UserSettings{
    static let sharedUserSet = UserSettings()
    
    var username: String
    var password: String
    var petName: String
    var volume: Bool
    var petChoice: String
    
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()
    
    init(){
        username = mostRecentUser.user
        password = mostRecentUser.pass
        petName = mostRecentUser.name
        volume = mostRecentUser.volume
        petChoice = mostRecentUser.pet_choice
        //print("energy from levels after pull \(energy)")
    }
    
    
}
