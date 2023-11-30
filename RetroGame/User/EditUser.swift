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
    @Published public var username = "";
    @Published var new_update = UserHealth()
    
    //let curr = db.collection("users").document("Tess")
    
    func updateUserLevel(update: UserHealth){
        new_update = UserHealth()
        username = new_update.name
        
        new_update.addHunger(newHunger: new_update.hunger_level)
        new_update.addEnergy(newEnergy: new_update.energy_level)
        new_update.addSocial(newSocial: new_update.social_level)
        new_update.addHygiene(newHygiene: new_update.hygiene_level)
        new_update.addHappiness(newHappiness: new_update.happiness_level)
        
        updateFirestore(user: new_update)
        
    }
    
    func updateFirestore(user: UserHealth){
        let firestoreUser = self.db.collection("users")
        print("user name from new_update" + new_update.name)
        firestoreUser.whereField("name", isEqualTo: new_update.name).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = documentSnapshot?.documents else { return }
            
            for doc in docs { //iterate over each document and update
                let docRef = doc.reference
                docRef.updateData(["energy_level" : self.new_update.energy_level])
                docRef.updateData(["hunger_level" : self.new_update.hunger_level])
                docRef.updateData(["social_level" : self.new_update.social_level])
                docRef.updateData(["hygiene_level" : self.new_update.hygiene_level])
                docRef.updateData(["coins" : self.new_update.coins])
                docRef.updateData(["happiness_level" : self.new_update.happiness_level])
            }
        })
    }
    
    func runner_levels(coins: Int){
        let currUser = self.db.collection("users")
        
        currUser.whereField("name", isEqualTo: username).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = documentSnapshot?.documents else { return }
            
            for doc in docs { //iterate over each document and update
                let docRef = doc.reference
                docRef.updateData(["energy_level" : self.new_update.addEnergy(newEnergy: -30)])
                docRef.updateData(["coins" : self.new_update.addCoins(moreCoins: coins)])
                docRef.updateData(["hygiene_levels" : self.new_update.addHygiene(newHygiene: -20)])
            }
        })
    }
    
    func bath_levels(){
        let currUser = self.db.collection("users")
        
        currUser.whereField("name", isEqualTo: username).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = documentSnapshot?.documents else { return }
            
            for doc in docs { //iterate over each document and update
                let docRef = doc.reference
                docRef.updateData(["energy_level" : self.new_update.addEnergy(newEnergy: 10)])
                docRef.updateData(["happiness_level" : self.new_update.addHappiness(newHappiness: 50)])
                docRef.updateData(["hygiene_levels" : self.new_update.setHygiene(newHygiene: 100)])
            }
        })
    }
}
