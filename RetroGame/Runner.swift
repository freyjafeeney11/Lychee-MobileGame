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
    let coinCategory:UInt32 = 0x10000
    
    let cityFront = SKSpriteNode(imageNamed: "frontbuilding")
    let cityFront2 = SKSpriteNode(imageNamed: "frontbuilding")
    let cityFront3 = SKSpriteNode(imageNamed: "frontbuilding")
    
    let sky = SKSpriteNode(imageNamed: "background")
    let sky2 = SKSpriteNode(imageNamed: "background")
    let sky3 = SKSpriteNode(imageNamed: "background")
    
    let backgroundVelocity1: CGFloat = 2.0
    let skyVelocity: CGFloat = 1.0
    
    let jumpForce: CGFloat = 50.0
    var isJumping = false
    
    let loseThresholdX: CGFloat = 0
            
    override func didMove(to view: SKView){
        // Set the size of the scene
        self.size = view.bounds.size
        // constraints to keep the character within the scene
        let minX = -20.0
        print("minX: ", minX)
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
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        addCityCollision()
        startCoinSpawning()
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
        // Checking if the character goes beyond min X
        if character.position.x < loseThresholdX {
            characterOutOfBounds()
        }
        // Ensure the character stays within the constraints
        character.constraints?.forEach { $0.referenceNode?.position = character.position }

    }
    
    func characterOutOfBounds() {
        print("Character went out of bounds!")
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
        cityFront.physicsBody = SKPhysicsBody(texture: cityFront.texture!,
                                              size: cityFront.texture!.size())
        cityFront2.physicsBody = SKPhysicsBody(texture: cityFront2.texture!,
                                               size: cityFront2.texture!.size())
        cityFront3.physicsBody = SKPhysicsBody(texture: cityFront3.texture!,
                                               size: cityFront3.texture!.size())

//        let path = CGMutablePath()
//        path.addLines(between: [CGPoint(x: -10, y: -200),CGPoint(x: -10, y: -80), CGPoint(x: 40, y: -80), CGPoint(x: 40, y: -95),
//                                CGPoint(x: 180, y: -95), CGPoint(x: 180, y: -75), CGPoint(x: 280, y: -75),
//                                CGPoint(x: 280, y: -70), CGPoint(x: 370, y: -70), CGPoint(x: 370, y: -200),
//                                CGPoint(x: 410, y: -200), CGPoint(x: 410, y: -80), CGPoint(x: 490, y: -80),
//                                CGPoint(x: 490, y: -95), CGPoint(x: 600, y: -95), CGPoint(x: 600, y: -70),
//                                CGPoint(x: 700, y: -70), CGPoint(x: 700, y: -55), CGPoint(x: 810, y: -55),
//                                CGPoint(x: 810, y: -55), CGPoint(x: 810, y: -80), CGPoint(x: 850, y: -80),
//                                CGPoint(x: 850, y: -200)])
//        path.closeSubpath()
//        cityFront.physicsBody = SKPhysicsBody(polygonFrom: path)
//        cityFront2.physicsBody = SKPhysicsBody(polygonFrom: path)
//        cityFront3.physicsBody = SKPhysicsBody(polygonFrom: path)
        
        cityFront.physicsBody?.usesPreciseCollisionDetection = true
        cityFront2.physicsBody?.usesPreciseCollisionDetection = true
        cityFront3.physicsBody?.usesPreciseCollisionDetection = true
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

        character.physicsBody = SKPhysicsBody(texture: character.texture!,
                                               size: character.texture!.size())
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.isDynamic = true
        character.physicsBody?.allowsRotation = false
        character.physicsBody?.categoryBitMask = characterCategory
        character.physicsBody?.collisionBitMask = groundCategory
        character.physicsBody?.usesPreciseCollisionDetection = true
        print("Character Added!")
        addChild(character)
        print("Character Initial Position: \(character.position)")
    }
    func startCoinSpawning() {
        let spawnCoinAction = SKAction.run(spawnCoin)
        let waitDuration = SKAction.wait(forDuration: 3.0) // Adjust this interval
        let sequence = SKAction.sequence([spawnCoinAction, waitDuration])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever)
    }
    
    func spawnCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        // Define the range within which you want to spawn the coins
        let minX = coin.size.width / 2
        let maxX = size.width - coin.size.width / 2
        let minY = character.size.height + 50 // Adjust this value to position coins above the buildings
        let maxY = size.height - coin.size.height / 2
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        coin.position = CGPoint(x: randomX, y: randomY)
        coin.zPosition = 2 // Ensure coins appear above other nodes
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.size)
        coin.physicsBody?.isDynamic = false // Ensure coins stay still
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.collisionBitMask = 0 // No collision with other physics bodies
        coin.physicsBody?.contactTestBitMask = characterCategory // Check for contact with the character
        addChild(coin)
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
