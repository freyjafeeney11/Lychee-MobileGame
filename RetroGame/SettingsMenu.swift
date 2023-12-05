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
    
    var player = SKSpriteNode(imageNamed: "filler")
    
    override func didMove(to view: SKView) {
        if mostRecentUser.pet_choice == "cat bat"{
            player = SKSpriteNode(imageNamed: "catbat_idle1")
            player.position = CGPoint(x: size.width * 0.171, y: size.height * 0.48)
            player.setScale(0.10)
        }else{
            player = SKSpriteNode(imageNamed: "chicken-hamster")
            player.position = CGPoint(x: size.width * 0.171, y: size.height * 0.6)
            player.setScale(1.9)
        }
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
        nameUser.fontSize = 15
        username.position = CGPoint(x: size.width * 0.409, y: size.height * 0.643)
        nameUser.position = CGPoint(x: size.width * 0.645, y: size.height * 0.65)
        addChild(username)
        addChild(nameUser)
    }
    func setupPassword() {
        password.text = "Password"
        hiddenPass.text = "********"
        pass.text = mostRecentUser.pass
        password.fontSize = 23
        hiddenPass.fontSize = 17
        pass.fontSize = 15
        password.position = CGPoint(x: size.width * 0.409, y: size.height * 0.5)
        hiddenPass.position = CGPoint(x: size.width * 0.61, y: size.height * 0.485)
        pass.position = CGPoint(x: size.width * 0.61, y: size.height * 0.5)
        addChild(password)
        addChild(hiddenPass)
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
                if mostRecentUser.volume == 0{
                    addChild(toggleMusic!)
                    edit.volumeToggle(vol: 1)
                }else{
                    edit.volumeToggle(vol: 0)
                    toggleMusic!.removeFromParent()
                }
            }
            
            if seePass?.contains(location) == true {
                if pass.parent != nil{
                    pass.removeFromParent()
                    addChild(hiddenPass)
                }else{
                    hiddenPass.removeFromParent()
                    addChild(pass)
                }
            }
            if backButton.contains(location) == true {
                let menu = SideMenu(size: size)
                menu.scaleMode = .aspectFill
                view?.presentScene(menu)
            }
            if changePetName.contains(location) == true {
                if edit.mostRecentUser.pet_choice == "chicken hamster"{
                    edit.usersPetChoice(petChoice: "cat bat")
                }else{
                    edit.usersPetChoice(petChoice: "chicken hamster")

                }
                
            }
            
        }
    }
}

