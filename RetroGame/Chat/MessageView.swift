//
//  MessageView.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/2/23.
//

import Foundation
import SwiftUI


struct MessageView: View{
    var message: Message
    
    var body: some View{
        VStack(alignment: message.recieved ? .leading : .trailing
        ){
            HStack{
                Text(message.text)
                    .padding().background(message.recieved ? Color("Gray") : Color("Peach"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.recieved ? .leading : .trailing)
        }
        .frame(maxWidth: .infinity, alignment: message.recieved ? .leading : .trailing)
        .padding(message.recieved ? .leading : .trailing)
        .padding(.horizontal, 10)
    }
}
