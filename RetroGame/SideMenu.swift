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
    var editUser = EditUser()
    
    let homeLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let closetLabel = SKLabelNode(fontNamed: "Avenir-Balck ")
    let bathLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let fridgeLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let walkingLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let socialLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let statsLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let settingLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    
    
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
        menu.position = CGPoint(x: size.width * 0.48, y: size.height * 0.5)
        home?.position = CGPoint(x: size.width * 0.12, y: size.height * 0.688)
        closet?.position = CGPoint(x: size.width * 0.325, y: size.height * 0.69)
        bath?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.688)
        fridge?.position = CGPoint(x: size.width * 0.71, y: size.height * 0.6875)
        walking?.position = CGPoint(x: size.width * 0.12, y: size.height * 0.314)
        social?.position = CGPoint(x: size.width * 0.325, y: size.height * 0.31)
        settings?.position = CGPoint(x: size.width * 0.71, y: size.height * 0.309)
        
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
        
        setupHomeLabel()
        setupClosetLabel()
        setupBathLabel()
        setupFridgeLabel()
        setupWalkingLabel()
        setupSocialLabel()
        setupStatsLabel()
        setupSettingLabel()
    }
    
    func setupHomeLabel() {
        homeLabel.text = "Home"
        homeLabel.fontSize = 23
        homeLabel.fontColor = (.black)
        homeLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(homeLabel)
    }
    func setupClosetLabel() {
        closetLabel.text = "Closet"
        closetLabel.fontSize = 23
        closetLabel.fontColor = (.black)
        closetLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(closetLabel)
    }
    func setupBathLabel() {
        bathLabel.text = "Bath"
        bathLabel.fontSize = 23
        bathLabel.fontColor = (.black)
        bathLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(bathLabel)
    }
    func setupFridgeLabel() {
        fridgeLabel.text = "Fridge"
        fridgeLabel.fontSize = 23
        fridgeLabel.fontColor = (.black)
        fridgeLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(fridgeLabel)
    }
    func setupWalkingLabel() {
        walkingLabel.text = "Walking"
        walkingLabel.fontSize = 23
        walkingLabel.fontColor = (.black)
        walkingLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(walkingLabel)
    }
    func setupSocialLabel() {
        socialLabel.text = "Social"
        socialLabel.fontSize = 23
        socialLabel.fontColor = (.black)
        socialLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(socialLabel)
    }
    func setupStatsLabel() {
        statsLabel.text = "Stats"
        statsLabel.fontSize = 23
        statsLabel.fontColor = (.black)
        statsLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(statsLabel)
    }
    func setupSettingLabel() {
        settingLabel.text = "Settings"
        settingLabel.fontSize = 23
        settingLabel.fontColor = (.black)
        settingLabel.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(settingLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if home?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
//            if closet?.contains(location) == true {
//                let mainGameScreen = MainScreen(size: size)
//                mainGameScreen.scaleMode = .aspectFill
//                view?.presentScene(mainGameScreen)
//            }
            if bath?.contains(location) == true {
                let bathScene = BathScene(size: size)
                bathScene.scaleMode = .aspectFill
                view?.presentScene(bathScene)
                editUser.bath_levels()
            }
            if fridge?.contains(location) == true {
               let harvestGame = Harvest(size: size)
                harvestGame.scaleMode = .aspectFill
                view?.presentScene(harvestGame)
            }
            if walking?.contains(location) == true {
                let runnerGame = Runner(size: size)
                runnerGame.scaleMode = .aspectFill
                view?.presentScene(runnerGame)
            }
//            if social?.contains(location) == true {
//                let mainGameScreen = MainScreen(size: size)
//                mainGameScreen.scaleMode = .aspectFill
//                view?.presentScene(mainGameScreen)
//            }
            if stats?.contains(location) == true {
                let statsScreen = StatsMenu(size: size)
                statsScreen.scaleMode = .aspectFill
                view?.presentScene(statsScreen)
            }
            if settings?.contains(location) == true {
                let settingsScreen = SettingsMenu(size: size)
                settingsScreen.scaleMode = .aspectFill
                view?.presentScene(settingsScreen)
            }
        }
    }
}
