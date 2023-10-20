//
//  GameViewController.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 10/9/23.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let runner = Runner(size: view.frame.size)
        let skView = self.view as! SKView
        runner.scaleMode = .aspectFill
        
        
        skView.ignoresSiblingOrder = true
        
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.presentScene(runner)
    }
}
