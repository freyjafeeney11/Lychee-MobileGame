//
//  BathScene.swift
//  testing game
//
//  Created by freyja feeney on 10/19/23.
//

import Foundation
import SwiftUI
import GameplayKit
import Firebase
import _SpriteKit_SwiftUI

class BathScene: SKScene {
    private var currentNode: SKNode?
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var menuBar: SKSpriteNode?
    var edit = EditUser()
    
    
    override func didMove(to view: SKView) {
        
        
        //firebase
        
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        
        menuBar = SKSpriteNode(imageNamed: "SideMenuOpen")

        let room = SKSpriteNode(imageNamed: "backgroundTiles")
        let tub = SKSpriteNode(imageNamed: "bathtub")
        let player = SKSpriteNode(imageNamed: "catbat_prototype")
        let bubbles = SKSpriteNode(imageNamed: "Bubbles")
        let shampoo = SKSpriteNode(imageNamed: "Shampoo")
        let sponge = SKSpriteNode(imageNamed: "Sponge")
        sponge.name = "draggable"

        //setting animation
        let tex1 = SKTexture(imageNamed: "catbat_idle1")
        let tex2 = SKTexture(imageNamed: "catbat_idle2")
        let tex3 = SKTexture(imageNamed: "catbat_idle3")
        let bathing = [tex1, tex2, tex3]

        let bathingIdle = SKAction.animate(with: bathing, timePerFrame: 0.3)
        
        let walkAction = SKAction.repeatForever(bathingIdle)
        // entire sequence forever
        player.run(walkAction)
        

        
        backgroundColor = SKColor.white
        room.setScale(0.48)
        tub.setScale(0.8)
        bubbles.setScale(0.6)
        player.setScale(1.25)
        
        
        
        //menu
        menuBar?.setScale(0.8)
        menuBar?.position = CGPoint(x: -248, y: size.height * 0.5)
        
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.45)
        tub.position = CGPoint(x: size.width * 0.55, y: size.height * 0.4)
        bubbles.position = CGPoint(x: size.width * 0.55, y: size.height * 0.42)
        shampoo.position = CGPoint(x: size.width * 0.7, y: size.height * 0.3)
        sponge.position = CGPoint(x: size.width * 0.35, y: size.height * 0.15)
        player.position = CGPoint(x: size.width * 0.62, y: size.height * 0.43)
        
        addChild(room)
        addChild(player)
        addChild(tub)
        addChild(bubbles)
        addChild(shampoo)
        addChild(menuBar!)
        // node is sponge
        addChild(sponge)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            
            if menuBar?.contains(location) == true {
                let menu = SideMenu(size: size)
                menu.scaleMode = .aspectFill
                view?.presentScene(menu)
            }
            if let touch = touches.first {
                let location = touch.location(in: self)
                
                let touchedNodes = self.nodes(at: location)
                for node in touchedNodes.reversed() {
                    if node.name == "draggable" {
                        self.currentNode = node
                    }
                }
            }
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
}

struct BathView: View {
    var scene: SKScene {
        let scene = BathScene(size: CGSize(width: 900, height: 400))
        scene.scaleMode = .aspectFill
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
