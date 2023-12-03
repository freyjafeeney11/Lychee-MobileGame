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
    let mostRecentUser = UserObjectManager.shared.currentUser
    
    
    func setUser(obj: UserObject){
        self.currUser = obj
        updateFirestore(user: obj)
        //print("set: \(currUser!.hygiene_level) to: \(obj.hygiene_level)")
    }
    
    func pullFromFirestore(user: UserObject){
        let db = Firestore.firestore()
        
        let docRef = db.collection("users").document(user.name)
        
        docRef.getDocument { (document, error) in
            guard error == nil else {
                print("error", error ?? "")
                return
            }
            
            if let document = document, document.exists {
                let data = document.data()
                if let data = data {
                    print("this is data from firestore", data)
                    if data["energy_level"] != nil{
                        //gets all the data from firestore and updates in userhealth
                        user.energy_level = data["energy_level"] as! Int
                        self.currUser?.setHunger(newHunger: data["hunger_level"] as! Int)
                        user.social_level = data["social_level"] as! Int
                        user.happiness_level = data["happiness_level"] as! Int
                        user.hygiene_level = data["hygiene_level"] as! Int
                        user.name = data["name"] as! String
                        UserObjectManager.shared.updateCurrentUser(with: user)
                        
                        print("\nThis is the name the object could have \(user.name)")
                        print("\nthe data name from firestore is: \(String(describing: data["name"]))")
                        user.coins = data["coins"] as! Int
                        print("\nThis is the num of coins the object should have from firestore \(user.coins)")
                    } else {
                        print("didnt add fields yet")
                        self.setUser(obj: user)
                    }
                    
                    /* this is for future use
                     self.new_update.setEnergy(newEnergy: data["energy_level"] as! Int)
                     self.new_update.setEnergy(newEnergy: data["energy_level"] as! Int) */
                }
            }
            
        }
    }
    
    public func updateFirestore(user: UserObject){
        let firestoreUser = self.db.collection("users")
        print("user name from new_update" + user.name)
        firestoreUser.whereField("name", isEqualTo: user.name).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
        })
        do {
            try firestoreUser.document(user.user).setData(from: user)
            UserObjectManager.shared.updateCurrentUser(with: user)
        } catch {
            print("Error updating Firestore: \(error)")
        }
        
        pullFromFirestore(user: user)
    }
    
    //changes health levels after playing runner game
    func runner_levels(coins: Int){
        let currUser = self.db.collection("users")
        let user = mostRecentUser
        print("edit user username is: \(mostRecentUser!.name)")
        updateFirestore(user: user!)
        currUser.whereField("name", isEqualTo: user!.name).getDocuments(completion: { documentSnapshot, error in
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

                docRef.updateData(["energy_level" : user!.energy_level])
                docRef.updateData(["coins" : user!.coins])
                docRef.updateData(["hygiene_level" : user!.hygiene_level])
                docRef.updateData(["hunger_level" : user!.hunger_level])
            }
        })
        self.pullFromFirestore(user: user!)
        print("edit user coins count is: \(user!.coins)")
    }
    
    
    func bath_levels(user: UserObject){
            let currUser = self.db.collection("users")
    
            currUser.whereField("name", isEqualTo: user.name).getDocuments(completion: { documentSnapshot, error in
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
                    docRef.updateData(["energy_level" : user.energy_level])
                    docRef.updateData(["happiness_level" : user.happiness_level])
                    docRef.updateData(["hygiene_level" : user.hygiene_level])
                }
            })
        }
    
    func volumeToggle(){
            let currUser = self.db.collection("users")
            let user = mostRecentUser
            print("edit user username is: \(mostRecentUser!.name)")
            updateFirestore(user: user!)
            currUser.whereField("name", isEqualTo: user!.name).getDocuments(completion: { documentSnapshot, error in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
    
                guard let docs = documentSnapshot?.documents else { return }
    
                for doc in docs { //iterate over each document and update
                    let docRef = doc.reference
                    if user!.volume == true{
                        self.setVolume(currVol: false)
                    }else{
                        self.setVolume(currVol: true)
                    }
                    docRef.updateData(["volume" : user!.volume])
                }
            })
        }
    
        func setVolume(currVol: Bool){
            mostRecentUser!.volume = currVol
        }
    
        func setSocial(newSocial: Int){
            mostRecentUser!.social_level = newSocial
        }
        func setHygiene(newHygiene: Int){
            mostRecentUser!.hygiene_level = newHygiene
        }
        func setHappiness(newHappiness: Int){
            mostRecentUser!.happiness_level = newHappiness
        }
        func setEnergy(newEnergy: Int){
            mostRecentUser!.energy_level = newEnergy
        }
        func setName(newName: String){
            mostRecentUser!.name = newName
        }
    
        func addHunger(newHunger: Int){
            if(mostRecentUser!.hunger_level + newHunger <= 100){
                mostRecentUser!.hunger_level += newHunger
            }
            else{
                mostRecentUser!.hunger_level = 100
            }
        }
        func addSocial(newSocial: Int){
            if(mostRecentUser!.social_level + newSocial <= 100){
                mostRecentUser!.social_level += newSocial
            }
            else{
                mostRecentUser!.social_level = 100
            }
        }
        func addHygiene(newHygiene: Int){
            if(mostRecentUser!.hygiene_level + newHygiene <= 100){
                mostRecentUser!.hygiene_level += newHygiene
            }
            else{
                mostRecentUser!.hygiene_level = 100
            }
        }
        func addHappiness(newHappiness: Int){
            if(mostRecentUser!.happiness_level + newHappiness <= 100){
                mostRecentUser!.happiness_level += newHappiness
            }
            else{
                mostRecentUser!.happiness_level = 100
            }
        }
    func addEnergy(newEnergy: Int){
        if(mostRecentUser!.energy_level + newEnergy <= 100){
                mostRecentUser?.energy_level += newEnergy
            }
            else{
                mostRecentUser?.energy_level = 100
            }
        }
    func addCoins(moreCoins: Int){
        mostRecentUser?.coins += moreCoins
    }
    
    func changePet(pet: String){
        mostRecentUser?.pet_choice = pet
    }
}


    
    
    
