//
//  MainScreen.swift
//  testing game
//
//  Created by freyja feeney on 10/19/23.
//

import Foundation
import SwiftUI
import GameplayKit

class MainScreen: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var runnerButton: SKSpriteNode?
    var menuBarOpen: SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        
        menuBarOpen = SKSpriteNode(imageNamed: "SideMenuOpen")

        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let player = SKSpriteNode(imageNamed: "catbat_prototype")
        
        runnerButton = SKSpriteNode(imageNamed: "RunnerButton")
        
        //levels
        let hunger = SKSpriteNode(imageNamed: "100Hunger")
        let social = SKSpriteNode(imageNamed: "100social")
        let hygiene = SKSpriteNode(imageNamed: "100Hygiene")
        let energy = SKSpriteNode(imageNamed: "100Energy")
        let happy = SKSpriteNode(imageNamed: "100Happy")
        
        runnerButton?.position = CGPoint(x: size.width * 0.8, y: size.height * 0.7)
        

        //level position
        hunger.position = CGPoint(x: 100, y: 350)
        happy.position = CGPoint(x: 100, y: 310)
        hygiene.position = CGPoint(x: 100, y: 270)
        energy.position = CGPoint(x: 250, y: 350)
        social.position = CGPoint(x: 250, y: 310)
        
        hunger.zPosition = 1
        social.zPosition = 1
        hygiene.zPosition = 1
        energy.zPosition = 1
        happy.zPosition = 1
        
        backgroundColor = SKColor.white
        room.setScale(0.85)
        runnerButton?.setScale(0.21)
        
        //level scale
        hunger.setScale(2)
        social.setScale(2)
        hygiene.setScale(2)
        energy.setScale(2)
        happy.setScale(2)
        
        menuBarOpen?.setScale(0.8)
        
        
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.position = CGPoint(x: size.width * 0.45, y: size.height * 0.4)
        menuBarOpen?.position = CGPoint(x: -250, y: size.height * 0.5)
        
        addChild(hunger)
        addChild(social)
        addChild(energy)
        addChild(hygiene)
        addChild(happy)
        addChild(room)
        addChild(player)
        addChild(runnerButton!)
        addChild(menuBarOpen!)
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            if runnerButton?.contains(location) == true {
                // Transition to the runner game scene
                let runnerGame = Runner(size: size)
                runnerGame.scaleMode = .aspectFill
                view?.presentScene(runnerGame)
            }
            
            if menuBarOpen?.contains(location) == true {
                let menu = SideMenu(size: size)
                menu.scaleMode = .aspectFill
                view?.presentScene(menu)
            }
        }
    }
}
