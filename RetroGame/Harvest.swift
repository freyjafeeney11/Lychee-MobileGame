//
//  Harvest.swift
//  RetroGame
//
//  Created by Tsering Lhakhang on 11/28/23.
//

import SpriteKit
import GameplayKit

class Harvest: SKScene, SKPhysicsContactDelegate{
    let character = SKSpriteNode(imageNamed: "chicken-hamster")
    
    // To detect collision, bitmask category
    let characterCategory:UInt32 = 0x100
    let groundCategory:UInt32 = 0x1000
    let foodCategory:UInt32 = 0x10000
    
    let sky = SKSpriteNode(imageNamed: "NewTree")
    let ground = SKSpriteNode(imageNamed: "Grass")
    
    let backgroundVelocity1: CGFloat = 2.0
    let skyVelocity: CGFloat = 1.0
    
    let jumpForce: CGFloat = 50.0
    var isJumping = false
    
    var swipeCount = 0
    let maxSwipeCount = 3
    let forwardForce: CGFloat = 100.0
    
    let loseThresholdX: CGFloat = 0
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
        // gesture recognizer for swipes
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        view.addGestureRecognizer(swipeRight)
        
        character.constraints = [characterConstraint]
        createSky()
        createGround()
        addCharacter()
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        startFoodSpawning()
        
        // Add an initial impulse to start the constant running motion
        //character.physicsBody?.applyImpulse(CGVector(dx: 50.0, dy: 0.0))
    }
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        if sender.direction == .right && swipeCount < maxSwipeCount {
            // Apply force only if the swipe is to the right and the swipe count is within limit
            character.physicsBody?.applyForce(CGVector(dx: forwardForce, dy: 0))
            swipeCount += 1
            print("Swipe Count: \(swipeCount)")
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Check if the character is not already jumping
        if !isJumping {
            print("Jump Applied")
            character.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: jumpForce))
            isJumping = true
        }
    }

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
        if character.position.y <= sky.position.y + sky.size.height * 0.5 + character.size.height * 0.5 {
            isJumping = false
        }
        if character.position.x < loseThresholdX {
            characterOutOfBounds()
        }
        character.constraints?.forEach { $0.referenceNode?.position = character.position }
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
        
        let minX = character.position.x + 50
        let maxX = size.width - food.size.width / 2
        let minY = character.size.height + 50
        let maxY = size.height - food.size.height * 2
        
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
        // Update UI or perform any action with the collected food count here
    }

    
}
