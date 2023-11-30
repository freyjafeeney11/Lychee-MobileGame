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
    
    //let curr = db.collection("users").document("Tess")
    
    
    func runner_levels(coins: Int){
        let currUser = self.db.collection("users")
        
        currUser.whereField("name", isEqualTo: "Frey@").getDocuments(completion: { documentSnapshot, error in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            
            guard let docs = documentSnapshot?.documents else { return }
            
            for doc in docs { //iterate over each document and update
                let docRef = doc.reference
                docRef.updateData(["energy_level" : 50])
                docRef.updateData(["coins" : coins])
                docRef.updateData(["hygiene_levels" : 70])
            }
        })
    }
}
