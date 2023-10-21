//
//  GameViewController.swift
//  testing game
//
//  Created by freyja feeney on 10/1/23.
//

import UIKit
import SwiftUI
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let view = self.view as! SKView? {
                // Create and present the title scene
                let titleScene = TitleScreen(size: view.frame.size)
                titleScene.scaleMode = .aspectFill
                view.presentScene(titleScene)
            }


        }
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .landscapeLeft
        } else {
            return .all
        }
    }

}
