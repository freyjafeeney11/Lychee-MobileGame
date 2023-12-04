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
    
    var edit = EditUser()
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()

    var toggleMusic: SKSpriteNode?
    var seePass: SKSpriteNode?
    var returnToMenu: SKSpriteNode?
    
    let backButton = SKLabelNode(fontNamed: "Futura")
    let setting = SKLabelNode(fontNamed: "Futura")
    let username = SKLabelNode(fontNamed: "Futura")
    let nameUser = SKLabelNode(fontNamed: "Futura")
    let password = SKLabelNode(fontNamed: "Futura")
    let hiddenPass = SKLabelNode(fontNamed: "Futura")
    let pass = SKLabelNode(fontNamed: "Futura")
    let petname = SKLabelNode(fontNamed: "Futura")
    let changePetName = SKLabelNode(fontNamed: "Futura")
    let music = SKLabelNode(fontNamed: "Futura")

    //var sittingSprite = SKTexture(imageNamed: "catbat_ver2-export.png")

    
    override func didMove(to view: SKView) {
        
        let player = SKSpriteNode(imageNamed: mostRecentUser.pet_choice)
        
        let room = SKSpriteNode(imageNamed: "FullLivingRoom")
        let settingsMenu = SKSpriteNode(imageNamed: "SettingsMenu")
        toggleMusic = SKSpriteNode(imageNamed: "MusicOnButton")
        seePass = SKSpriteNode(imageNamed: "HidePassButton")
        
        room.setScale(0.559)
        settingsMenu.setScale(0.95)
        room.position = CGPoint(x: size.width * 0.4956, y: size.height * 0.465)
        settingsMenu.position = CGPoint(x: size.width * 0.47, y: size.height * 0.5)
        toggleMusic?.position = CGPoint(x: size.width * 0.65, y: size.height * 0.37)
        seePass?.position = CGPoint(x: size.width * 0.7, y: size.height * 0.51)

        addChild(room)
        addChild(settingsMenu)
        
        if mostRecentUser.volume == 1{
            addChild(toggleMusic!)
        }
        
        addChild(player)
        
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
        setting.position = CGPoint(x: size.width * 0.171, y: size.height * 0.775)
        addChild(setting)
    }
    func setupUsername() {
        username.text = "Username"
        nameUser.text = mostRecentUser.user
        username.fontSize = 23
        nameUser.fontSize = 19
        username.position = CGPoint(x: size.width * 0.409, y: size.height * 0.643)
        nameUser.position = CGPoint(x: size.width * 0.645, y: size.height * 0.643)
        addChild(username)
        addChild(nameUser)
    }
    func setupPassword() {
        password.text = "Password"
        hiddenPass.text = "********"
        pass.text = mostRecentUser.pass
        password.fontSize = 23
        hiddenPass.fontSize = 23
        pass.fontSize = 23
        password.position = CGPoint(x: size.width * 0.409, y: size.height * 0.495)
        hiddenPass.position = CGPoint(x: size.width * 0.609, y: size.height * 0.495)
        pass.position = CGPoint(x: size.width * 0.609, y: size.height * 0.495)
        addChild(password)
    }
    func setupPetName() {
        petname.text = mostRecentUser.name
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
                toggleMusic!.removeFromParent()
                if mostRecentUser.volume == 1{
                    edit.volumeToggle(vol: 0)
                }else{
                    edit.volumeToggle(vol: 1)
                    addChild(toggleMusic!)
                }
            }
            
            if seePass?.contains(location) == true {
                addChild(pass)
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

