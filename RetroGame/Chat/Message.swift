//
//  Message.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/2/23.
//

import Foundation

struct Message: Identifiable, Codable{
    var id: String
    var text: String
    var recieved: Bool
    var timestamp: Date
}
