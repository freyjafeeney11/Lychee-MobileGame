//
//  UserHealth.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 11/16/23.
//

import Foundation
import FirebaseFirestoreSwift


public class UserObject: ObservableObject, Identifiable, Codable{
    @DocumentID
    public var id: String?
    var hunger_level: Int
    var social_level: Int
    var hygiene_level: Int
    var happiness_level: Int
    var energy_level: Int
    var name: String
    var user: String
    var pass: String
    var volume: Bool
    var coins: Int
    var pet_choice: String
    
    
    init(id: String, name: String, user: String, pass: String, hunger: Int, social: Int, hygiene: Int, happiness: Int, energy: Int, volume: Bool, coins: Int, pet: String){
        self.id = id
        self.name = name
        self.user = user
        self.pass = pass
        self.hunger_level = hunger
        self.social_level = social
        self.hygiene_level = hygiene
        self.happiness_level = happiness
        self.energy_level = energy
        self.volume = volume
        self.coins = coins
        self.pet_choice = pet
    }
    
    func setHunger(newHunger: Int){
        self.hunger_level = newHunger
    }
    
    func getName() -> String{
        return self.name
    }
    
}

// made this to be able to access user object from outside files
// is updated every time firestore is updated or pulled from
public class UserObjectManager {
    static let shared = UserObjectManager()

    @Published var currentUser: UserObject?

    private init() {
        // default values
        currentUser = UserObject(id: "", name: "", user: "", pass: "", hunger: 0, social: 0, hygiene: 0, happiness: 0, energy: 0, volume: true, coins: 0, pet: "catbat")
    }

    // update current user
    func updateCurrentUser(with user: UserObject) {
        currentUser = user
    }
}
