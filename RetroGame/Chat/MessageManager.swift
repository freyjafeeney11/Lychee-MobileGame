//
//  MessageManager.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/2/23.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageManager: ObservableObject {}/*
    class MessageManager: ObservableObject {
    @Published private(set) var messages: [Message] = []
    @Published private(set) var lastMessageID: String = ""
    let db = Firestore.firestore()
    //var mostRecentUser = UserObjectManager.shared.getCurrentUser()
    
    init(){
        getMessages()
    }
    
    //get messages from firestore
    //messages are an array field in user
    func getMessages() {
        print("getmessage")
        let db = Firestore.firestore()
        let userMessages = db.collection("users").document("tess@gmail.com"/*self.mostRecentUser.user*/).collection("messages")
        
        let batch = db.batch()
        
        for m in self.messages{
            let documentRef = userMessages.document("otheruser@gmail.com")
            
            // Use setData for creating or overwriting the document, set merge to true
            batch.setData(["messages": FieldValue.arrayUnion([m])], forDocument: documentRef, merge: true)
        }
        
        batch.commit { (error) in
            if let error = error {
                print("Error updating messages: \(error)")
            } else {
                print("Messages updated successfully")
            }
        }
                
               
    }
    
    func sendMessage(text: String){
        print("sendmessage")

        do{
            let newMessage = Message(id: "\(UUID())", text: text, received: false, timestamp: Date())
            
            try db.collection("users").document("tess@gmail.com").collection("messages").document("otheruser@gmail.com").setData(from: newMessage)
        }
        catch{
            print("error with message going to firestore \(error)")
        }
    }
}

*/
