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
    var stats: SKSpriteNode?
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
        stats = SKSpriteNode(imageNamed: "StatsButton")
        settings = SKSpriteNode(imageNamed: "SettingsButton")
        
        room.setScale(0.85)
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
<<<<<<< HEAD
        menu.position = CGPoint(x: size.width * 0.48, y: size.height * 0.5)
        home?.position = CGPoint(x: size.width * 0.12, y: size.height * 0.688)
        closet?.position = CGPoint(x: size.width * 0.325, y: size.height * 0.69)
        bath?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.688)
        fridge?.position = CGPoint(x: size.width * 0.71, y: size.height * 0.6875)
        walking?.position = CGPoint(x: size.width * 0.12, y: size.height * 0.314)
        social?.position = CGPoint(x: size.width * 0.325, y: size.height * 0.31)
        settings?.position = CGPoint(x: size.width * 0.71, y: size.height * 0.309)
=======
        menu.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        home?.position = CGPoint(x: size.width * 0.135, y: size.height * 0.688)
        closet?.position = CGPoint(x: size.width * 0.338, y: size.height * 0.69)
        bath?.position = CGPoint(x: size.width * 0.5235, y: size.height * 0.688)
        fridge?.position = CGPoint(x: size.width * 0.735, y: size.height * 0.6875)
        walking?.position = CGPoint(x: size.width * 0.1346, y: size.height * 0.314)
        social?.position = CGPoint(x: size.width * 0.34, y: size.height * 0.31)
        stats?.position = CGPoint(x: size.width * 0.537, y: size.height * 0.314)
        settings?.position = CGPoint(x: size.width * 0.737, y: size.height * 0.309)
>>>>>>> f1d4831ae3c0d5fa64d0123a7e3fd930069da6be
        
        addChild(room)
        addChild(menu)
        addChild(home!)
        addChild(closet!)
        addChild(bath!)
        addChild(fridge!)
        addChild(walking!)
        addChild(social!)
        addChild(stats!)
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
            if closet?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
            if bath?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
            if fridge?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
            if walking?.contains(location) == true {
                let runnerGame = Runner(size: size)
                runnerGame.scaleMode = .aspectFill
                view?.presentScene(runnerGame)
            }
            if social?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
            if stats?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
            if settings?.contains(location) == true {
                let settingsScreen = SettingsMenu(size: size)
                settingsScreen.scaleMode = .aspectFill
                view?.presentScene(settingsScreen)
            }
            if bath?.contains(location) == true {
                let menu = BathScene(size: size)
                menu.scaleMode = .aspectFill
                view?.presentScene(menu)
            }
        }
    }
}
