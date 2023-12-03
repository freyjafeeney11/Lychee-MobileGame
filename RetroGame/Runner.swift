//
//  GameScene.swift
//  Runner
//
//  Created by Tsering Lhakhang on 10/29/23.
//

import SpriteKit
import GameplayKit

class Runner: SKScene, SKPhysicsContactDelegate{
    let edit = EditUser()
    //let character = SKSpriteNode(imageNamed: "chicken-hamster")
    let character = SKSpriteNode(imageNamed: "mini_chicken-hamster_run1")
    //    var character = SKSpriteNode()
    //    var runningTextures = [SKTexture]()
    //    var currentFrame = 0
    
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
    
    //Jumping mech
    let jumpForce: CGFloat = 70.0
    var isJumping = false
    var canJump = true
    
    // Game over mech
    let loseThresholdX: CGFloat = 0.0
    var coinCounter = 0
    let coinsound = SKAction.playSoundFileNamed("coin_collect.wav", waitForCompletion: false)
    
    var gameTimer: Timer?
    let gameDuration: TimeInterval = 30
    var elapsedTime: TimeInterval = 0
    var timerLabel: SKLabelNode!
    
    //call edituser to update coins
    //var edit = EditUser()
    //var runner_user = editUser.new_update
    
    //have to either call firebase each time and get userData and update or have
    //object that does this
    
