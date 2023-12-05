//
//  ContentViewMessage.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/2/23.
//

import Foundation
import SwiftUI

/*
struct ContentViewChat: View{

    //var to see if button was pushed, if it was go back to main screen
    @State private var goMain = false
    @ObservedObject private var messageManager = MessageManager()
    @State private var newMessageText = ""


    var body: some View{
        VStack{
            //scroll view to see list
            ScrollView{
                //prints out each message from messagemanager object
                //message manager object has array of messages
                ForEach(messageManager.messages, id: \.id) { message in
                    ChatBubble(message: message)
                }
            }
            .padding(.top, 10)
            .background(.white)
        }
        .background(Color("Blue"))
        
        HStack{
            TextField(placeholder: Text("Type a message"), text: $newMessageText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            //send button called send message which adds a new message to array
            Button("Send") {
                messageManager.sendMessage(text: newMessageText)
                newMessageText = ""
            }
            
        }
        //go back to main screen if pushed
        Button("back"){
            goMain = true
        }
        .fullScreenCover(isPresented: $goMain, content: {
            // Switch to SpriteKit scene
            MainGameSceneView()
        })
        .ignoresSafeArea()
        
        
    }
}*/

