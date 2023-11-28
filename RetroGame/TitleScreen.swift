//
//  TitleScreen.swift
//  testing game
//
//  Created by freyja feeney on 10/19/23.
//

import Foundation
import SpriteKit
import SwiftUI
import GameplayKit


class TitleScreen: SKScene {
    @State private var showMainScreen = false
    
    var startButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let titleBg = SKSpriteNode(imageNamed: "title_BG")
        let title = SKSpriteNode(imageNamed: "title-export")
        
        backgroundColor = SKColor.white
        
        //change this to play button
        startButton = SKSpriteNode(imageNamed: "PlayButton")
        startButton?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.4)
        
        titleBg.position = CGPoint(x: size.width * 0.5, y: size.height * 0.5)
        title.position = CGPoint(x: size.width * 0.5, y: size.height * 0.6)
        
        title.setScale(0.6)
        startButton?.setScale(2)
        
        self.addChild(titleBg)
        self.addChild(title)
        self.addChild(startButton!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)

            if startButton?.contains(location) == true {
                print("startButton touched")
                showMainScreen = true
                print(showMainScreen)
                
//                let authSceneView = MainView()
//                                // need this controller to display swiftUI from spritekit
//                let hostingController = UIHostingController(rootView: authSceneView)
//                self.view?.window?.rootViewController?.present(hostingController, animated: true, completion: nil)
                
//                let MainScreen = MainScreen(size: size)
//                MainScreen.scaleMode = .aspectFill
//                view?.presentScene(MainScreen)
                
                //this is auth stuff uncomment it to add users.. Spritekit -> SwiftUI
                let authSceneView = AuthScene()
                //need this controller to display swiftUI from spritekit
                let hostingController = UIHostingController(rootView: authSceneView)
                self.view?.window?.rootViewController?.present(hostingController, animated: true, completion: nil)
            }
        }
    }
}
