//
//  SpriteKitContainer.swift
//  RetroGame
//
//  Created by freyja feeney on 11/29/23.
//

//file to facilitate transitions w swiftui and spritekit skscene

import SwiftUI
import SpriteKit

struct SpriteKitContainer: UIViewRepresentable {
    let scene: SKScene

    func makeUIView(context: Context) -> SKView {
        let view = SKView()
        // change to new scene
        view.presentScene(scene)
        // return the scene view
        return view
    }


    func updateUIView(_ uiView: SKView, context: Context) {}
}
