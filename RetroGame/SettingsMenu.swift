//
//  SettingsMenu.swift
//  RetroGame
//
//  Created by Chase on 11/21/23.
//

import SpriteKit
import Foundation
import SwiftUI
import GameplayKit

class SettingsMenu: SKScene {
    
    var toggleMusic: SKSpriteNode?
    var seePass: SKSpriteNode?
    var returnToMenu: SKSpriteNode?
    @State private var showPass = false

    override func didMove(to view: SKView) {
        
        let text = Text("Return To Menu...").font(.title)
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let settingsMenu = SKSpriteNode(imageNamed: "SettingsMenu")
        toggleMusic = SKSpriteNode(imageNamed: "MusicOnButton")
        seePass = SKSpriteNode(imageNamed: "HidePassButton")
        
        room.setScale(0.85)
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        settingsMenu.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        toggleMusic?.position = CGPoint(x: size.width * 0.67, y: size.height * 0.37)
        seePass?.position = CGPoint(x: size.width * 0.75, y: size.height * 0.51)

        addChild(room)
        addChild(settingsMenu)
        addChild(toggleMusic!)
        
        addChild(seePass!)
        
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if toggleMusic?.contains(location) == true {
                print("Its quiet")
            }
            
            if seePass?.contains(location) == true {
                showPass.toggle()
                print("ShowPass")
            }
        }
    }
}

