//
//  MessageInput.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/2/23.
//

import Foundation
import SwiftUI

/*
struct MessageInput: View{
    @EnvironmentObject var messageManager: MessageManager
    @State private var message = ""
    
    var body: some View{
        HStack{
            TextField(placeholder: Text(""), text: $message)
                .frame(height: 52)
                .disableAutocorrection(true)
            
            Button{
                messageManager.sendMessage(text: message)
                message = ""
            }label: {
                Text("send")
                    .font(.custom("Chalkduster", size: 20))
                    .bold()
                    .foregroundColor(.white)
                    .frame(width:200, height:30)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.green))
            }
        }
        .padding(.horizontal)
        .padding(.vertical)
        .background(Color("Gray"))
        .cornerRadius(50)
        .padding()
                    
    }
}


struct TextField: View{
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View{
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder.opacity(0.5)
            }
        }
        TextField(placeholder: Text(""), text: $text, editingChanged: editingChanged, commit: commit)
    }
}
*/
