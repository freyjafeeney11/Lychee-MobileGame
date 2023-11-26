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
    var menuBar: SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let player = SKSpriteNode(imageNamed: "catbat_prototype")
        menuBar = SKSpriteNode(imageNamed: "SideMenuClosed")
        runnerButton = SKSpriteNode(imageNamed: "RunnerButton")
        
        //levels
        let hunger = SKSpriteNode(imageNamed: "100Hunger")
        let social = SKSpriteNode(imageNamed: "100social")
        let hygiene = SKSpriteNode(imageNamed: "100Hygiene")
        let energy = SKSpriteNode(imageNamed: "100Energy")
        let happy = SKSpriteNode(imageNamed: "100Happy")
        
        
        runnerButton?.position = CGPoint(x: size.width * 0.8, y: size.height * 0.7)
        
        menuBar?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
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
        menuBar?.setScale(3)
        
        //level scale
        hunger.setScale(2)
        social.setScale(2)
        hygiene.setScale(2)
        energy.setScale(2)
        happy.setScale(2)
        
        
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.position = CGPoint(x: size.width * 0.45, y: size.height * 0.4)

        
        addChild(hunger)
        addChild(social)
        addChild(energy)
        addChild(hygiene)
        addChild(happy)
        addChild(room)
        addChild(player)
        addChild(runnerButton!)
        addChild(menuBar!)
        
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
            //if menuBar?.contains(location) == true {
                // Opens Side Menu
            //    let sideMenu = SideMenu(size: size)
            //    sideMenu.scaleMode = .aspectFill
            //    view?.presentScene(sideMenu)
            //}
        }
    }
}

