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
    
    let curr = db.collection("users").document("Tess")
    
    
    func runner_levels(){
        db.collection("users")
    }
}
