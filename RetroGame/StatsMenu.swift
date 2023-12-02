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
    
    var health = Levels()
    var hunger: SKSpriteNode?
    var social: SKSpriteNode?
    var hygiene: SKSpriteNode?
    var energy: SKSpriteNode?
    var happiness: SKSpriteNode?
    override func didMove(to view: SKView) {
        
        
        updateLevels()
        
        hunger!.position = CGPoint(x: 200, y: 350)
        happiness!.position = CGPoint(x: 100, y: 310)
        hygiene!.position = CGPoint(x: 100, y: 270)
        energy!.position = CGPoint(x: 250, y: 350)
        social!.position = CGPoint(x: 250, y: 310)

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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            
            
              
        }
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
