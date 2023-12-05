//
//  Message.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/2/23.
//

import Foundation

public class Message: ObservableObject, Identifiable, Codable{
    @DocumentID
    public var id: String?
    var text: String
    var received: Bool
    var timestamp: Date
    
    init(id: String, text: String, received: Bool, timestamp: Date) {
        self.id = id
        self.text = text
        self.received = received
        self.timestamp = timestamp
    }
}
