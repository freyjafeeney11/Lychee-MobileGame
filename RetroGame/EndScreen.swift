//
//  EndScreen.swift
//  RetroGame
//
//  Created by Tsering Lhakhang on 11/26/23.
//

import SpriteKit
import GameplayKit

class EndScreen: SKScene {
    let collectedCoins: Int
    let collectedFood: [String: Int]
    let background: SKSpriteNode
    let coinLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let homeButton = SKSpriteNode(imageNamed: "Home")
    let characterType = "chicken-hamster"

    init(size: CGSize, collectedCoins: Int) {
        self.collectedCoins = collectedCoins
        self.collectedFood = [:]
        self.background = SKSpriteNode(imageNamed: "Gameover 1")
        super.init(size: size)
        setupBackground()
        setupCoinLabel()
    }
    
    init(size: CGSize, collectedFood: [String: Int]) {
        self.collectedCoins = 0
        self.collectedFood = collectedFood
        self.background = SKSpriteNode(imageNamed: "StartGame")
        super.init(size: size)
        setupBackground()
        setupParchment()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        setupHomeButton()
    }

    func setupBackground() {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        let words = SKSpriteNode(imageNamed: "gameover_words")
        words.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        words.zPosition = 1
        addChild(words)
        
    }

    func setupParchment() {
        let parchment = SKSpriteNode(imageNamed: "parchment2")
        parchment.position = CGPoint(x: size.width * 0.5, y: size.height * 0.4)
        parchment.zPosition = 1
        addChild(parchment)
        if let collectedFoodForCharacter = foodReqs.characterFoodReq[characterType] {
            print("Food Harvested for \(characterType):")
            
            for (foodType, requiredCount) in collectedFoodForCharacter {
                if let collectedCount = collectedFood[foodType] {
                    print("\(foodType): \(collectedCount)/\(requiredCount)")
                }
            }
        }
    }
    func setupCoinLabel() {
        coinLabel.text = "\(collectedCoins) coins"
        coinLabel.fontSize = 30
        coinLabel.position = CGPoint(x: size.width * 0.4, y: size.height * 0.55)
        addChild(coinLabel)
    }

    func setupHomeButton() {
        // Resize the home button
        let buttonSize = CGSize(width: 50, height: 50)
        homeButton.size = buttonSize
        
        homeButton.position = CGPoint(x: size.width * 0.6, y: size.height * 0.6)
        addChild(homeButton)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            if homeButton.contains(location) {
                // Transition to the home scene
                let homeScene = MainScreen(size: size)
                homeScene.scaleMode = .aspectFill
                view?.presentScene(homeScene)
            }
        }
    }
}
