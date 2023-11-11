//
//  Runner.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 10/19/23.
//

import SpriteKit

class Runner: SKScene, SKPhysicsContactDelegate{
    
    let cityFront = SKSpriteNode(imageNamed: "frontbuilding 1")
    let cityFront2 = SKSpriteNode(imageNamed: "frontbuilding 1")
    let cityFront3 = SKSpriteNode(imageNamed: "frontbuilding 1")
    
    /*let cityBack = SKSpriteNode(imageNamed: "backbuilding 1")
    let cityBack2 = SKSpriteNode(imageNamed: "backbuilding 1")
    let cityBack3 = SKSpriteNode(imageNamed: "backbuilding 1")*/
    
    
    let sky = SKSpriteNode(imageNamed: "background")
    let sky2 = SKSpriteNode(imageNamed: "background")
    let sky3 = SKSpriteNode(imageNamed: "background")
    
    
    let backgroundVelocity1: CGFloat = 2.0
    let backgroundVelocity2: CGFloat = 1.5
    let skyVelocity: CGFloat = 1.0
    
    
    let character = SKSpriteNode(imageNamed: "chicken-hamster")
        
    override func didMove(to view: SKView){
        self.createCity()
        self.addCharacter()
        self.physicsWorld.contactDelegate = self
    }
    
    func createCity() {
        
        cityFront.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        cityFront.zPosition = 3
        self.addChild(cityFront)
        
        // Having it follow the 1st city front positioning directly after
        cityFront2.position = CGPoint(x: cityFront.position.x + cityFront.size.width, y: size.height * 0.5)
        cityFront2.zPosition = 3
        self.addChild(cityFront2)
        
        cityFront3.position = CGPoint(x: cityFront2.position.x + cityFront2.size.width, y: size.height * 0.5)
        cityFront3.zPosition = 3
        self.addChild(cityFront3)
        
        // Back buildings
        /*cityBack.position = CGPoint(x: cityFront.position.x - cityFront.size.width, y: size.height * 0.35)
        cityBack.zPosition = 2
        self.addChild(cityBack)
        
        cityBack2.position = CGPoint(x: cityFront2.position.x - cityFront2.size.width, y: size.height * 0.35)
        cityBack2.zPosition = 2
        self.addChild(cityBack2)
        
        cityBack3.position = CGPoint(x: cityFront3.position.x - cityFront3.size.width, y: size.height * 0.35)
        cityBack3.zPosition = 2
        self.addChild(cityBack3)*/
        
        // Sky background
        sky.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        self.addChild(sky)
        
        sky2.position = CGPoint(x: sky.position.x + sky.size.width, y: size.height * 0.5)
        self.addChild(sky2)
        
        sky3.position = CGPoint(x: sky2.position.x + sky2.size.width, y: size.height * 0.5)
        self.addChild(sky3)
        
    }
    func addCharacter() {
        character.position = CGPoint(x: size.width * 0.2, y: cityFront.position.y + cityFront.size.height * 0.5 + character.size.height * 0.5)
        character.zPosition = 3
        character.physicsBody = SKPhysicsBody(rectangleOf: character.size)
        character.physicsBody?.isDynamic = true
        character.physicsBody?.categoryBitMask = 1
        self.addChild(character)
    }
    
    override func update(_ currentTime: TimeInterval){
        // Update city front positions
        cityFront.position = CGPoint(x: cityFront.position.x - self.backgroundVelocity1, y: cityFront.position.y)
        cityFront2.position = CGPoint(x: cityFront2.position.x - self.backgroundVelocity1, y: cityFront2.position.y)
        cityFront3.position = CGPoint(x: cityFront3.position.x - self.backgroundVelocity1, y: cityFront3.position.y)
        /*
        cityBack.position = CGPoint(x: cityBack.position.x - self.backgroundVelocity2, y: cityBack.position.y)
        cityBack2.position = CGPoint(x: cityBack2.position.x - self.backgroundVelocity2, y: cityBack2.position.y)
        cityBack3.position = CGPoint(x: cityBack3.position.x - self.backgroundVelocity2, y: cityBack3.position.y)*/
                
        // Update sky positions
        sky.position = CGPoint(x: sky.position.x - self.skyVelocity, y: sky.position.y)
        sky2.position = CGPoint(x: sky2.position.x - self.skyVelocity, y: sky2.position.y)
        sky3.position = CGPoint(x: sky3.position.x - self.skyVelocity, y: sky3.position.y)
        
        // Reset positions for continuous scrolling
        if cityFront.position.x <= -cityFront.size.width {
            cityFront.position.x = cityFront3.position.x + cityFront3.size.width
        }
        if cityFront2.position.x <= -cityFront2.size.width {
            cityFront2.position.x = cityFront.position.x + cityFront.size.width
        }
        if cityFront3.position.x <= -cityFront3.size.width {
            cityFront3.position.x = cityFront2.position.x + cityFront2.size.width
        }

        /*if cityBack.position.x <= -cityBack.size.width {
            cityBack.position.x = cityBack2.position.x + cityBack2.size.width
        }
        if cityBack2.position.x <= -cityBack2.size.width {
            cityBack2.position.x = cityBack.position.x + cityBack.size.width
        }
        if cityBack3.position.x <= -cityBack3.size.width {
            cityBack3.position.x = cityFront3.position.x + cityFront3.size.width
        }*/
        
        // Reset sky positions for continuous scrolling
        if sky.position.x <= -sky.size.width {
            sky.position.x = sky3.position.x + sky3.size.width
        }
        if sky2.position.x <= -sky2.size.width {
            sky2.position.x = sky.position.x + sky.size.width
        }
        if sky3.position.x <= -sky3.size.width {
            sky3.position.x = sky2.position.x + sky2.size.width
        }
    }
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == 1 && contact.bodyB.categoryBitMask == 2) ||
            (contact.bodyA.categoryBitMask == 2 && contact.bodyB.categoryBitMask == 1) {
            print("Collision detected!")
        }
    }


    /*
    var cityBack = SKSpriteNode()
    let backgroundVelocity: CGFloat = 3.0
    
    override func didMove(to view: SKView){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.createCity()
    }
    
    override func update(_ currentTime: TimeInterval){
        self.moveBack()
    }
    
    func createCity(){
        for i in 0..<3{
            let cityBack = SKSpriteNode(imageNamed: "BackBuilding")
            cityBack.name = "CityBack"
            cityBack.anchorPoint = CGPoint(x: 0, y: 0)
            cityBack.position = CGPoint(x: i * Int(cityBack.size.width), y: 0)
            
            self.addChild(cityBack)
        }
    }
    
    func moveBack(){
        self.enumerateChildNodes(withName: "BackBuilding", using: {(node, stop) -> Void in
            if let back  = node as? SKSpriteNode {
                back.position = CGPoint(x: back.position.x - self.backgroundVelocity, y: back.position.y)
                
                if back.position.x <= -back.size.width {
                    back.position = CGPoint(x: back.position.x + back.size.width * 2, y: back.position.y)
                }
            }
        })
    }
     */
}
