//
//  SocialMenu.swift
//  RetroGame
//
//  Created by Chase on 11/28/23.
//

import SpriteKit
import Foundation
import SwiftUI
import GameplayKit

class SocialMenu: SKScene {
    
    var closeButton: SKSpriteNode?
    

    
    override func didMove(to view: SKView) {
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        //let menu = SKSpriteNode(imageNamed: "SocialMenu")
        
        
        room.setScale(0.85)
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        //menu.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        
        addChild(room)
        //addChild(menu)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            
              
        }
    }
}
