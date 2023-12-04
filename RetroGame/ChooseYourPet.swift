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
import AVFoundation


class ChooseYourPet: SKScene {
    static var shared = ChooseYourPet()
    var catBatEgg: SKSpriteNode?
    var chickenHamsterEgg: SKSpriteNode?
    var audioPlayer: AVAudioPlayer?
    
    override func didMove(to view: SKView) {
        if let soundURL = Bundle.main.url(forResource: "The Bard's Tale", withExtension: "wav") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.prepareToPlay()
            } catch {
                print("Error loading sound file:", error.localizedDescription)
            }
        }
        //calls pet choosing screen
        var textures: [String] = []
        // load all 73 files
        for i in 1..<74 {
            textures.append("merchant\(i)")
        }
        let characterTextures = textures.map { SKTexture(imageNamed: $0) }
        
        let playCutscene = SKAction.animate(with: characterTextures, timePerFrame: 0.2)
        let playAction = SKAction.repeat(playCutscene, count : 1)
        
        // bubble sprite
        let cutScene = SKSpriteNode(imageNamed: "merchant1")
        cutScene.setScale(0.9)
        cutScene.position = CGPoint(x: size.width * 0.5, y: size.height * 0.556)
        addChild(cutScene)
        audioPlayer?.play()
        cutScene.run(playAction) {
            cutScene.removeFromParent()
            self.audioPlayer?.stop()
            let eggChoice = ChooseEgg(size: self.size)
            eggChoice.scaleMode = .aspectFill
            view.presentScene(eggChoice)
        }
    }
}
    
class ChooseEgg: SKScene {
    var catBatEgg: SKSpriteNode?
    var chickenHamsterEgg: SKSpriteNode?
    var cb: SKSpriteNode?
    var bb: SKSpriteNode?
    @State public var petString: String = ""
    
    override func didMove(to view: SKView) {
        //calls pet choosing screen
        let bg = SKSpriteNode(imageNamed: "egg_choice")
        let cb = SKSpriteNode(imageNamed: "egg_button")
        let bb = SKSpriteNode(imageNamed: "egg_button")
        bg.setScale(0.75)
        cb.setScale(1.3)
        bb.setScale(1.3)
        bg.position = CGPoint(x: size.width * 0.48, y: size.height * 0.4)
        cb.position = CGPoint(x: size.width * 0.25, y: size.height * 0.4)
        bb.position = CGPoint(x: size.width * 0.75, y: size.height * 0.4)
        addChild(bg)
        //addChild(cb)
        //addChild(bb)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let edit = EditUser()
        // get the current user from userobjmanager
        let user = UserObjectManager.shared.getCurrentUser()
        UserObjectManager.shared.updateCurrentUser(with: user)
        print(user)
        for touch in touches {
            let location = touch.location(in: self)
            
            if bb?.contains(location) == true {
                self.petString = "cat bat"
            }
            else if cb?.contains(location) == true {
                self.petString = "chicken hamster"
            }
            // this func isnt doing much
            //edit.updateUserPetChoice(user: user, petChoice: petString)
            
            let mainGameScreen = MainScreen(size: size)
            // can stop music after egg choice or before
            //ChooseYourPet().audioPlayer?.stop()
            mainGameScreen.scaleMode = .aspectFill
            view?.presentScene(mainGameScreen)
        }
    }
    // tried to make func that sets a public variable but it isn't set in time
    // for it to be passed to registration
    public func returnChoice() -> String {
        return petString
    }
}


struct ChoosePetView: View{
    @State private var showAuth = false
    var body: some View {
        SpriteKitContainer(scene: ChooseYourPet(size: UIScreen.main.bounds.size))
            .ignoresSafeArea()
    }
}


