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
    var bedroom: SKSpriteNode?
    var bath: SKSpriteNode?
    var harvest: SKSpriteNode?
    var walking: SKSpriteNode?
    var social: SKSpriteNode?
    var stats: SKSpriteNode?
    var settings: SKSpriteNode?
    //gets current user
    let userObject = UserObjectManager.shared.getCurrentUser()
    
    let homeLabel = SKLabelNode(fontNamed: "Futura")
    let bedroomLabel = SKLabelNode(fontNamed: "Futura")
    let bathLabel = SKLabelNode(fontNamed: "Futura")
    let harvestLabel = SKLabelNode(fontNamed: "Futura")
    let walkingLabel = SKLabelNode(fontNamed: "Futura")
    let socialLabel = SKLabelNode(fontNamed: "Futura")
    let statsLabel = SKLabelNode(fontNamed: "Futura")
    let settingLabel = SKLabelNode(fontNamed: "Futura")
    
    @State private var chat = false
    
    
    override func didMove(to view: SKView) {
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let menu = SKSpriteNode(imageNamed: "SideMenu")
        home = SKSpriteNode(imageNamed: "HomeButton")
        bedroom = SKSpriteNode(imageNamed: "ClosetButton")
        bath = SKSpriteNode(imageNamed: "BathingButton")
        harvest = SKSpriteNode(imageNamed: "FridgeButton")
        walking = SKSpriteNode(imageNamed: "WalkingButton")
        social = SKSpriteNode(imageNamed: "SocialButton")
        stats = SKSpriteNode(imageNamed: "StatsButton")
        settings = SKSpriteNode(imageNamed: "SettingsButton")
        
        room.setScale(0.559)
        menu.setScale(0.95)
        room.position = CGPoint(x: size.width * 0.4956, y: size.height * 0.465)
        menu.position = CGPoint(x: size.width * 0.47, y: size.height * 0.5)
        home?.position = CGPoint(x: size.width * 0.13, y: size.height * 0.688)
        bedroom?.position = CGPoint(x: size.width * 0.31, y: size.height * 0.69)
        bath?.position = CGPoint(x: size.width * 0.485, y: size.height * 0.688)
        harvest?.position = CGPoint(x: size.width * 0.685, y: size.height * 0.6875)
        walking?.position = CGPoint(x: size.width * 0.13, y: size.height * 0.314)
        social?.position = CGPoint(x: size.width * 0.31, y: size.height * 0.31)
        stats?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.31)
        settings?.position = CGPoint(x: size.width * 0.69, y: size.height * 0.31)
        
        
        addChild(room)
        addChild(menu)
        
        setupHomeLabel()
        setupBedroomLabel()
        setupBathLabel()
        setupHarvestLabel()
        setupWalkingLabel()
        setupSocialLabel()
        setupStatsLabel()
        setupSettingLabel()
    }
    
    func setupHomeLabel() {
        homeLabel.text = "Home"
        homeLabel.fontSize = 21
        homeLabel.position = CGPoint(x: size.width * 0.1585, y: size.height * 0.545)
        addChild(homeLabel)
    }
    func setupBedroomLabel() {
        bedroomLabel.text = "Bedroom"
        bedroomLabel.fontSize = 21
        bedroomLabel.position = CGPoint(x: size.width * 0.35, y: size.height * 0.545)
        addChild(bedroomLabel)
    }
    func setupBathLabel() {
        bathLabel.text = "Bath"
        bathLabel.fontSize = 21
        bathLabel.position = CGPoint(x: size.width * 0.524, y: size.height * 0.545)
        addChild(bathLabel)
    }
    func setupHarvestLabel() {
        harvestLabel.text = "Harvest"
        harvestLabel.fontSize = 21
        harvestLabel.position = CGPoint(x: size.width * 0.727, y: size.height * 0.545)
        addChild(harvestLabel)
    }
    func setupWalkingLabel() {
        walkingLabel.text = "Walk"
        walkingLabel.fontSize = 21
        walkingLabel.position = CGPoint(x: size.width * 0.157, y: size.height * 0.19)
        addChild(walkingLabel)
    }
    func setupSocialLabel() {
        socialLabel.text = "Socials"
        socialLabel.fontSize = 21
        socialLabel.position = CGPoint(x: size.width * 0.353, y: size.height * 0.19)
        addChild(socialLabel)
    }
    func setupStatsLabel() {
        statsLabel.text = "Health"
        statsLabel.fontSize = 21
        statsLabel.position = CGPoint(x: size.width * 0.539, y: size.height * 0.19)
        addChild(statsLabel)
    }
    func setupSettingLabel() {
        settingLabel.text = "Settings"
        settingLabel.fontSize = 21
        settingLabel.position = CGPoint(x: size.width * 0.73, y: size.height * 0.19)
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
//            if bedroom?.contains(location) == true {
//                let bedroomScene = BedroomScene(size: size)
//                bedroomScene.scaleMode = .aspectFill
//                view?.presentScene(bedroomScene)
//            }
            if bath?.contains(location) == true {
                let user = UserObjectManager.shared.getCurrentUser()
                let bathScene = BathScene(size: size)
                bathScene.scaleMode = .aspectFill
                view?.presentScene(bathScene)
                EditUser().bath_levels(user: user)
            }
            if harvest?.contains(location) == true {
               let harvestGame = Harvest(size: size)
                harvestGame.scaleMode = .aspectFill
                view?.presentScene(harvestGame)
            }
            if walking?.contains(location) == true {
                let runnerGame = Runner(size: size)
                runnerGame.scaleMode = .aspectFill
                view?.presentScene(runnerGame)
            }
            if social?.contains(location) == true {
                /*
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
                *//*
                let chatView = ContentViewChat()
                // need this controller to display swiftUI from spritekit
                let host = UIHostingController(rootView: chatView)
                self.view?.window?.rootViewController?.present(host, animated: true, completion: nil)*/
            }
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
