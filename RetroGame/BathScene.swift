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

class BathScene: SKScene, SKPhysicsContactDelegate {
    var isSpongeTouchingPlayer = false
    private var currentNode: SKNode?
    private var washingAction: SKAction?
    private var groundNode: SKSpriteNode?
    private var label : SKLabelNode?
    private var player : SKSpriteNode?
    private var bubbles: SKSpriteNode?
    private var sponge : SKSpriteNode?
    private var spinnyNode : SKShapeNode?
    var menuBar: SKSpriteNode?
    var edit = EditUser()
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()
    var textures = [String]()
    
    
    override func didMove(to view: SKView) {
        
        
        //firebase
        
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        
        menuBar = SKSpriteNode(imageNamed: "SideMenuOpen")

        let room = SKSpriteNode(imageNamed: "backgroundTiles")
        let tub = SKSpriteNode(imageNamed: "bathtub")
        player = SKSpriteNode(imageNamed: "catbat_prototype")
        let bubbles = SKSpriteNode(imageNamed: "Bubbles")
        let shampoo = SKSpriteNode(imageNamed: "Shampoo")
        sponge = SKSpriteNode(imageNamed: "Sponge")
        sponge?.name = "draggable"

        //setting animation
        if mostRecentUser.pet_choice == "cat bat" {
            textures = ["catbat_idle1", "catbat_idle2", "catbat_idle3"]
            player?.position = CGPoint(x: size.width * 0.62, y: size.height * 0.43)
        } else {
            textures = ["chicken-hamster"]
            player?.position = CGPoint(x: size.width * 0.62, y: size.height * 0.55)
        }
        
        let bathing = textures.map { SKTexture(imageNamed: $0) }
        
        let bathingIdle = SKAction.animate(with: bathing, timePerFrame: 0.3)
        
        let walkAction = SKAction.repeatForever(bathingIdle)
        // entire sequence forever
        player!.run(walkAction)
        

        
        backgroundColor = SKColor.white
        room.setScale(0.48)
        tub.setScale(0.8)
        bubbles.setScale(0.6)
        player!.setScale(1.25)
        
        //ground
        groundNode = SKSpriteNode(color: .green, size: CGSize(width: size.width, height: 12))
        groundNode?.position = CGPoint(x: size.width / 2, y: 0)
        
        // add physics to ground
        groundNode?.physicsBody = SKPhysicsBody(rectangleOf: groundNode!.size)
        groundNode?.physicsBody?.isDynamic = false
        // collisons
        groundNode?.physicsBody?.categoryBitMask = 1
        //trying to add sponge gravity
        sponge?.physicsBody = SKPhysicsBody(circleOfRadius: sponge!.size.width / 2)
        sponge?.physicsBody?.affectedByGravity = true
        sponge?.physicsBody?.isDynamic = true
        //menu
        menuBar?.setScale(0.8)
        menuBar?.position = CGPoint(x: -248, y: size.height * 0.5)
        
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.45)
        tub.position = CGPoint(x: size.width * 0.55, y: size.height * 0.4)
        shampoo.position = CGPoint(x: size.width * 0.7, y: size.height * 0.3)
        sponge?.position = CGPoint(x: size.width * 0.35, y: size.height * 0.15)
        bubbles.position = CGPoint(x: size.width * 0.55, y: size.height * 0.41)
        
        addChild(groundNode!)
        addChild(room)
        addChild(player!)
        addChild(tub)
        addChild(bubbles)
        addChild(shampoo)
        addChild(sponge!)
        addChild(menuBar!)
        
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
        for touch in touches {
            let location = touch.location(in: self)
            if sponge!.frame.intersects(player!.frame) && !isSpongeTouchingPlayer {
                playBubblesAnimation(at: sponge!.position)
                isSpongeTouchingPlayer = true
            } else if !sponge!.frame.intersects(player!.frame) {
                isSpongeTouchingPlayer = false
            }
        }
    }
    func playBubblesAnimation(at position: CGPoint) {
        // bubble action
        //bubbles animation!
        let bub1 = SKTexture(imageNamed: "bubbles_animate1")
        let bub2 = SKTexture(imageNamed: "bubbles_animate2")
        let bub3 = SKTexture(imageNamed: "bubbles_animate3")
        let washing = [bub1, bub2, bub3]
        
        let washingAnimation = SKAction.animate(with: washing, timePerFrame: 0.1)
        let bubbleAction = SKAction.repeat(washingAnimation, count : 5)

        // bubble sprite
        let bubble = SKSpriteNode(imageNamed: "bubbles_animate1")
        bubble.position = CGPoint(x: size.width * 0.62, y: size.height * 0.46)
        bubble.setScale(0.45)
        addChild(bubble)

        bubble.run(bubbleAction) {
            bubble.removeFromParent()
        }
    }
    public override init(size: CGSize) {
        super.init(size: size)

        // add physics for sponge
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        physicsWorld.contactDelegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
