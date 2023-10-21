//
//  SideMenu.swift
//  RetroGame
//
//  Created by Chase on 10/21/23.
//

import Foundation
import SwiftUI
import GameplayKit

class SideMenu: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var runnerButton: SKSpriteNode?
    var menuBar: SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let player = SKSpriteNode(imageNamed: "catbat_prototype")
        menuBar = SKSpriteNode(imageNamed: "SideMenuClosed")
        runnerButton = SKSpriteNode(imageNamed: "RunnerButton")
        
        runnerButton?.position = CGPoint(x: size.width * 0.8, y: size.height * 0.7)
        
        menuBar?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        
        backgroundColor = SKColor.white
        room.setScale(0.85)
        runnerButton?.setScale(0.21)
        menuBar?.setScale(3)

        
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.position = CGPoint(x: size.width * 0.45, y: size.height * 0.4)

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
