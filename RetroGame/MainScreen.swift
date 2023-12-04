//
//  MainScreen.swift
//  testing game
//
//  Created by freyja feeney on 10/19/23.
//

import Foundation
import SwiftUI
import GameplayKit
import Firebase
import _SpriteKit_SwiftUI

public struct petChoice {
    static var pet = "catbat_ver2-export"
}
//public var shared = MainScreen()

public class MainScreen: SKScene, SKPhysicsContactDelegate {
    var audioPlayer: AVAudioPlayer?
    private var groundNode: SKSpriteNode?
    private var currentNode: SKNode?
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var runnerButton: SKSpriteNode?
    var harvestButton: SKSpriteNode?
    var menuBar: SKSpriteNode?
    var userObject = UserObjectManager.shared.getCurrentUser()
    var spriteString = "catbat_ver2-export"

    
    
    public override func didMove(to view: SKView) {
        let edit = EditUser()
        
        
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        let player = SKSpriteNode(imageNamed: userObject.pet_choice)
        menuBar = SKSpriteNode(imageNamed: "SideMenuOpen")
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let ball = SKSpriteNode(imageNamed: "ball")
        ball.name = "draggable"
        
        //trying to add ball gravity
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        
        
        runnerButton = SKSpriteNode(imageNamed: "RunnerButton")
        harvestButton = SKSpriteNode(imageNamed: "foodCollectButton")
        
        // setting movement
        let moveDistance: CGFloat = 150.0
        let moveDuration: TimeInterval = 0.8
        
        // stay still for 5
        let wait = SKAction.wait(forDuration: 5)
        
        let moveLeft = SKAction.moveBy(x: -moveDistance, y: 0, duration: moveDuration)
        let moveRight = SKAction.moveBy(x: moveDistance, y: 0, duration: moveDuration)
        
        //setting animation by calling right files
        //let walking = updatePet()
        var walking: [SKTexture] = []
        var flipLeft = SKAction.scaleX(to: 1, duration: 0.0)
        var flipRight = SKAction.scaleX(to: -1, duration: 0.0)
        
        // PROBLEM:
        // the pet_choice is nil, it wont pull from firestore
        // i think mainscreen is presented too soon to be able to pull
        // user info
        UserObjectManager.shared.getCurrentUser()
        edit.pullFromFirestore(user: userObject)
        // this is printing nothing
        print("PET CHOICE : \(userObject.pet_choice)")
        if userObject.pet_choice == "chicken-hamster" {
            spriteString = "chicken-hamster"
            let tex1 = SKTexture(imageNamed: "chicken-hamster_run1")
            let tex2 = SKTexture(imageNamed: "chicken-hamster_run2")
            let tex3 = SKTexture(imageNamed: "chicken-hamster_run3")
            walking = [tex1, tex2, tex3]
            flipLeft = SKAction.scaleX(to: -1, duration: 0.0)
            flipRight = SKAction.scaleX(to: 1, duration: 0.0)
            player.xScale = -1
        }
        // set default for now
        else {
            spriteString = "catbat_ver2-export"
            let tex1 = SKTexture(imageNamed: "batcat_run1")
            let tex2 = SKTexture(imageNamed: "batcat_run2")
            let tex3 = SKTexture(imageNamed: "batcat_run3")
            let tex4 = SKTexture(imageNamed: "batcat_run4")
            walking = [tex1, tex2, tex3, tex4]
            player.xScale = 1
            // chicken hamster runs backwards, multiply flip by this flip to change default, scale might change that though
        }
        let walkingAnimation = SKAction.animate(with: walking, timePerFrame: 0.13)
        let sittingSprite = SKTexture(imageNamed: spriteString)
        let sitAction = SKAction.setTexture(sittingSprite)
        // change sprite to sitting when sitting updated in updatePet()
        

        // this action plays the walking animation
        
        let walkAction = SKAction.repeat(walkingAnimation, count: Int(floor(2.0)))
        // move left and walk
        let moveAndAnimateLeft = SKAction.group([moveLeft, walkAction])
        // move right and walk
        let moveAndAnimateRight = SKAction.group([moveRight, walkAction])
        // flipping left and right
        let flipLeft = SKAction.scaleX(to: 1, duration: 0.0)
        let flipRight = SKAction.scaleX(to: -1, duration: 0.0)
        // sequence where flip left for move left
        let moveLeftAndFlip = SKAction.sequence([flipLeft, moveAndAnimateLeft, sitAction, wait])
        // flip right for move right
        let moveRightAndFlip = SKAction.sequence([flipRight, moveAndAnimateRight, sitAction, wait])
        // repeat the movement forever
        let moveAndAnimateRepeat = SKAction.repeatForever(SKAction.sequence([moveLeftAndFlip, moveRightAndFlip]))

        // initial scale to face right
        player.xScale = 1

        // entire sequence forever
        player.run(moveAndAnimateRepeat)
        
        runnerButton?.position = CGPoint(x: size.width * 0.84, y: size.height * 0.65)
        harvestButton?.position = CGPoint(x: size.width * 0.19, y: size.height * 0.65)
        groundNode = SKSpriteNode(color: .green, size: CGSize(width: size.width, height: 10))
        groundNode?.position = CGPoint(x: size.width / 2, y: 0)
        
        // physics body to the ground
        groundNode?.physicsBody = SKPhysicsBody(rectangleOf: groundNode!.size)
        groundNode?.physicsBody?.isDynamic = false
        groundNode?.physicsBody?.categoryBitMask = 1

        addChild(groundNode!)
        
        backgroundColor = SKColor.white
        ball.setScale(0.25)
        room.setScale(0.559)
        runnerButton?.setScale(0.2)
        //harvestButton?.setScale(1.1)
        //menu
        menuBar?.setScale(0.79)
        menuBar?.position = CGPoint(x: -245, y: size.height * 0.5)
        
        room.position = CGPoint(x: size.width * 0.4956, y: size.height * 0.465)
        player.position = CGPoint(x: size.width * 0.45, y: size.height * 0.3)
        ball.position = CGPoint(x: size.width * 0.75, y: size.height * 0.2)
        
        addChild(room)
        addChild(player)
        //addChild(runnerButton!)
        //addChild(harvestButton!)
        addChild(ball)
        addChild(menuBar!)
        
    }

    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            if runnerButton?.contains(location) == true {
                // Transition to the runner game scene
                let runnerGame = Runner(size: size)
                runnerGame.scaleMode = .aspectFill
                view?.presentScene(runnerGame)
                
            }
            if harvestButton?.contains(location) == true {
                // Transition to the harvest game
                let harvestGame = StartHarvest(size: size)
                harvestGame.scaleMode = .aspectFill
                view?.presentScene(harvestGame)
            }
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
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, let node = self.currentNode {
            let touchLocation = touch.location(in: self)
            node.position = touchLocation
        }
    }
    public override init(size: CGSize) {
        super.init(size: size)

        // physics world properties
        physicsWorld.gravity = CGVector(dx: 0.0, dy: -9.8)
        physicsWorld.contactDelegate = self
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //gets textures for pet
    func updatePet() -> [SKTexture]{
        var texture = [""]
        let characterTextures = texture.map { SKTexture(imageNamed: $0) }
        if(userObject.pet_choice == "cat bat"){
            texture = ["batcat_run1", "batcat_run2", "batcat_run3","batcat_run4"]
            sittingSprite = SKTexture(imageNamed: "catbat_ver2-export.png")
        }
        else if(userObject.pet_choice == "chicken hamster"){
            texture = ["chicken-hamster_run1", "chicken-hamster_run2", "chicken-hamster_run3"]
            sittingSprite = SKTexture(imageNamed: "")
        }
        return characterTextures
    }
    

    
}

struct MainGameSceneView: View {
    var body: some View {
        SpriteKitContainer(scene: MainScreen(size: UIScreen.main.bounds.size))
            .ignoresSafeArea()
    }
}

