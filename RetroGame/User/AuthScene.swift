//
//  AuthScene.swift
//  RetroGame
//
//  Created by freyja feeney on 11/26/23.
//

import Foundation
import Firebase
import SwiftUI
import SpriteKit
import FirebaseFirestoreSwift


@MainActor

class Authentication: SKScene {
    static var shared = Authentication()

    var startButton: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        let keypad = SKSpriteNode(imageNamed: "keypad")
        
        backgroundColor = SKColor.green
        
        //change this to play button
        startButton = SKSpriteNode(imageNamed: "PlayButton")
        startButton?.position = CGPoint(x: size.width * 0.5, y: size.height * 0.4)
        keypad.position = CGPoint(x: size.width * 0.5, y: size.height * 0.6)
        
        keypad.setScale(0.8)
        startButton?.setScale(2)
        
        self.addChild(keypad)
        self.addChild(startButton!)
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches {
//            let location = touch.location(in: self)
//
//            if startButton?.contains(location) == true {
//                callMainScreen()
//            }
//        }
//    }
//    func callMainScreen() {
//        let MainScreen = MainScreen(size: size)
//        MainScreen.scaleMode = .aspectFill
//        view?.presentScene(MainScreen)
//    }
}

struct AuthScene: View {
    @State private var authenticated = false
    @State private var user = ""
    @State private var pass = ""
    @State private var isContentVisible = true
    //@Published var userSession: FirebaseAuth.User?
    //@Published var currentUser: User?
    
    /*
    init(){
        self.userSession = Auth.auth().currentUser
    } */
    
    
    @State private var showMainScreen = false
    
    var body: some View {
        var scene: SKScene {
            let scene = Authentication.shared
            scene.size = CGSize(width: 1100, height: 600)
            scene.scaleMode = .aspectFill
            scene.backgroundColor = .white
            return scene
        }
            ZStack {
                SpriteView(scene: scene)
                    .frame(width: 1000, height: 600)
                    .position(x: 500, y: 275)
                    .ignoresSafeArea()
                VStack {
                    TextField("", text:$user)
                        .foregroundColor(.white)
                        .padding(30)
                    SecureField("", text:$pass)
                        .foregroundColor(.white)
                        .padding(30)
                    //register here
                    Button {
                        Task{
                            await self.register(withEmail: self.user, password: self.pass)
                        }
                    } label: {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .bold()
                            .frame(width:200, height:30)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors:[.pink, .green], startPoint: .top, endPoint: .bottomTrailing)))
                    }
                    // login here
                    Button {
                        login()
                    } label: {
                        Text("Already have an account? Login")
                            .bold()
                            .foregroundColor(.white)
                    }
                    Button {
                        authenticated = true
                    } label: {
                        Text("Skip for now")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 350)
                .offset(x: 250, y:30)
            }
            .fullScreenCover(isPresented: $authenticated, content: {
                // Switch to SpriteKit scene
                MainGameSceneView()
                    .transition(.opacity)
            })
            .ignoresSafeArea()
        }

    // log in
    func login() {
        Auth.auth().signIn(withEmail: user, password: pass) { result, error in if error != nil {
            print(error!.localizedDescription)
        } else {
            authenticated = true
        }
        }
    }
    // create a user
    func register(withEmail email: String, password: String) async {
        do{
            let _ = try await Auth.auth().createUser(withEmail: user, password: pass)
            let userID = Auth.auth().currentUser!.uid
            var atSign = email.firstIndex(of: "@")!
            var name = email[...atSign]
            // user levels initial
            let user = UserHealth(id: userID, name: String(name), user: email, pass: password, hunger: 100, social: 100, hygiene: 100, happiness: 100, energy: 100, volume: true, coins: 0)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(email).setData(encodedUser)
        }
        catch {
            print("DEBUG: Failed to create user with error \(error)")
        }
    }
}