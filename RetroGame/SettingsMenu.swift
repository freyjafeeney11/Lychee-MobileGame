//
//  SettingsMenu.swift
//  RetroGame
//
//  Created by Chase on 11/21/23.
//

import SpriteKit
import Foundation
import SwiftUI
import GameplayKit

class SettingsMenu: SKScene {
    
    var toggleMusic: SKSpriteNode?
    var seePass: SKSpriteNode?
    var returnToMenu: SKSpriteNode?
    
    let backButton = SKLabelNode(fontNamed: "Avenir-Black ")
    let setting = SKLabelNode(fontNamed: "Avenir-Balck ")
    let username = SKLabelNode(fontNamed: "Avenir-Black ")
    let password = SKLabelNode(fontNamed: "Avenir-Black ")
    let petname = SKLabelNode(fontNamed: "Avenir-Black ")
    let changePetName = SKLabelNode(fontNamed: "Avenir-Black ")
    let music = SKLabelNode(fontNamed: "Avenir-Black ")
    
    @State private var showPass = false

    override func didMove(to view: SKView) {
        
        
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let settingsMenu = SKSpriteNode(imageNamed: "SettingsMenu")
        toggleMusic = SKSpriteNode(imageNamed: "MusicOnButton")
        seePass = SKSpriteNode(imageNamed: "HidePassButton")
        
        room.setScale(0.85)
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        settingsMenu.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        toggleMusic?.position = CGPoint(x: size.width * 0.67, y: size.height * 0.37)
        seePass?.position = CGPoint(x: size.width * 0.75, y: size.height * 0.51)

        addChild(room)
        addChild(settingsMenu)
        addChild(toggleMusic!)
        addChild(seePass!)
        setupBackButton()
        setupSetting()
        setupUsername()
        setupPassword()
        setupPetName()
        setupChangePetName()
        setupMusic()
    }
    
    func setupBackButton() {
        backButton.text = "Return to Menu"
        backButton.fontSize = 23
        backButton.fontColor = (.black)
        backButton.position = CGPoint(x: size.width * 0.682, y: size.height * 0.185)
        addChild(backButton)
    }
    func setupSetting() {
        setting.text = "Settings"
        setting.fontSize = 27
        setting.fontColor = (.black)
        setting.position = CGPoint(x: size.width * 0.187, y: size.height * 0.793)
        addChild(setting)
    }
    func setupUsername() {
        username.text = "Username"
        username.fontSize = 25
        username.fontColor = (.black)
        username.position = CGPoint(x: size.width * 0.434, y: size.height * 0.654)
        addChild(username)
    }
    func setupPassword() {
        password.text = "Password"
        password.fontSize = 25
        password.fontColor = (.black)
        password.position = CGPoint(x: size.width * 0.434, y: size.height * 0.495)
        addChild(password)
    }
    func setupPetName() {
        petname.text = "PetName"
        petname.fontSize = 25
        petname.fontColor = (.black)
        petname.position = CGPoint(x: size.width * 0.187, y: size.height * 0.184)
        addChild(petname)
    }
    func setupChangePetName() {
        changePetName.text = "Change"
        changePetName.fontSize = 23
        changePetName.fontColor = (.black)
        changePetName.position = CGPoint(x: size.width * 0.386, y: size.height * 0.185)
        addChild(changePetName)
    }
    func setupMusic() {
        music.text = "Toggle Music"
        music.fontSize = 25
        music.fontColor = (.black)
        music.position = CGPoint(x: size.width * 0.434, y: size.height * 0.34)
        addChild(music)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if toggleMusic?.contains(location) == true {
                print("Its quiet")
            }
            
            if seePass?.contains(location) == true {
                showPass.toggle()
                print("ShowPass")
            }
            if backButton.contains(location) == true {
                let menu = SideMenu(size: size)
                menu.scaleMode = .aspectFill
                view?.presentScene(menu)
            }
            if changePetName.contains(location) == true {
                print("Change Name")
            }
            
        }
    }
}

