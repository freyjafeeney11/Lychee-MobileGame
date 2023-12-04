//
//  ChooseYourPet.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 12/3/23.
//

import Foundation
import SwiftUI
import GameplayKit
import Firebase
import _SpriteKit_SwiftUI


class ChooseYourPet: SKScene {
    var catBatEgg: SKSpriteNode?
    var chickenHamsterEgg: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let user = UserObjectManager.shared.getCurrentUser()
        //calls pet choosing screen
        let eggVendor = SKSpriteNode(imageNamed: "")
        
        eggVendor.position = CGPoint(x: size.width * 0.505, y: size.height * 0.62)
        
        eggVendor.setScale(1.03)
        
        self.addChild(eggVendor)
        
        
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches {
                let location = touch.location(in: self)
                
                if catBatEgg?.contains(location) == true {
                    user.pet_choice = "cat bat"
                    UserObjectManager.shared.updateCurrentUser(with: user)
                    EditUser().pullFromFirestore(user: user)
                }
                else if chickenHamsterEgg?.contains(location) == true {
                    user.pet_choice = "chicken hamster"
                    UserObjectManager.shared.updateCurrentUser(with: user)
                    EditUser().pullFromFirestore(user: user)
                }
            }
        }
                
                
        if(user.pet_choice != "none"){
            MainGameSceneView()
        }
    }
    
    
    
}
