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
    
    var test = "slay"
    
    let backButton = SKLabelNode(fontNamed: "Chalkduster")
    let setting = SKLabelNode(fontNamed: "Chalkduster")
    let username = SKLabelNode(fontNamed: "Chalkduster")
    let password = SKLabelNode(fontNamed: "Chalkduster")
    let petname = SKLabelNode(fontNamed: "Chalkduster")
    let changePetName = SKLabelNode(fontNamed: "Chalkduster")
    let music = SKLabelNode(fontNamed: "Chalkduster")
    
    //@State private var showPassword

    override func didMove(to view: SKView) {
        
        
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let settingsMenu = SKSpriteNode(imageNamed: "SettingsMenu")
        toggleMusic = SKSpriteNode(imageNamed: "MusicOnButton")
        seePass = SKSpriteNode(imageNamed: "HidePassButton")
        
        room.setScale(0.559)
        settingsMenu.setScale(0.95)
        room.position = CGPoint(x: size.width * 0.4956, y: size.height * 0.465)
        settingsMenu.position = CGPoint(x: size.width * 0.47, y: size.height * 0.5)
        toggleMusic?.position = CGPoint(x: size.width * 0.65, y: size.height * 0.37)
        seePass?.position = CGPoint(x: size.width * 0.73, y: size.height * 0.51)

        addChild(room)
        addChild(settingsMenu)
        
        //if showPassword == false{
            addChild(toggleMusic!)
        //}
        
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
        backButton.fontSize = 19
        backButton.position = CGPoint(x: size.width * 0.645, y: size.height * 0.199)
        addChild(backButton)
    }
    func setupSetting() {
        setting.text = "Settings"
        setting.fontSize = 25
        setting.position = CGPoint(x: size.width * 0.171, y: size.height * 0.78)
        addChild(setting)
    }
    func setupUsername() {
        username.text = "Username"
        username.fontSize = 23
        username.position = CGPoint(x: size.width * 0.409, y: size.height * 0.643)
        addChild(username)
    }
    func setupPassword() {
        password.text = "Password"
        password.fontSize = 23
        password.position = CGPoint(x: size.width * 0.409, y: size.height * 0.495)
        addChild(password)
    }
    func setupPetName() {
        petname.text = "PetName"
        petname.fontSize = 23
        petname.position = CGPoint(x: size.width * 0.171, y: size.height * 0.199)
        addChild(petname)
    }
    func setupChangePetName() {
        changePetName.text = "Change"
        changePetName.fontSize = 21
        changePetName.position = CGPoint(x: size.width * 0.361, y: size.height * 0.199)
        addChild(changePetName)
    }
    func setupMusic() {
        music.text = "Toggle Music"
        music.fontSize = 22
        music.position = CGPoint(x: size.width * 0.409, y: size.height * 0.349)
        addChild(music)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            
            if toggleMusic?.contains(location) == true {
                print("Its quiet")
            }
            
            if seePass?.contains(location) == true {
                //if showPassword == false{
                    
                    //print("ShowPass")
                //}
                //if showPassword == true{
                    
                    //print("Hide")
                //}
                
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