    override func didMove(to view: SKView){
        view.showsPhysics = true
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
        updateCharacterTextures()
        //addCharacter()
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: -5.0)
        addCityCollision()
        startCoinSpawning()
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timerLabel = SKLabelNode(fontNamed: "Arial")
        timerLabel.text = "Time: \(Int(gameDuration - elapsedTime))s"
        timerLabel.fontSize = 24
        timerLabel.position = CGPoint(x: size.width * 0.1, y: size.height - 50)
        addChild(timerLabel)
    }
    
    @objc func updateTimer() {
        elapsedTime += 1
        let remainingTime = max(gameDuration - elapsedTime, 0)
        timerLabel.text = "Time: \(Int(remainingTime))s"
        
        if elapsedTime >= gameDuration {
            print("Game over! Time's up.")
            handleGameEnd()
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // Check if the character is not already jumping
        if !isJumping && canJump {
            if character.position.y <= cityFront.position.y + cityFront.size.height * 0.5 + character.size.height * 0.5 {
                print("Jump Applied")
                character.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: jumpForce))
                isJumping = true
                canJump = false // Disable jumping temporarily
            }
        }
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        // Check if character in contact with ground
        if contactMask == characterCategory | groundCategory {
            isJumping = false // Reset the jumping state when landing on the ground
            canJump = true
        }
        if contactMask == characterCategory | coinCategory {
            if contact.bodyA.categoryBitMask == characterCategory {
                coinCollected(contact.bodyB.node as? SKSpriteNode ?? SKSpriteNode())
            } else {
                coinCollected(contact.bodyA.node as? SKSpriteNode ?? SKSpriteNode())
            }
        }
    }
    
    
    override func update(_ currentTime: TimeInterval){
        updateSky()
        updateCity()
        if character.position.y <= cityFront.position.y + cityFront.size.height * 0.5 + character.size.height * 0.5 {
            isJumping = false
        }
        if character.position.x < loseThresholdX {
            print("Game Over! Character went out of bounds.")
            handleGameEnd()
        }
        character.constraints?.forEach { $0.referenceNode?.position = character.position }
        enumerateChildNodes(withName: "coin") { node, _ in
            if let coin = node as? SKSpriteNode {
                // Move the coins to the left
                coin.position.x -= self.backgroundVelocity1
                
                // Remove the coin if it's off the screen
                if coin.position.x < -coin.size.width / 2 {
                    coin.removeFromParent()
                }
            }
        }
    }
    
    func handleGameEnd() {
        // get the current user from userobjmanager
        let user = UserObjectManager.shared.currentUser
        gameTimer?.invalidate()
        if let skView = self.view {
            let endScene = EndScreen(size: self.size, collectedCoins: coinCounter)
            endScene.scaleMode = .aspectFill
            skView.presentScene(endScene)
            print("Username is: \(user!.name)")
            print("\nNum of coins is: \(user!.coins)")
            edit.runner_levels(coins: coinCounter)
            print("Username2 is: \(user!.name)")
            print("\n2Num of coins is: \(user!.coins)")
            
        }
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
        character.position = CGPoint(x: size.width * 0.6, y: cityFront.size.height+20.0)
        character.zPosition = 2
        
        character.physicsBody = SKPhysicsBody(rectangleOf: character.size)
        character.physicsBody?.affectedByGravity = true
        character.physicsBody?.isDynamic = true
        character.physicsBody?.allowsRotation = false
        character.physicsBody?.categoryBitMask = characterCategory
        character.physicsBody?.collisionBitMask = groundCategory
        character.physicsBody?.contactTestBitMask = groundCategory // Detect contact with buildings
        
        character.physicsBody?.usesPreciseCollisionDetection = true
        print("Character Added!")
        addChild(character)
        print("Character Initial Position: \(character.position)")
    }
    
    func updateCharacterTextures() {
        //            let textures = ["mini_batcat_run1", "mini_batcat_run2", "mini_batcat_run3", "mini_batcat_run4"]
        let textures = ["mini_chicken-hamster_run1", "mini_chicken-hamster_run2", "mini_chicken-hamster_run3"]
        let characterTextures = textures.map { SKTexture(imageNamed: $0) }
        
        let animateAction = SKAction.animate(with: characterTextures, timePerFrame: 0.1)
        character.run(SKAction.repeatForever(animateAction), withKey: "runningAnimation")
    }
    
    //    func loadRunningAnimationTextures() -> [SKTexture] {
    //        let runImages = ["mini_batcat_run1", "mini_batcat_run2", "mini_batcat_run3", "mini_batcat_run4"]
    //        let textures = runImages.map { SKTexture(imageNamed: $0) }
    //        return textures
    //    }
    //
    //    func updateCharacterPhysics() {
    //        guard currentFrame < runningTextures.count else { return }
    //
    //        let currentTexture = runningTextures[currentFrame]
    //        character.physicsBody = SKPhysicsBody(texture: currentTexture, size: currentTexture.size())
    //        character.physicsBody?.affectedByGravity = true
    //        character.physicsBody?.isDynamic = true
    //        character.physicsBody?.allowsRotation = false
    //        character.physicsBody?.categoryBitMask = characterCategory
    //        character.physicsBody?.collisionBitMask = groundCategory
    //        character.physicsBody?.contactTestBitMask = groundCategory
    //        character.physicsBody?.usesPreciseCollisionDetection = true
    //        character.zPosition = 2
    //
    //    }
    //
    //    func updateRunningAnimation() {
    //        guard currentFrame < runningTextures.count else { return }
    //
    //        let currentTexture = runningTextures[currentFrame]
    //        character.texture = currentTexture
    //        updateCharacterPhysics()
    //
    //        currentFrame = (currentFrame + 1) % runningTextures.count
    //    }
    //
    //    func addCharacter() {
    //        runningTextures = loadRunningAnimationTextures()
    //        // Set initial character texture and physics body
    //        character = SKSpriteNode(texture: runningTextures[0])
    //        character.position = CGPoint(x: size.width / 2, y: size.height / 2)
    //        addChild(character)
    //
    //        updateCharacterPhysics()
    //
    //        // Start the animation loop
    //        run(SKAction.repeatForever(SKAction.sequence([
    //            SKAction.run(updateRunningAnimation),
    //            SKAction.wait(forDuration: 0.1)
    //        ])))
    //    }
    
    func startCoinSpawning() {
        let spawnCoinAction = SKAction.run(spawnCoin)
        let waitDuration = SKAction.wait(forDuration: 3.0)
        let sequence = SKAction.sequence([spawnCoinAction, waitDuration])
        let repeatForever = SKAction.repeatForever(sequence)
        
        run(repeatForever)
    }
    
    func spawnCoin() {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.name = "coin"
        
        let minX = character.position.x + 50
        let maxX = size.width - coin.size.width / 2
        let minY = character.size.height + 80
        let maxY = size.height - coin.size.height * 2
        
        let randomX = CGFloat(arc4random_uniform(UInt32(maxX - minX))) + minX
        let randomY = CGFloat(arc4random_uniform(UInt32(maxY - minY))) + minY
        
        coin.position = CGPoint(x: randomX, y: randomY)
        coin.zPosition = 3
        coin.physicsBody = SKPhysicsBody(circleOfRadius: (coin.size.width / 2)-3)
        coin.physicsBody?.isDynamic = false
        coin.physicsBody?.categoryBitMask = coinCategory
        coin.physicsBody?.collisionBitMask = 0
        coin.physicsBody?.contactTestBitMask = characterCategory
        addChild(coin)
    }
    func coinCollected(_ coin: SKSpriteNode) {
        updateCoinCounter(by: 1)
        run(coinsound)
        coin.removeFromParent()
    }
    
    func updateCoinCounter(by value: Int) {
        coinCounter += value
        print("Collected Coins: \(coinCounter)")
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
