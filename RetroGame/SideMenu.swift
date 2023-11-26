//
//  SideMenu.swift
//  RetroGame
//
//  Created by Chase on 10/21/23.
//

import SpriteKit
import Foundation
import SwiftUI
import GameplayKit

class SideMenu: SKScene {
    
    var closeButton: SKSpriteNode?
    var home: SKSpriteNode?
    var closet: SKSpriteNode?
    var bath: SKSpriteNode?
    var fridge: SKSpriteNode?
    var walking: SKSpriteNode?
    var social: SKSpriteNode?
    var settings: SKSpriteNode?

    
    override func didMove(to view: SKView) {
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let menu = SKSpriteNode(imageNamed: "SideMenu")
        home = SKSpriteNode(imageNamed: "HomeButton")
        closet = SKSpriteNode(imageNamed: "ClosetButton")
        bath = SKSpriteNode(imageNamed: "BathingButton")
        fridge = SKSpriteNode(imageNamed: "FridgeButton")
        walking = SKSpriteNode(imageNamed: "WalkingButton")
        social = SKSpriteNode(imageNamed: "SocialButton")
        settings = SKSpriteNode(imageNamed: "SettingsButton")
        
        room.setScale(0.85)
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        menu.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        home?.position = CGPoint(x: size.width * 0.135, y: size.height * 0.688)
        closet?.position = CGPoint(x: size.width * 0.338, y: size.height * 0.69)
        bath?.position = CGPoint(x: size.width * 0.5235, y: size.height * 0.688)
        fridge?.position = CGPoint(x: size.width * 0.735, y: size.height * 0.6875)
        walking?.position = CGPoint(x: size.width * 0.1346, y: size.height * 0.314)
        social?.position = CGPoint(x: size.width * 0.34, y: size.height * 0.31)
        settings?.position = CGPoint(x: size.width * 0.737, y: size.height * 0.309)
        
        addChild(room)
        addChild(menu)
        addChild(home!)
        addChild(closet!)
        addChild(bath!)
        addChild(fridge!)
        addChild(walking!)
        addChild(social!)
        addChild(settings!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if home?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
            
            if settings?.contains(location) == true {
                let settingsScreen = SettingsMenu(size: size)
                settingsScreen.scaleMode = .aspectFill
                view?.presentScene(settingsScreen)
            }
        }
    }
}
