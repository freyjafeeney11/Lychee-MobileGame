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
    //    func printUser(){
    //        print("username: \(UserObject.name)")
    //        print("\nemail  is: \(UserObject.user)")
    //        print("\ncoins collected  are: \(UserObject.coins)")
    //    }
    
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
            
            guard let docs = documentSnapshot?.documents else { return }
            
            
//            for doc in docs { //iterate over each document and update
//                let docRef = doc.reference
//                docRef.updateData(["energy_level" : user.energy_level])
//                docRef.updateData(["hunger_level" : user.hunger_level])
//                docRef.updateData(["social_level" : user.social_level])
//                docRef.updateData(["hygiene_level" : user.hygiene_level])
//                docRef.updateData(["coins" : user.coins])
//                docRef.updateData(["happiness_level" : user.happiness_level])
//            }
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
                //self.addHygiene(newHygiene: -20)
                //self.addHunger(newHunger: -20)
                docRef.updateData(["energy_level" : user!.energy_level])
                docRef.updateData(["coins" : user!.coins])
                docRef.updateData(["hygiene_level" : user!.hygiene_level])
                docRef.updateData(["hunger_level" : user!.hunger_level])
            }
        })
        self.pullFromFirestore(user: user!)
        print("edit user coins count is: \(user!.coins)")
    }
    
    
//        func bath_levels(){
//            let currUser = self.db.collection("users")
//    
//            currUser.whereField("name", isEqualTo: UserObject.name).getDocuments(completion: { documentSnapshot, error in
//                if let err = error {
//                    print(err.localizedDescription)
//                    return
//                }
//    
//                guard let docs = documentSnapshot?.documents else { return }
//    
//                for doc in docs { //iterate over each document and update
//                    let docRef = doc.reference
//                    self.addEnergy(newEnergy: 10)
//                    self.addHappiness(newHappiness: 50)
//                    self.setHygiene(newHygiene: 100)
//                    docRef.updateData(["energy_level" : UserObject.energy_level])
//                    docRef.updateData(["happiness_level" : UserObject.happiness_level])
//                    docRef.updateData(["hygiene_level" : UserObject.hygiene_level])
//                }
//            })
//        }
    
    
//        func setSocial(newSocial: Int){
//            UserObject.social_level = newSocial
//        }
//        func setHygiene(newHygiene: Int){
//            UserObject.hygiene_level = newHygiene
//        }
//        func setHappiness(newHappiness: Int){
//            UserObject.happiness_level = newHappiness
//        }
//        func setEnergy(newEnergy: Int){
//            UserObject.energy_level = newEnergy
//        }
//        func setName(newName: String){
//            UserObject.name = newName
//        }
//    
//        func addHunger(newHunger: Int){
//            if(UserObject.hunger_level + newHunger <= 100){
//                UserObject.hunger_level += newHunger
//            }
//            else{
//                UserObject.hunger_level = 100
//            }
//        }
//        func addSocial(newSocial: Int){
//            if(UserObject.social_level + newSocial <= 100){
//                UserObject.social_level += newSocial
//            }
//            else{
//                UserObject.social_level = 100
//            }
//        }
//        func addHygiene(newHygiene: Int){
//            if(UserObject.hygiene_level + newHygiene <= 100){
//                UserObject.hygiene_level += newHygiene
//            }
//            else{
//                UserObject.hygiene_level = 100
//            }
//        }
//        func addHappiness(newHappiness: Int){
//            if(UserObject.happiness_level + newHappiness <= 100){
//                UserObject.happiness_level += newHappiness
//            }
//            else{
//                UserObject.happiness_level = 100
//            }
//        }
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
        
        
        init(id: String, name: String, user: String, pass: String, hunger: Int, social: Int, hygiene: Int, happiness: Int, energy: Int, volume: Bool, coins: Int){
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
        currentUser = UserObject(id: "", name: "", user: "", pass: "", hunger: 0, social: 0, hygiene: 0, happiness: 0, energy: 0, volume: true, coins: 0)
    }

    // update current user
    func updateCurrentUser(with user: UserObject) {
        currentUser = user
    }
}
