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
    var foodNodes: [SKSpriteNode] = []
    var collectedFoodLabels: [SKLabelNode] = []
    
    let userObject = UserObjectManager.shared.getCurrentUser()


    //runner end scene
    init(size: CGSize, collectedCoins: Int) {
        self.collectedCoins = collectedCoins
        self.collectedFood = [:]
        self.background = SKSpriteNode(imageNamed: "Gameover 1")
        super.init(size: size)
        setupBackground()
        setupCoinLabel()
        setupHomeButtonTop()
    }
    
    //harvest end scene
    init(size: CGSize, collectedFood: [String: Int], health: Int) {
        self.collectedCoins = 0
        self.collectedFood = collectedFood
        self.background = SKSpriteNode(imageNamed: "StartGame")
        super.init(size: size)
        setupBackground()
        setupFoodLabel()
        setupHomeButtonBottom()
        EditUser().harvert_game(user: userObject, food: health)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupBackground() {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        let words = SKSpriteNode(imageNamed: "gameover_words")
        words.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        words.zPosition = 1
        addChild(words)
        
    }

    func setupFoodLabel() {
        let parchment = SKSpriteNode(imageNamed: "parchment2")
        parchment.position = CGPoint(x: size.width * 0.5, y: size.height * 0.45)
        parchment.zPosition = 1
        addChild(parchment)
        
        var yPosition: CGFloat = size.height - 150
        if let collectedFoodForCharacter = foodReqs.characterFoodReq[characterType] {
            print("Food Harvested for \(characterType):")
            
            for (foodType, requiredCount) in collectedFoodForCharacter {
                if let collectedCount = collectedFood[foodType] {
                    let foodNode = SKSpriteNode(imageNamed: foodType)
                    foodNode.position = CGPoint(x: size.width * 0.4 , y: yPosition)
                    foodNode.zPosition = 2
                    foodNode.setScale(1.8)
                    addChild(foodNode)
                    foodNodes.append(foodNode)
                    
                    let foodEatenLabel = SKLabelNode(text: "\(collectedCount)/\(requiredCount)")
                    foodEatenLabel.position = CGPoint(x: size.width / 2 + 50, y: yPosition - 16)
                    foodEatenLabel.zPosition = 2
                    foodEatenLabel.fontName = "Futura"
                    foodEatenLabel.fontSize = 24
                    foodEatenLabel.fontColor = .brown
                    addChild(foodEatenLabel)
                    collectedFoodLabels.append(foodEatenLabel)
                    yPosition -= 50
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

    func setupHomeButtonTop() {
        // Resize the home button
        let buttonSize = CGSize(width: 50, height: 50)
        homeButton.size = buttonSize
        homeButton.position = CGPoint(x: size.width * 0.6, y: size.height * 0.6)
        addChild(homeButton)
    }
    func setupHomeButtonBottom() {
        let buttonSize = CGSize(width: 50, height: 50)
        homeButton.size = buttonSize
        homeButton.position = CGPoint(x: size.width * 0.5, y: size.height * 0.15)
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
