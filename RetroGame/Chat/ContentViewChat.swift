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

    @StateObject var messageManager = MessageManager()
    @State private var main = false
    var messageArray = ["Hello", "have you worked on the project?", "I think it looks good"]
    
    
    var body: some View{
        VStack{
            VStack{
                //TitleRow()
                
                ScrollView{
                    ForEach(messageManager.messages, id: \.id) { message in
                        MessageView(message: message)
                    }
                }
                .padding(.top, 10)
                .background(.white)
            }
            .background(Color("Peach"))
            
            Button {
                main = true
            } label: {
                Text("back")
                    .font(.custom("Chalkduster", size: 15))
                    .bold()
                    .foregroundColor(.white)
            }
        }
        .fullScreenCover(isPresented: $main, content: {
            // Switch to SpriteKit scene
            MainGameSceneView()
        })
        .ignoresSafeArea()
        
    }
}*/

