//
//  TitleScreen.swift
//  testing game
//
//  Created by freyja feeney on 10/19/23.
//

import Foundation
import SpriteKit
import SwiftUI
import GameplayKit


class TitleScreen: SKScene {
    
    var startButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let titleBg = SKSpriteNode(imageNamed: "title_BG")
        let title = SKSpriteNode(imageNamed: "title")
        
        backgroundColor = SKColor.white
        
        //change this to play button
        startButton = SKSpriteNode(imageNamed: "FeedingButton")
        startButton?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.4)
        
        titleBg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        title.position = CGPoint(x: size.width * 0.5, y: size.height * 0.6)
        
        title.setScale(1.8)
        startButton?.setScale(2)
        
        self.addChild(titleBg)
        self.addChild(title)
        self.addChild(startButton!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            if startButton?.contains(location) == true {
                // Transition to the main game scene
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
        }
    }
}
