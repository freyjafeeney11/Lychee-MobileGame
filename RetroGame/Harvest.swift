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
    
    let foodTypes = ["apple", "watermelon", "meat", "tuna", "corn", "pumpkin", "battery"]
    
    var collectedFood: [String: Int] = [
        "apple": 0,
        "watermelon": 0,
        "meat": 0,
        "tuna": 0,
        "corn": 0,
        "pumpkin": 0,
        "battery": 0
    ]
    let characterFoodRequirements: [String: [String: Int]] = [
        "chicken-hamster": ["apple": 2, "corn": 2, "pumpkin": 2],
        "cat-bat": ["meat": 1, "fish": 3, "watermelon": 2],
        "robot-dragon": ["meat": 2, "battery": 3, "apple": 1]
    ]
    
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
        let waitDuration = SKAction.wait(forDuration: 2.0)
        let sequence = SKAction.sequence([spawnFoodAction, waitDuration])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever)
    }
    
    func spawnFood() {
        let numberOfFruits = 4
        
        for _ in 1...numberOfFruits {
            let randomFoodIndex = Int(arc4random_uniform(UInt32(foodTypes.count)))
            let foodType = foodTypes[randomFoodIndex]
            
            let food = SKSpriteNode(imageNamed: foodType)
            food.name = foodType
            food.setScale(1.8)
            
            let minX = character.size.width
            let maxX = size.width - character.size.width
            let minY = size.height - character.size.height
            let maxY = size.height
            
            let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
            let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
            
            food.position = CGPoint(x: randomX, y: randomY)
            food.zPosition = 3
            food.physicsBody = SKPhysicsBody(circleOfRadius: (food.size.width / 2) - 3)
            food.physicsBody?.isDynamic = true
            food.physicsBody?.categoryBitMask = foodCategory
            food.physicsBody?.collisionBitMask = 0
            food.physicsBody?.contactTestBitMask = characterCategory
            addChild(food)
        }
    }

    func foodCollected(_ food: SKSpriteNode) {
        if let foodType = food.name {
            if let count = collectedFood[foodType] {
                collectedFood[foodType] = count + 1
                if let requiredCount = characterFoodRequirements["chicken-hamster"]?[foodType] {
                    print("\(foodType) collected: \(count + 1)/\(requiredCount)")
                }
            }
        }
        food.removeFromParent()
        checkFoodRequirements(for: "chicken-hamster")
    }
    
    func checkFoodRequirements(for characterType: String) {
        guard let requirements = characterFoodRequirements[characterType] else {
            print("Character requirements not found.")
            return
        }
        var requirementsMet = true
        for (foodType, requiredCount) in requirements {
            if collectedFood[foodType] ?? 0 < requiredCount {
                requirementsMet = false
            }
        }
        if requirementsMet {
            print("Character has collected all required food for \(characterType)!")
        }
    }


}
