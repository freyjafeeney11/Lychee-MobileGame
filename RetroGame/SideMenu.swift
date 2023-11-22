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
    
    override func didMove(to view: SKView) {
        
        let menu = SKSpriteNode(imageNamed: "SideMenu")
        closeButton = SKSpriteNode(imageNamed: "SideMenuClosed")
        
        menu.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        closeButton?.position = CGPoint(x: size.width, y: size.height * 0.5)
        
        addChild(menu)
        addChild(closeButton!)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if closeButton?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
            
            if closeButton?.contains(location) == true {
                let mainGameScreen = MainScreen(size: size)
                mainGameScreen.scaleMode = .aspectFill
                view?.presentScene(mainGameScreen)
            }
        }
    }
}
