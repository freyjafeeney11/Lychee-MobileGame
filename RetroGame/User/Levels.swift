//
//  Levels.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/2/23.
//

import Foundation
import SwiftUI

class Levels{
    static let sharedLevel = Levels()
    
    var hunger: Int
    var happiness: Int
    var social: Int
    var energy: Int
    var hygiene: Int
    
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()
    
    init(){
        hunger = mostRecentUser.hunger_level
        happiness = mostRecentUser.happiness_level
        social = mostRecentUser.social_level
        energy = mostRecentUser.energy_level
        hygiene = mostRecentUser.hygiene_level
        print("energy from levels after pull \(energy)")
    }
}
