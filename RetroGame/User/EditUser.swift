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
    
    /* notes about editUser and UserObject
     
     editUser allows you to edit the UserObject and call:
     
     
     let user = UserObjectManager.shared.getCurrentUser()
     
     let edit = EditUser()
     edit.pullFromFirestore(user: user)
     
     //idk if this line is needed tbh
     UserObjectManager.shared.updateCurrentUser(with: userObject)
     */
    
    
    private var db = Firestore.firestore()
    //var currUser: UserObject? = nil
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()
    
    
    
    func pullFromFirestore(user: UserObject){
        let db = Firestore.firestore()
        print("from pullfromfirestore: \(self.mostRecentUser.user)")
        let docRef = db.collection("users").document(self.mostRecentUser.user)
        print("this is working in pullfromfirestore")
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
                    self.mostRecentUser.energy_level = data["energy_level"] as! Int
                    self.mostRecentUser.hunger_level = data["hunger_level"] as! Int
                    self.mostRecentUser.social_level = data["social_level"] as! Int
                    self.mostRecentUser.happiness_level = data["happiness_level"] as! Int
                    self.mostRecentUser.hygiene_level = data["hygiene_level"] as! Int
                    self.mostRecentUser.name = data["name"] as! String
                    self.mostRecentUser.pass = data["pass"] as! String
                    self.mostRecentUser.user = data["user"] as! String
                    self.mostRecentUser.pet_name = data["pet_name"] as! String
                    self.mostRecentUser.volume = data["volume"] as! Bool
                    UserObjectManager.shared.updateCurrentUser(with: user)
                    
                    print("\nThis is the name the object should have \(self.mostRecentUser.name)")
                    print("\nthe data name from firestore is: \(String(describing: data["name"]))")
                    self.mostRecentUser.coins = data["coins"] as! Int
                    print("\nThis is the num of coins the object should have from firestore \(self.mostRecentUser.coins)")
                }
                print("this is the most recent user \(self.mostRecentUser.name) and their email \(self.mostRecentUser.user) and energy level \(self.mostRecentUser.energy_level)")
                    
                    /* this is for future use
                     self.new_update.setEnergy(newEnergy: data["energy_level"] as! Int)
                     self.new_update.setEnergy(newEnergy: data["energy_level"] as! Int) */
            }
            
        }
    }
    
    public func updateFirestore(user: UserObject) {
        mostRecentUser.printUser()
        let firestoreUser = self.db.collection("users")
        print("user name from new_update " + mostRecentUser.name)
        firestoreUser.whereField("name", isEqualTo: mostRecentUser.name).getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
        })
        print("this is working")
        do {
            let encodedUser = try Firestore.Encoder().encode(mostRecentUser)
            firestoreUser.document(mostRecentUser.user).setData(encodedUser)
            //UserObjectManager.shared.updateCurrentUser(with: mostRecentUser)
        } catch {
            print("Error updating Firestore: \(error)")
        }
        print("this is working")
        
        pullFromFirestore(user: mostRecentUser)
    }
    
    //changes health levels after playing runner game
    func runner_levels(coins: Int) {
        let currUser = self.db.collection("users")
        print("edit user username is: \(mostRecentUser.name)")
        updateFirestore(user: mostRecentUser)
        currUser.whereField("name", isEqualTo: mostRecentUser.name).getDocuments(completion: { documentSnapshot, error in
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

                docRef.updateData(["energy_level" : self.mostRecentUser.energy_level])
                docRef.updateData(["coins" : self.mostRecentUser.coins])
                docRef.updateData(["hygiene_level" : self.mostRecentUser.hygiene_level])
                docRef.updateData(["hunger_level" : self.mostRecentUser.hunger_level])
            }
        })
        print("pull from firestore")
        self.pullFromFirestore(user: mostRecentUser)
        print("edit user coins count is: \(mostRecentUser.coins)")
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
            print("edit user username is: \(mostRecentUser.name)")
            updateFirestore(user: user)
            currUser.whereField("name", isEqualTo: user.user).getDocuments(completion: { documentSnapshot, error in
                if let err = error {
                    print(err.localizedDescription)
                    return
                }
    
                guard let docs = documentSnapshot?.documents else { return }
    
                for doc in docs { //iterate over each document and update
                    let docRef = doc.reference
                    if user.volume == true{
                        self.setVolume(currVol: false)
                    }else{
                        self.setVolume(currVol: true)
                    }
                    docRef.updateData(["volume" : user.volume])
                }
            })
        }
    
        func setVolume(currVol: Bool){
            mostRecentUser.volume = currVol
        }
    
        func setSocial(newSocial: Int){
            mostRecentUser.social_level = newSocial
        }
        func setHygiene(newHygiene: Int){
            mostRecentUser.hygiene_level = newHygiene
        }
        func setHappiness(newHappiness: Int){
            mostRecentUser.happiness_level = newHappiness
        }
        func setEnergy(newEnergy: Int){
            mostRecentUser.energy_level = newEnergy
        }
        func setName(newName: String){
            mostRecentUser.name = newName
        }
    
        func addHunger(newHunger: Int){
            if(mostRecentUser.hunger_level + newHunger <= 100){
                mostRecentUser.hunger_level += newHunger
            }
            else{
                mostRecentUser.hunger_level = 100
            }
        }
        func addSocial(newSocial: Int){
            if(mostRecentUser.social_level + newSocial <= 100){
                mostRecentUser.social_level += newSocial
            }
            else{
                mostRecentUser.social_level = 100
            }
        }
        func addHygiene(newHygiene: Int){
            if(mostRecentUser.hygiene_level + newHygiene <= 100){
                mostRecentUser.hygiene_level += newHygiene
            }
            else{
                mostRecentUser.hygiene_level = 100
            }
        }
        func addHappiness(newHappiness: Int){
            if(mostRecentUser.happiness_level + newHappiness <= 100){
                mostRecentUser.happiness_level += newHappiness
            }
            else{
                mostRecentUser.happiness_level = 100
            }
        }
    func addEnergy(newEnergy: Int){
        if(mostRecentUser.energy_level + newEnergy <= 100){
                mostRecentUser.energy_level += newEnergy
            }
            else{
                mostRecentUser.energy_level = 100
            }
        }
    func addCoins(moreCoins: Int){
        mostRecentUser.coins += moreCoins
    }
    
    func changePet(pet: String){
        mostRecentUser.pet_choice = pet
    }
}


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
    var pet_name: String
    
    
    init(id: String, name: String, user: String, pass: String, hunger: Int, social: Int, hygiene: Int, happiness: Int, energy: Int, volume: Bool, coins: Int, pet: String, petName: String){
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
        self.pet_name = petName
    }
    
    func setHunger(newHunger: Int){
        self.hunger_level = newHunger
    }
    
    
    func getName() -> String{
        return self.name
    }
    
    func printUser(){
        print("user is : \(name)\n the email is: \(user), password is: \(pass)\nYour \(pet_choice), \(pet_name) health levels are:\n social: \(social_level)\n hygiene: \(hygiene_level)\n happiness: \(happiness_level)\n energy: \(energy_level)\n hunger: \(hunger_level)\n coins: \(coins)")
    }
    
}

// made this to be able to access user object from outside files
// is updated every time firestore is updated or pulled from
public class UserObjectManager {
    static let shared = UserObjectManager()

    private var currentUser: UserObject

    private init() {
        // default values
        currentUser = UserObject(id: "", name: "", user: "", pass: "", hunger: 0, social: 0, hygiene: 0, happiness: 0, energy: 0, volume: true, coins: 0, pet: "", petName: "")
    }
    
    func getCurrentUser() -> UserObject{
        return currentUser
    }

    // update current user
    func updateCurrentUser(with user: UserObject) {
        currentUser = user
    }
}

    
    
    
