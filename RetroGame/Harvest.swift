//
//  Harvest.swift
//  RetroGame
//
//  Created by Tsering Lhakhang on 11/28/23.
//

import SpriteKit
import GameplayKit
import CoreMotion

class Harvest: SKScene, SKPhysicsContactDelegate{
    let character = SKSpriteNode(imageNamed: "chicken-hamster")
    
    // To detect collision, bitmask category
    let characterCategory:UInt32 = 0x100
    let groundCategory:UInt32 = 0x1000
    let foodCategory:UInt32 = 0x10000
    
    let sky = SKSpriteNode(imageNamed: "NewTree")
    let ground = SKSpriteNode(imageNamed: "Grass")
    
//    var isMovingLeft = false
//    var isMovingRight = false
    var targetX: CGFloat = 0.0
    
    var foodCounter = 0
            
    override func didMove(to view: SKView){
        // Set the size of the scene
        self.size = view.bounds.size
        // constraints to keep the character within the scene
        let minX = 0.0
        let maxX = size.width - character.size.width / 2
        let minY = character.size.height / 2
        let maxY = size.height
        
        let rangeX = SKRange(lowerLimit: minX, upperLimit: maxX)
        let rangeY = SKRange(lowerLimit: minY, upperLimit: maxY)
        
        let characterConstraint = SKConstraint.positionX(rangeX, y: rangeY)

        character.constraints = [characterConstraint]
        createSky()
        createGround()
        startFoodSpawning()
        addCharacter()
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let touchLocation = touch.location(in: self)
            targetX = touchLocation.x
//            if touchLocation.x < size.width / 2 {
//                isMovingLeft = true
//            } else {
//                isMovingRight = true
//            }
        }
    }
    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        isMovingLeft = false
//        isMovingRight = false
//    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask

        if contactMask == characterCategory | foodCategory {
            if contact.bodyA.categoryBitMask == characterCategory {
                foodCollected(contact.bodyB.node as? SKSpriteNode ?? SKSpriteNode())
            } else {
                foodCollected(contact.bodyA.node as? SKSpriteNode ?? SKSpriteNode())
            }
        }
    }

    override func update(_ currentTime: TimeInterval){
        character.constraints?.forEach { $0.referenceNode?.position = character.position }
//        if isMovingLeft {
//            character.position.x -= 8.0
//        } else if isMovingRight {
//            character.position.x += 8.0
//        }
        
        let speed: CGFloat = 8.0
        let distanceThreshold: CGFloat = 8.0
        if abs(character.position.x - targetX) > distanceThreshold {
            if character.position.x < targetX {
                character.position.x += speed
            } else if character.position.x > targetX {
                character.position.x -= speed
            }
        }
    }
    
    func characterOutOfBounds() {
        print("Character went out of bounds!")
        // Move to EndScreen

    }
    
    func createSky() {
        // Sky background
        sky.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        sky.zPosition = 0
        addChild(sky)

    }

    func createGround() {
        let groundSize = CGSize(width: ground.size.width, height: ground.size.height + 20)
        ground.physicsBody = SKPhysicsBody(texture: ground.texture!, size: groundSize)
        ground.physicsBody?.usesPreciseCollisionDetection = true
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.friction = 0.0
        ground.physicsBody?.categoryBitMask = groundCategory
        ground.physicsBody?.collisionBitMask = characterCategory
        
        ground.position = CGPoint(x: size.width * 0.5, y: ground.size.height * 0.5)
        ground.zPosition = 1
        addChild(ground)
    }

    func addCharacter() {
        let groundHeight = ground.size.height
        character.position = CGPoint(x: size.width * 0.5, y: groundHeight)
        character.zPosition = 2
        
        character.physicsBody = SKPhysicsBody(texture: character.texture!,
                                              size: character.texture!.size())
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.isDynamic = true
        character.physicsBody?.allowsRotation = false
        character.physicsBody?.categoryBitMask = characterCategory
        character.physicsBody?.collisionBitMask = groundCategory
        character.physicsBody?.contactTestBitMask = groundCategory
        
        character.physicsBody?.usesPreciseCollisionDetection = true
        addChild(character)
    }
    func startFoodSpawning() {
        let spawnFoodAction = SKAction.run(spawnFood)
        let waitDuration = SKAction.wait(forDuration: 3.0)
        let sequence = SKAction.sequence([spawnFoodAction, waitDuration])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever)
    }
    
    func spawnFood() {
        let food = SKSpriteNode(imageNamed: "watermelon")
        food.name = "food"
        
        let minX = character.size.width
        let maxX = size.width - character.size.width
        let minY = size.height - character.size.height
        let maxY = size.height
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        food.position = CGPoint(x: randomX, y: randomY)
        food.zPosition = 3
        food.physicsBody = SKPhysicsBody(circleOfRadius: (food.size.width / 2)-3)
        food.physicsBody?.isDynamic = true
        food.physicsBody?.categoryBitMask = foodCategory
        food.physicsBody?.collisionBitMask = 0
        food.physicsBody?.contactTestBitMask = characterCategory
        addChild(food)
    }
    func foodCollected(_ food: SKSpriteNode) {
        updateFoodCounter(by: 1)
        food.removeFromParent()
    }

    func updateFoodCounter(by value: Int) {
        foodCounter += value
        print("Collected Food: \(foodCounter)")
    }

    
}
