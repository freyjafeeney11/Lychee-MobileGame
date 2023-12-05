//
//  BedScene.swift
//  RetroGame
//
//  Created by Tsering Lhakhang on 12/4/23.
//

import Foundation
import SwiftUI
import GameplayKit
import Firebase
import _SpriteKit_SwiftUI

class BedScene: SKScene, SKPhysicsContactDelegate {
    private var player : SKSpriteNode?
    var menuBar: SKSpriteNode?
    var edit = EditUser()
    let mostRecentUser = UserObjectManager.shared.getCurrentUser()
    var textures = [String]()
    
    
    override func didMove(to view: SKView) {
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        addRoom()
        addMenu()
        addCharacter()
        
    }

    func addCharacter() {
        player = SKSpriteNode(imageNamed: "catbat_prototype")

        if mostRecentUser.pet_choice == "cat bat" {
            textures = ["catbat_idle1", "catbat_idle2", "catbat_idle3"]
            player?.position = CGPoint(x: size.width * 0.7, y: size.height * 0.55)
        } else {
            textures = ["chicken-hamster"]
            player?.position = CGPoint(x: size.width * 0.7, y: size.height * 0.55)
        }
        let idle = textures.map { SKTexture(imageNamed: $0) }
        let animation = SKAction.animate(with: idle, timePerFrame: 0.3)
        let sleep = SKAction.repeatForever(animation)
        player!.run(sleep)
        player!.setScale(1.25)
        addChild(player!)
    }
    
    func addRoom () {
        backgroundColor = SKColor.yellow
        let room = SKSpriteNode(imageNamed: "Bedroom")
        room.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        addChild(room)
    }
    
    func addMenu() {
        menuBar = SKSpriteNode(imageNamed: "SideMenuOpen")
        menuBar?.setScale(0.8)
        menuBar?.position = CGPoint(x: -248, y: size.height * 0.5)
        addChild(menuBar!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            if menuBar?.contains(location) == true {
                let menu = SideMenu(size: size)
                menu.scaleMode = .aspectFill
                view?.presentScene(menu)
            }
        }
    }
    
    public override init(size: CGSize) {
        super.init(size: size)

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

struct BedView: View {
    var scene: SKScene {
        let scene = BedScene(size: CGSize(width: 900, height: 400))
        scene.scaleMode = .aspectFill
        return scene
    }

    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
}
