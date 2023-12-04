//
//  StartHarvest.swift
//  RetroGame
//
//  Created by Tsering Lhakhang on 12/1/23.
//

import SpriteKit
import GameplayKit
import CoreMotion

public struct foodReqs {
    static let characterFoodReq: [String: [String: Int]] = [
        "chicken hamster": ["apple": 2, "corn": 2, "pumpkin": 2],
        "cat bat": ["meat": 1, "tuna": 3, "watermelon": 2]
    ]
}

class StartHarvest: SKScene {
    var playButton: SKSpriteNode?
    // For start screen
    let background = SKSpriteNode(imageNamed: "StartGame")
    let parchment = SKSpriteNode(imageNamed: "parchment")
    var foodNodes: [SKSpriteNode] = []
    var requirementLabels: [SKLabelNode] = []
    var isStartScreenVisible = true
    var startScreen: SKNode?
    var closeButton: SKSpriteNode?
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()
    
    override func didMove(to view: SKView) {
        setupBackground()
        animateScroll()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if playButton?.contains(location) == true {
                let harvestGame = Harvest(size: size)
                harvestGame.scaleMode = .aspectFill
                view?.presentScene(harvestGame)
                
            }
        }
        
    }
    
    func setupBackground() {
        background.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        background.zPosition = 0
        addChild(background)
    }
    
    func animateScroll() {
        let scrollImgs = ["parchment6", "parchment6", "parchment5", "parchment4", "parchment3", "parchment2", "parchment1"]
        let scrollTextures = scrollImgs.map { SKTexture(imageNamed: $0) }
        let openScroll = SKAction.animate(with: scrollTextures,
                                                 timePerFrame: 0.1)
        parchment.run(openScroll)
        parchment.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        parchment.zPosition = 1
        addChild(parchment)
        print(mostRecentUser.pet_choice)
        showRequirments(for: mostRecentUser.pet_choice)
    }
    
    func showRequirments(for characterType: String) {
        // Add food images and their requirements
        var yPosition: CGFloat = size.height - 120
        
        if let requirements = foodReqs.characterFoodReq[characterType] {
            for (foodType, requiredCount) in requirements {
                let foodNode = SKSpriteNode(imageNamed: foodType)
                foodNode.position = CGPoint(x: size.width * 0.4 , y: yPosition)
                foodNode.zPosition = 2
                foodNode.setScale(2)
                addChild(foodNode)
                foodNodes.append(foodNode)
                
                // Add text with food requirements
                let foodRequirementLabel = SKLabelNode(text: "x\(requiredCount)")
                foodRequirementLabel.position = CGPoint(x: size.width / 2 + 50, y: yPosition - 20)
                foodRequirementLabel.zPosition = 2
                foodRequirementLabel.fontName = "Futura"
                foodRequirementLabel.fontColor = .brown
                addChild(foodRequirementLabel)
                requirementLabels.append(foodRequirementLabel)
                yPosition -= 50
                
            }
        }
        
        playButton = SKSpriteNode(imageNamed: "PlayButton")
        playButton?.position = CGPoint(x: size.width / 2, y: 50)
        playButton?.setScale(1.8)
        addChild(playButton!)
    }
    
}

