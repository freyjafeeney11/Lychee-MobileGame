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
    
    
    override func didMove(to view: SKView) {
        
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let player = SKSpriteNode(imageNamed: "catbat_prototype")
        let menu_bar = SKSpriteNode(imageNamed: "SideMenu")
        runnerButton = SKSpriteNode(imageNamed: "RunnerButton")
        
        runnerButton?.position = CGPoint(x: size.width * 0.8, y: size.height * 0.7)
        
        backgroundColor = SKColor.white
        room.setScale(0.85)
        runnerButton?.setScale(0.21)

        let menuWidth = menu_bar.size.width
        let menuXPosition = menuWidth * 0.5
        
        menu_bar.position = CGPoint(x: menuXPosition, y: size.height * 0.5)
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        player.position = CGPoint(x: size.width * 0.45, y: size.height * 0.4)

        addChild(room)
        addChild(player)
        addChild(menu_bar)
        addChild(runnerButton!)
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
        }
    }
}
