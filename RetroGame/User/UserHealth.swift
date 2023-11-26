//
//  UserHealth.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 11/16/23.
//

import Foundation
import FirebaseFirestoreSwift


struct UserHealth: Identifiable, Codable{
    @DocumentID
    var id: String?
    let hunger_level: Int
    let social_level: Int
    let hygiene_level: Int
    let happiness_level: Int
    let energy_level: Int
    let user: String
    let pass: String
    
    init(user: String, pass: String, hunger: Int, social: Int, hygiene: Int, happiness: Int, energy: Int){
        self.user = user
        self.hunger_level = hunger
        self.social_level = social
        self.hygiene_level = hygiene
        self.happiness_level = happiness
        self.energy_level = energy
        self.pass = pass
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
