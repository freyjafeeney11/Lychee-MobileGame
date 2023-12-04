//
//  StatsMenu.swift
//  RetroGame
//
//  Created by Chase on 11/30/23.
//

import SpriteKit
import Foundation
import SwiftUI
import GameplayKit

class StatsMenu: SKScene {
    
    let backButton = SKLabelNode(fontNamed: "Futura")
    
    let edit = EditUser()
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()

    var health = Levels()
    var hunger: SKSpriteNode?
    var social: SKSpriteNode?
    var hygiene: SKSpriteNode?
    var energy: SKSpriteNode?
    var happiness: SKSpriteNode?
    override func didMove(to view: SKView) {
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let statsMenu = SKSpriteNode(imageNamed: "HealthMenu")
        
        room.setScale(0.559)
        statsMenu.setScale(0.95)
        room.position = CGPoint(x: size.width * 0.4956, y: size.height * 0.465)
        statsMenu.position = CGPoint(x: size.width * 0.47, y: size.height * 0.5)
    
        addChild(room)
        addChild(statsMenu)
        
        setupBackButton()
        
        updateLevels()
        
        hunger!.position = CGPoint(x: 175, y: 200)
        happiness!.position = CGPoint(x: 175, y: 320)
        hygiene!.position = CGPoint(x: 175, y: 260)
        energy!.position = CGPoint(x: 175, y: 140)
        social!.position = CGPoint(x: 175, y: 80)

        hunger!.setScale(0.5)
        social!.setScale(0.5)
        hygiene!.setScale(0.5)
        energy!.setScale(0.5)
        happiness!.setScale(0.5)
        
        addChild(hunger!)
        addChild(social!)
        addChild(energy!)
        addChild(hygiene!)
        addChild(happiness!)
        
        setupMessageBoard()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if backButton.contains(location) == true {
                let menu = SideMenu(size: size)
                menu.scaleMode = .aspectFill
                view?.presentScene(menu)
            }
            
              
        }
    }
    func setupMessageBoard(){
        
        let topMessage = SKLabelNode(fontNamed: "Chalkduster")
        topMessage.text = "\(mostRecentUser.name) is..."
        topMessage.fontSize = 21
        topMessage.position = CGPoint(x: size.width * 0.62, y: size.height * 0.78)
        addChild(topMessage)
        
        let underline = SKLabelNode(fontNamed: "Chalkduster")
        underline.text = "__________________"
        underline.fontSize = 21
        underline.position = CGPoint(x: size.width * 0.62, y: size.height * 0.76)
        addChild(underline)

        let happyMessage = SKLabelNode(fontNamed: "Chalkduster")
        switch health.happiness{
        case ..<30:
            happyMessage.text = "Depressed: How dare you!"
        case 31...60:
            happyMessage.text = "Bored: Do something fun."
        case 61...90:
            happyMessage.text = "Joy: A slice of delightment."
        default:
            happyMessage.text = "Elated: Couldnt be happier."
        }
        happyMessage.fontSize = 17
        happyMessage.horizontalAlignmentMode = .left
        happyMessage.position = CGPoint(x: size.width * 0.45, y: size.height * 0.703)
        addChild(happyMessage)
        
        let hygieneMessage = SKLabelNode(fontNamed: "Chalkduster")
        switch health.hygiene{
        case ..<30:
            hygieneMessage.text = "Filthy: Go wash up stinky!"
        case 31...60:
            hygieneMessage.text = "Dishevled: Bed head, haha."
        case 61...90:
            hygieneMessage.text = "Cleanly: Looking fresh."
        default:
            hygieneMessage.text = "Poised: Immaculate looks."
        }
        hygieneMessage.fontSize = 17
        hygieneMessage.horizontalAlignmentMode = .left
        hygieneMessage.position = CGPoint(x: size.width * 0.45, y: size.height * 0.642)
        addChild(hygieneMessage)
        
        let hungerMessage = SKLabelNode(fontNamed: "Chalkduster")
        switch health.hunger{
        case ..<30:
            hungerMessage.text = "Starving: Just skin and bones!"
        case 31...60:
            hungerMessage.text = "Hungry: *gurgle* *rumble*."
        case 61...90:
            hungerMessage.text = "Satiated: Satisfactorly full."
        default:
            hungerMessage.text = "Stuffed: Look at this turkey!"
        }
        hungerMessage.fontSize = 17
        hungerMessage.horizontalAlignmentMode = .left
        hungerMessage.position = CGPoint(x: size.width * 0.45, y: size.height * 0.581)
        addChild(hungerMessage)
        
        let energyMessage = SKLabelNode(fontNamed: "Chalkduster")
        switch health.energy{
        case ..<30:
            energyMessage.text = "Exhausted: Its time to sleep."
        case 31...60:
            energyMessage.text = "Drowsy: Naps are refreshing."
        case 61...90:
            energyMessage.text = "Motivated: So much to do."
        default:
            energyMessage.text = "Energized: ZOOOMIEESSSS!!!"
        }
        energyMessage.fontSize = 17
        energyMessage.horizontalAlignmentMode = .left
        energyMessage.position = CGPoint(x: size.width * 0.45, y: size.height * 0.52)
        addChild(energyMessage)
        
        let socialMessage = SKLabelNode(fontNamed: "Chalkduster")
        switch health.social{
        case ..<30:
            socialMessage.text = "Isolated: Company is needed."
        case 31...60:
            socialMessage.text = "Lonely: Socialize a bit?"
        case 61...90:
            socialMessage.text = "Social: Company is nice."
        default:
            socialMessage.text = "Loved: Glowing with it."
        }
        socialMessage.fontSize = 17
        socialMessage.horizontalAlignmentMode = .left
        socialMessage.position = CGPoint(x: size.width * 0.45, y: size.height * 0.459)
        addChild(socialMessage)
    }
    
    
    func setupBackButton() {
        backButton.text = "Return to Menu"
        backButton.fontSize = 19
        backButton.position = CGPoint(x: size.width * 0.645, y: size.height * 0.199)
        addChild(backButton)
    }
    
    func updateLevels(){

        //energy
        print("updating levels")
        print("energy \(health.energy)")
        print("social \(health.social)")
        print("happiness \(health.happiness)")
        print("hunger \(health.hunger)")
        
        switch health.energy{
        case ..<19:
            energy = SKSpriteNode(imageNamed: "10Energy")
            print("low energy")
        case 20...34:
            energy = SKSpriteNode(imageNamed: "20Energy")
        case 35...49:
            energy = SKSpriteNode(imageNamed: "35Energy")
        case 50...64:
            energy = SKSpriteNode(imageNamed: "50Energy")
        case 65...79:
            energy = SKSpriteNode(imageNamed: "65Energy")
        case 80...90:
            energy = SKSpriteNode(imageNamed: "80Energy")
        default:
            energy = SKSpriteNode(imageNamed: "100Energy")
        }

        //social
        switch health.social{
        case ..<19:
            social = SKSpriteNode(imageNamed: "10social")
        case 20...34:
            social = SKSpriteNode(imageNamed: "20social")
        case 35...49:
            social = SKSpriteNode(imageNamed: "35social")
        case 50...64:
            social = SKSpriteNode(imageNamed: "50social")
        case 65...79:
            social = SKSpriteNode(imageNamed: "65social")
        case 80...90:
            social = SKSpriteNode(imageNamed: "80social")
        default:
            social = SKSpriteNode(imageNamed: "100social")
        }

        //hunger
        switch health.hunger{
        case ..<19:
            hunger = SKSpriteNode(imageNamed: "10Hunger")
        case 20...34:
            hunger = SKSpriteNode(imageNamed: "20Hunger")
        case 35...49:
            hunger = SKSpriteNode(imageNamed: "35Hunger")
        case 50...64:
            hunger = SKSpriteNode(imageNamed: "50Hunger")
        case 65...79:
            hunger = SKSpriteNode(imageNamed: "65Hunger")
        case 80...90:
            hunger = SKSpriteNode(imageNamed: "80Hunger")
        default:
            hunger = SKSpriteNode(imageNamed: "100Hunger")
        }

        
        //happiness
        switch health.happiness{
        case ..<19:
            happiness = SKSpriteNode(imageNamed: "10Happy")
        case 20...34:
            happiness = SKSpriteNode(imageNamed: "20Happy")
        case 35...49:
            happiness = SKSpriteNode(imageNamed: "35Happy")
        case 50...64:
            happiness = SKSpriteNode(imageNamed: "50Happy")
        case 65...79:
            happiness = SKSpriteNode(imageNamed: "65Happy")
        case 80...90:
            happiness = SKSpriteNode(imageNamed: "800Happy")
        default:
            happiness = SKSpriteNode(imageNamed: "100Happy")
        }

        //hygiene
        switch health.hygiene{
        case ..<19:
            hygiene = SKSpriteNode(imageNamed: "10Hygiene")
        case 20...34:
            hygiene = SKSpriteNode(imageNamed: "20Hygiene")
        case 35...49:
            hygiene = SKSpriteNode(imageNamed: "35Hygiene")
        case 50...64:
            hygiene = SKSpriteNode(imageNamed: "50Hygiene")
        case 65...79:
            hygiene = SKSpriteNode(imageNamed: "65Hygiene")
        case 80...90:
            hygiene = SKSpriteNode(imageNamed: "80Hygiene")
        default:
            hygiene = SKSpriteNode(imageNamed: "100Hygiene")
        }
    }
}
