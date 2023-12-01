//
//  StatsMenu.swift
//  RetroGame
//
//  Created by Chase on 11/30/23.
//

import SpriteKit
import Foundation
import SwiftUI
import GameplayKit

class StatsMenu: SKScene {
    
    
    override func didMove(to view: SKView) {
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let menu = SKSpriteNode(imageNamed: "SideMenu")
        let hunger = SKSpriteNode(imageNamed: "100Hunger")
        let social = SKSpriteNode(imageNamed: "100social")
        let hygiene = SKSpriteNode(imageNamed: "100Hygiene")
        let energy = SKSpriteNode(imageNamed: "100Energy")
        let happy = SKSpriteNode(imageNamed: "100Happy")
        
        room.setScale(0.58)
        menu.setScale(0.95)
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.45)
        menu.position = CGPoint(x: size.width * 0.47, y: size.height * 0.5)
        
        hunger.position = CGPoint(x: 100, y: 350)
        happy.position = CGPoint(x: 100, y: 310)
        hygiene.position = CGPoint(x: 100, y: 270)
        energy.position = CGPoint(x: 250, y: 350)
        social.position = CGPoint(x: 250, y: 310)

        hunger.setScale(2)
        social.setScale(2)
        hygiene.setScale(2)
        energy.setScale(2)
        happy.setScale(2)
        
        addChild(room)
        addChild(hunger)
        addChild(social)
        addChild(energy)
        addChild(hygiene)
        addChild(happy)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            
            
              
        }
    }
}
