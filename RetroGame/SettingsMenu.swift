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
    
    override func didMove(to view: SKView) {
        
        let settingsMenu = SKSpriteNode(imageNamed: "SettingsMenu")
        toggleMusic = SKSpriteNode(imageNamed: "MusicOnButton")
        
        settingsMenu.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        toggleMusic?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        addChild(settingsMenu)
        addChild(toggleMusic!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if toggleMusic?.contains(location) == true {
                print("Its quiet")
            }
        }
    }
}

