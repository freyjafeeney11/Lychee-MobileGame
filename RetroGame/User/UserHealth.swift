//
//  UserHealth.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 11/16/23.
//

import Foundation
import FirebaseFirestoreSwift


class UserHealth: Identifiable, Codable{
    @DocumentID
    var id: String?
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
    
    
    init(id: String, name: String, user: String, pass: String, hunger: Int, social: Int, hygiene: Int, happiness: Int, energy: Int, volume: Bool, coins: Int){
        self.user = user
        self.name = name
        self.hunger_level = hunger
        self.social_level = social
        self.hygiene_level = hygiene
        self.happiness_level = happiness
        self.energy_level = energy
        self.pass = pass
        self.volume = volume
        self.coins = coins
    }
    
    func setHunger(newHunger: Int){
        hunger_level = newHunger
    }
    func setSocial(newSocial: Int){
        self.social_level = newSocial
    }
    func setHygiene(newHygiene: Int){
        self.hygiene_level = newHygiene
    }
    func setHappiness(newHappiness: Int){
        self.happiness_level = newHappiness
    }
    func setEnergy(newEnergy: Int){
        self.energy_level = newEnergy
    }
    
    func updateLevel(level: Int, type: String){
        
    }
    
}

    /*
    init(user: String, hunger: Int, social: Int, hygiene: Int, happiness: Int, energy: Int){
        self.user = user
        self.hunger = hunger
        self.social = social
        self.hygiene = hygiene
        self.happiness = happiness
        self.energy = energy
    }
    
    func setHunger(newHunger: Int){
        self.hunger = newHunger
    }
    func setSocial(newSocial: Int){
        self.social = newSocial
    }
    func setHygiene(newHygiene: Int){
        self.hygiene = newHygiene
    }

    func setHunger(newHunger: Int){
        self.hunger = newHunger
    }func setHunger(newHunger: Int){
        self.hunger = newHunger
    }
    
    func setHunger(newHunger: Int){
        self.hunger = newHunger
    }
     */
