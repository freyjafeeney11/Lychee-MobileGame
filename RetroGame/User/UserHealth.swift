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
    
    
    init(){
        id = ""
        hunger_level = 100
        social_level = 100
        hygiene_level = 100
        happiness_level = 100
        energy_level = 100
        name = ""
        user = ""
        pass = ""
        volume = true
        coins = 0
    }
    
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
    
    func addHunger(newHunger: Int){
        if(hunger_level + newHunger <= 100){
            hunger_level += newHunger
        }
        else{
            hunger_level = 100
        }
    }
    func addSocial(newSocial: Int){
        if(social_level + newSocial <= 100){
            self.social_level += newSocial
        }
        else{
            social_level = 100
        }
    }
    func addHygiene(newHygiene: Int){
        if(hygiene_level + newHygiene <= 100){
            self.hygiene_level += newHygiene
        }
        else{
            hygiene_level = 100
        }
    }
    func addHappiness(newHappiness: Int){
        if(happiness_level + newHappiness <= 100){
            self.happiness_level += newHappiness
        }
        else{
            happiness_level = 100
        }
    }
    func addEnergy(newEnergy: Int){
        if(energy_level + newEnergy <= 100){
            self.energy_level += newEnergy
        }
        else{
            energy_level = 100
        }
    }
    func addCoins(moreCoins: Int){
        self.coins += moreCoins
    }
    

    
    func getHunger() -> Int{
        return hunger_level
    }
    
    func getSocial() -> Int{
        return social_level
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
