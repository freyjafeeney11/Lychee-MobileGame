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

    @State private var goMain = false
    @ObservedObject private var messageManager = MessageManager()
    @State private var newMessageText = ""


    var body: some View{
        VStack{
            ScrollView{
                ForEach(messageManager.messages, id: \.id) { message in
                    ChatBubble(message: message)
                }
            }
            .padding(.top, 10)
            .background(.white)
        }
        .background(Color("Peach"))
        
        HStack{
            TextField(placeholder: Text("Type a message"), text: $newMessageText)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button("Send") {
                messageManager.sendMessage(text: newMessageText)
                newMessageText = ""
            }
            
        }
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

