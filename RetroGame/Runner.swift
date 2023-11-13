//
//  GameScene.swift
//  Runner
//
//  Created by Tsering Lhakhang on 10/29/23.
//

import SpriteKit
import GameplayKit

class Runner: SKScene, SKPhysicsContactDelegate{
    let character = SKSpriteNode(imageNamed: "chicken-hamster")
    
    // To detect collision, bitmask category
    let characterCategory:UInt32 = 0x100
    let groundCategory:UInt32 = 0x1000
    
    let cityFront = SKSpriteNode(imageNamed: "frontbuilding 1")
    let cityFront2 = SKSpriteNode(imageNamed: "frontbuilding 1")
    let cityFront3 = SKSpriteNode(imageNamed: "frontbuilding 1")
    
    let sky = SKSpriteNode(imageNamed: "background")
    let sky2 = SKSpriteNode(imageNamed: "background")
    let sky3 = SKSpriteNode(imageNamed: "background")
    
    let backgroundVelocity1: CGFloat = 2.0
    let skyVelocity: CGFloat = 1.0
    
    let jumpForce: CGFloat = 50.0
    var isJumping = false
            
    override func didMove(to view: SKView){
        // Set the size of the scene
        self.size = view.bounds.size
        
        // Set up constraints to keep the character within the scene
        let minX = character.size.width / 2
        let maxX = size.width - character.size.width / 2
        let minY = character.size.height / 2
        let maxY = size.height
        
        let rangeX = SKRange(lowerLimit: minX, upperLimit: maxX)
        let rangeY = SKRange(lowerLimit: minY, upperLimit: maxY)
        
        let characterConstraint = SKConstraint.positionX(rangeX, y: rangeY)
        character.constraints = [characterConstraint]
        createSky()
        createCity()
        addCharacter()
        physicsWorld.contactDelegate = self
        addCityCollision()
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        // Add an initial impulse to start the constant running motion
        //character.physicsBody?.applyImpulse(CGVector(dx: 50.0, dy: 0.0))
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Check if the character is not already jumping
        if !isJumping {
            print("Jump Applied")
            character.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: jumpForce))
            isJumping = true
        }
    }
    override func update(_ currentTime: TimeInterval){
        updateSky()
        updateCity()
        if character.position.y <= cityFront.position.y + cityFront.size.height * 0.5 + character.size.height * 0.5 {
            isJumping = false
        }
        // Ensure the character stays within the constraints
        character.constraints?.forEach { $0.referenceNode?.position = character.position }

    }
    
    func createSky() {
        // Sky background
        sky.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        sky.zPosition = 0
        addChild(sky)
        
        sky2.position = CGPoint(x: sky.position.x + sky.size.width, y: size.height * 0.5)
        sky2.zPosition = 0
        addChild(sky2)
        
        sky3.position = CGPoint(x: sky2.position.x + sky2.size.width, y: size.height * 0.5)
        sky3.zPosition = 0
        addChild(sky3)
    }
    
    func createCity() {
        // City buildings
        addCityCollision()
        cityFront.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        cityFront.zPosition = 1
        addChild(cityFront)
        
        // Having it follow the 1st city front positioning directly after
        cityFront2.position = CGPoint(x: cityFront.position.x + cityFront.size.width, y: size.height * 0.5)
        cityFront2.zPosition = 1
        addChild(cityFront2)
        
        cityFront3.position = CGPoint(x: cityFront2.position.x + cityFront2.size.width, y: size.height * 0.5)
        cityFront3.zPosition = 1
        addChild(cityFront3)
        
    }
    
    func addCityCollision() {
//        let cityHeight = cityFront.size.height/3
//        let cityWidth = frame.size.width * 3
//        cityFront.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cityWidth, height: cityHeight))
//        cityFront2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cityWidth, height: cityHeight))
//        cityFront3.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: cityWidth, height: cityHeight))
        cityFront.physicsBody = SKPhysicsBody(texture: cityFront.texture!,
                                              alphaThreshold: 0.7,
                                              size: cityFront.texture!.size())
        cityFront2.physicsBody = SKPhysicsBody(texture: cityFront2.texture!,
                                               alphaThreshold: 0.7,
                                               size: cityFront2.texture!.size())
        cityFront3.physicsBody = SKPhysicsBody(texture: cityFront3.texture!,
                                               alphaThreshold: 0.7,
                                               size: cityFront3.texture!.size())

        cityFront.physicsBody?.isDynamic = false
        cityFront2.physicsBody?.isDynamic = false
        cityFront3.physicsBody?.isDynamic = false
        
        cityFront.physicsBody?.friction = 0.0
        cityFront2.physicsBody?.friction = 0.0
        cityFront3.physicsBody?.friction = 0.0
        
        cityFront.physicsBody?.categoryBitMask = groundCategory
        cityFront2.physicsBody?.categoryBitMask = groundCategory
        cityFront3.physicsBody?.categoryBitMask = groundCategory
        
        cityFront.physicsBody?.collisionBitMask = characterCategory
        cityFront2.physicsBody?.collisionBitMask = characterCategory
        cityFront3.physicsBody?.collisionBitMask = characterCategory

    }
    
    func addCharacter() {
        character.position = CGPoint(x: size.width * 0.5, y: cityFront.size.height)
        character.zPosition = 3
        //character.physicsBody = SKPhysicsBody(rectangleOf: character.size)
        character.physicsBody = SKPhysicsBody(texture: character.texture!,
                                               size: character.texture!.size())
        character.physicsBody?.isDynamic = true
        character.physicsBody?.allowsRotation = false
        character.physicsBody?.categoryBitMask = characterCategory
        character.physicsBody?.collisionBitMask = groundCategory
        print("Character Added!")
        addChild(character)
        print("Character Initial Position: \(character.position)")
    }
    
    func updateSky() {
        // Update sky positions
        sky.position = CGPoint(x: sky.position.x - skyVelocity, y: sky.position.y)
        sky2.position = CGPoint(x: sky2.position.x - skyVelocity, y: sky2.position.y)
        sky3.position = CGPoint(x: sky3.position.x - skyVelocity, y: sky3.position.y)
        
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
    
    func updateCity() {
        // Update city front positions
        cityFront.position = CGPoint(x: cityFront.position.x - backgroundVelocity1, y: cityFront.position.y)
        cityFront2.position = CGPoint(x: cityFront2.position.x - backgroundVelocity1, y: cityFront2.position.y)
        cityFront3.position = CGPoint(x: cityFront3.position.x - backgroundVelocity1, y: cityFront3.position.y)
                
        // Reset city position
        if cityFront.position.x <= -cityFront.size.width {
            cityFront.position.x = cityFront3.position.x + cityFront3.size.width
        }
        if cityFront2.position.x <= -cityFront2.size.width {
            cityFront2.position.x = cityFront.position.x + cityFront.size.width
        }
        if cityFront3.position.x <= -cityFront3.size.width {
            cityFront3.position.x = cityFront2.position.x + cityFront2.size.width
        }
    }
    
}
