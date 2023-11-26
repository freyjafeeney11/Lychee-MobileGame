//
//  Backend.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 11/16/23.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUI

class Backend: ObservableObject{

    //@Published var user: UserHealth = UserHealth(user: "", pass: "", hunger: 100,
                                                 //social: 100, hygiene: 100, happiness: 100, energy: 100)
    @Published
    var errorMessage: String?
    
    private var editUser: EditUser = EditUser()
    
    
    private var db = Firestore.firestore()
    
    func addUser(_ user: UserHealth){
        do{
            try editUser.addUser(user)
            errorMessage = nil
        }
        catch{
            print(error)
            errorMessage = error.localizedDescription
        }
    }
    
}
