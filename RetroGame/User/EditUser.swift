//
//  EditUser.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 11/16/23.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


public class EditUser: ObservableObject{
    
    
    
    private var db = Firestore.firestore()
    var currUser: UserObject? = nil
    
    //let curr = db.collection("users").document("Tess")
    /*
    func updateUserLevel(update: UserHealth){
        new_update = UserHealth()
        
        new_update.addHunger(newHunger: new_update.hunger_level)
        new_update.addEnergy(newEnergy: new_update.energy_level)
        new_update.addSocial(newSocial: new_update.social_level)
        new_update.addHygiene(newHygiene: new_update.hygiene_level)
        new_update.addHappiness(newHappiness: new_update.happiness_level)
        
        updateFirestore(user: new_update)
        
    } */
    func printUser(){
        print("username: \(UserObject.name)")
        print("\nemail  is: \(UserObject.user)")
        print("\ncoins collected  are: \(UserObject.coins)")
    }
    
    func setUser(obj: UserObject){
        currUser = obj
    }
    
    func pullFromFirestore(){
        let db = Firestore.firestore()

        let docRef = db.collection("users").document(UserObject.name)

        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }

            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("this is data from firestore", data)
                    //gets all the data from firestore and updates in userhealth
                    UserObject.energy_level = data["energy_level"] as! Int
                    self.currUser?.setHunger(newHunger: data["hunger_level"] as! Int)
                    UserObject.social_level = data["social_level"] as! Int
                    UserObject.happiness_level = data["happiness_level"] as! Int
                    UserObject.hygiene_level = data["hygiene_level"] as! Int
                    UserObject.name = data["name"] as! String
                    print("\nThis is the name the object could have \(UserObject.name)")
                    print("\nthe data name from firestore is: \(String(describing: data["name"]))")
                    UserObject.coins = data["coins"] as! Int
                    print("\nThis is the num of coins the object should have from firestore \(UserObject.coins)")
                    
                    /* this is for future use
                    self.new_update.setEnergy(newEnergy: data["energy_level"] as! Int)
                    self.new_update.setEnergy(newEnergy: data["energy_level"] as! Int) */
                }
            }

        }
    }
    
    func updateFirestore(){
        let firestoreUser = self.db.collection("users")
        print("user name from new_update" + UserObject.name)
        firestoreUser.whereField("name", isEqualTo: UserObject.name).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = documentSnapshot?.documents else { return }
            
            for doc in docs { //iterate over each document and update
                let docRef = doc.reference
                docRef.updateData(["energy_level" : UserObject.energy_level])
                docRef.updateData(["hunger_level" : UserObject.hunger_level])
                docRef.updateData(["social_level" : UserObject.social_level])
                docRef.updateData(["hygiene_level" : UserObject.hygiene_level])
                docRef.updateData(["coins" : UserObject.coins])
                docRef.updateData(["happiness_level" : UserObject.happiness_level])
            }
        })
        pullFromFirestore()
    }
    
    //changes health levels after playing runner game
    func runner_levels(coins: Int){
        let currUser = self.db.collection("users")
        print("edit user username is: \(UserObject.name)")
        updateFirestore()
        currUser.whereField("name", isEqualTo: UserObject.name).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = documentSnapshot?.documents else { return }
            
            for doc in docs { //iterate over each document and update
                let docRef = doc.reference
                //the method to addEnergy does not work because of new_update? idk i'm confused about this
                // changed back to new_update to see what happens
                self.addEnergy(newEnergy: -30)
                self.addCoins(moreCoins: coins)
                self.addHygiene(newHygiene: -20)
                self.addHunger(newHunger: -20)
                docRef.updateData(["energy_level" : UserObject.energy_level])
                docRef.updateData(["coins" : UserObject.coins])
                docRef.updateData(["hygiene_level" : UserObject.hygiene_level])
                docRef.updateData(["hunger_level" : UserObject.hunger_level])
            }
        })
        self.pullFromFirestore()
        print("edit user coins count is: \(UserObject.coins)")
    }
    
    
    func bath_levels(){
        let currUser = self.db.collection("users")
        
        currUser.whereField("name", isEqualTo: UserObject.name).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = documentSnapshot?.documents else { return }
            
            for doc in docs { //iterate over each document and update
                let docRef = doc.reference
                self.addEnergy(newEnergy: 10)
                self.addHappiness(newHappiness: 50)
                self.setHygiene(newHygiene: 100)
                docRef.updateData(["energy_level" : UserObject.energy_level])
                docRef.updateData(["happiness_level" : UserObject.happiness_level])
                docRef.updateData(["hygiene_level" : UserObject.hygiene_level])
            }
        })
    }
    
    
    func setSocial(newSocial: Int){
        UserObject.social_level = newSocial
    }
    func setHygiene(newHygiene: Int){
        UserObject.hygiene_level = newHygiene
    }
    func setHappiness(newHappiness: Int){
        UserObject.happiness_level = newHappiness
    }
    func setEnergy(newEnergy: Int){
        UserObject.energy_level = newEnergy
    }
    func setName(newName: String){
        UserObject.name = newName
    }
    
    func addHunger(newHunger: Int){
        if(UserObject.hunger_level + newHunger <= 100){
            UserObject.hunger_level += newHunger
        }
        else{
            UserObject.hunger_level = 100
        }
    }
    func addSocial(newSocial: Int){
        if(UserObject.social_level + newSocial <= 100){
            UserObject.social_level += newSocial
        }
        else{
            UserObject.social_level = 100
        }
    }
    func addHygiene(newHygiene: Int){
        if(UserObject.hygiene_level + newHygiene <= 100){
            UserObject.hygiene_level += newHygiene
        }
        else{
            UserObject.hygiene_level = 100
        }
    }
    func addHappiness(newHappiness: Int){
        if(UserObject.happiness_level + newHappiness <= 100){
            UserObject.happiness_level += newHappiness
        }
        else{
            UserObject.happiness_level = 100
        }
    }
    func addEnergy(newEnergy: Int){
        if(UserObject.energy_level + newEnergy <= 100){
            UserObject.energy_level += newEnergy
        }
        else{
            UserObject.energy_level = 100
        }
    }
    func addCoins(moreCoins: Int){
        UserObject.coins += moreCoins
    }
}




struct UserObject: Identifiable, Codable{
    @DocumentID
    var id: String?
    static var hunger_level = 100
    static var social_level = 100
    static var hygiene_level = 100
    static var happiness_level = 100
    static var energy_level = 100
    static var name = ""
    static var user = ""
    static var pass = ""
    static var volume = true
    static var coins = 0
    
    
    init(id: String, name: String, user: String, pass: String, hunger: Int, social: Int, hygiene: Int, happiness: Int, energy: Int, volume: Bool, coins: Int){
        UserObject.user = user
        UserObject.name = name
        UserObject.hunger_level = hunger
        UserObject.social_level = social
        UserObject.hygiene_level = hygiene
        UserObject.happiness_level = happiness
        UserObject.energy_level = energy
        UserObject.pass = pass
        UserObject.volume = volume
        UserObject.coins = coins
    }
    
    func setHunger(newHunger: Int){
        UserObject.hunger_level = newHunger
    }
    
    func getName() -> String{
        return UserObject.name
    }
    
}


