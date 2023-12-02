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
public var shared = MainScreen()

public class MainScreen: SKScene {
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    var runnerButton: SKSpriteNode?
    var harvestButton: SKSpriteNode?
    var menuBar: SKSpriteNode?
    //var edit = EditUser()
    
    
    
    public override func didMove(to view: SKView) {
        
        
        //firebase
        
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        let player = SKSpriteNode(imageNamed: petChoice.pet)
        
        menuBar = SKSpriteNode(imageNamed: "SideMenuOpen")

        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        
        
        runnerButton = SKSpriteNode(imageNamed: "RunnerButton")
        harvestButton = SKSpriteNode(imageNamed: "foodCollectButton")
        
//        func addRandom() -> Double {
//            let randomDouble = Double.random(in: 0.9...2)
//            return randomDouble
//        }
        //walk animation
        // setting movement
        let moveDistance: CGFloat = 150.0
        let moveDuration: TimeInterval = 0.8
        
        // stay still for 5
        let wait = SKAction.wait(forDuration: 5)
        
        let moveLeft = SKAction.moveBy(x: -moveDistance, y: 0, duration: moveDuration)
        let moveRight = SKAction.moveBy(x: moveDistance, y: 0, duration: moveDuration)
        
        //setting animation
        let tex1 = SKTexture(imageNamed: "batcat_run1")
        let tex2 = SKTexture(imageNamed: "batcat_run2")
        let tex3 = SKTexture(imageNamed: "batcat_run3")
        let tex4 = SKTexture(imageNamed: "batcat_run4")
        let walking = [tex1, tex2, tex3, tex4]
        
        // change sprite to sitting when sitting
        let sittingSprite = SKTexture(imageNamed: "catbat_ver2-export.png")
        let sitAction = SKAction.setTexture(sittingSprite)
        
        // might add in an idle animation, or smth like paw licking for the cat and feathers for the chicken
        // eventually will set this to random distance + time within a limit for less repetitive movement
        
        // walking animation
        let walkingAnimation = SKAction.animate(with: walking, timePerFrame: 0.13)
        // this action plays the walking animation
        
        // try doing distance based off of count of animations, reverse
        
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
        
        //levels
        let hunger = SKSpriteNode(imageNamed: "100Hunger")
        let social = SKSpriteNode(imageNamed: "100social")
        let hygiene = SKSpriteNode(imageNamed: "100Hygiene")
        let energy = SKSpriteNode(imageNamed: "100Energy")
        let happy = SKSpriteNode(imageNamed: "100Happy")
        
        runnerButton?.position = CGPoint(x: size.width * 0.81, y: size.height * 0.65)
        harvestButton?.position = CGPoint(x: size.width * 0.137, y: size.height * 0.65)
        
        //level position
        // commented these out for levels menu instead
//        hunger.position = CGPoint(x: 100, y: 350)
//        happy.position = CGPoint(x: 100, y: 310)
//        hygiene.position = CGPoint(x: 100, y: 270)
//        energy.position = CGPoint(x: 250, y: 350)
//        social.position = CGPoint(x: 250, y: 310)
//
//        hunger.zPosition = 1
//        social.zPosition = 1
//        hygiene.zPosition = 1
//        energy.zPosition = 1
//        happy.zPosition = 1
        
        backgroundColor = SKColor.white
        room.setScale(0.58)
        runnerButton?.setScale(0.215)
        harvestButton?.setScale(1.115)
        
        //level scale
        hunger.setScale(2)
        social.setScale(2)
        hygiene.setScale(2)
        energy.setScale(2)
        happy.setScale(2)
        
        //menu
        menuBar?.setScale(0.79)
        menuBar?.position = CGPoint(x: -245, y: size.height * 0.5)
        
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.45)
        player.position = CGPoint(x: size.width * 0.45, y: size.height * 0.3)
        
        addChild(hunger)
        addChild(social)
        addChild(energy)
        addChild(hygiene)
        addChild(happy)
        addChild(room)
        addChild(player)
        addChild(runnerButton!)
        addChild(harvestButton!)
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
        }
    }
    

}

struct MainGameSceneView: View {
    var body: some View {
        SpriteKitContainer(scene: MainScreen(size: UIScreen.main.bounds.size))
            .ignoresSafeArea()
    }
}
