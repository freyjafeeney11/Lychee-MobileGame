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
    @Published
    var users = [UserHealth]()
    
    
    func addUser(_ user: UserHealth) throws {
        try Firestore
            .firestore()
            .collection("users")
            .addDocument(from: user)
    }
}
