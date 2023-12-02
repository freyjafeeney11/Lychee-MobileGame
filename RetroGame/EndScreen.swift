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
    let background = SKSpriteNode(imageNamed: "Gameover 1")
    let coinLabel = SKLabelNode(fontNamed: "Avenir-Black ")
    let homeButton = SKSpriteNode(imageNamed: "Home")

    init(size: CGSize, collectedCoins: Int) {
        self.collectedCoins = collectedCoins
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        setupBackground()
        setupCoinLabel()
        setupHomeButton()
    }

    func setupBackground() {
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
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
