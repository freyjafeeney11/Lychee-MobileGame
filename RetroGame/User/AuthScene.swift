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
        let keypad = SKSpriteNode(imageNamed: "gameboy 1")
        
        backgroundColor = SKColor.red
        
        keypad.position = CGPoint(x: size.width * 0.505, y: size.height * 0.62)
        
        keypad.setScale(1.03)
        
        self.addChild(keypad)
    }
    
}

struct AuthScene: View {
    @State private var authenticated = false
    @State private var user = ""
    @State private var pass = ""
    @State private var isContentVisible = true
    @State private var newUser = false
    
    //var edit = EditUser()
    var userObj = UserObject(id: "someID", name: "default", user: "default@example.com", pass: "password", hunger: 100, social: 100, hygiene: 100, happiness: 100, energy: 100, volume: 1, coins: 0, pet: "cat bat", petName: "")

    let userObject = UserObjectManager.shared.getCurrentUser()
    
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
                    .position(x: 420, y: 266)
                    .ignoresSafeArea()
                VStack {
                    TextField("", text:$user)
                        .foregroundColor(.white)
                        .padding(30)
                        .autocapitalization(.none)
                    SecureField("", text:$pass)
                        .foregroundColor(.white)
                        .padding(30)
                        .autocapitalization(.none)
                    //register here
                    Button {
                        Task{
                            await self.register(withEmail: self.user, password: self.pass)
                        }
                    } label: {
                        Text("Create Account")
                            .foregroundColor(.white)
                            .font(.custom("Futura", size: 20))
                            .bold()
                            .frame(width:200, height:30)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.cyan))
                    }
                    .offset(x: -20)
                    // login here
                    Button {
                        login()
                    } label: {
                        Text("Login")
                            .font(.custom("Futura", size: 20))
                            .bold()
                            .foregroundColor(.white)
                            .frame(width:200, height:30)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.cyan))
                    }
                    .offset(x: -20)
                    Button {
                        authenticated = true
                    } label: {
                        Text("Skip for now")
                            .font(.custom("Futura", size: 15))
                            .bold()
                            .foregroundColor(.cyan)
                    }
                    .offset(x: -20)
                }
                .frame(width: 350)
                .offset(x: 100, y: 0)
            }
            .fullScreenCover(isPresented: $authenticated, content: {
                // Switch to SpriteKit scene
                MainGameSceneView()
            })
            .ignoresSafeArea()
        /*
            .fullScreenCover(isPresented: $newUser, content: {
                // Switch to SpriteKit scene
                choosePetView()
            })
            .ignoresSafeArea()*/
        }

    // log in
    func login() {
        let edit = EditUser()
        Auth.auth().signIn(withEmail: user, password: pass) { result, error in if error != nil {
            print(error!.localizedDescription)
            }
            else {

                //get user's name to pull from firestore
                userObject.user = user
                authenticated = true
                print("this is user from UserObjectManager \(String(describing: userObject.user))")
            }
            //pull from firestore
            edit.pullFromFirestore(user: userObject)
            UserObjectManager.shared.updateCurrentUser(with: userObject)
            print(userObject)
            userObject.printUser()
        }
    }
    // create a user
    func register(withEmail email: String, password: String) async{
        do{
            let _ = try await Auth.auth().createUser(withEmail: user, password: pass)
            let userID = Auth.auth().currentUser!.uid
            let atSign = email.firstIndex(of: "@")!
            let name = email[...atSign]

            // user levels initial
            let currUser = UserObject(id: userID, name: String(name), user: email, pass: password, hunger: 100, social: 100, hygiene: 100, happiness: 100, energy: 100, volume: 1, coins: 0, pet: "cat bat", petName: "")
            //print(currUser)
            UserObjectManager.shared.updateCurrentUser(with: currUser)
            let encodedUser = try Firestore.Encoder().encode(currUser)
            try await
                Firestore.firestore().collection("users").document(currUser.user).setData(encodedUser)
            authenticated = true
        }
        catch {
            print("DEBUG: Failed to create user with error \(error)")
        }
        if userObject.pet_choice == "none"{
            newUser = true
        }

    }
    
}



struct choosePetView: View{
    var body: some View {
        SpriteKitContainer(scene: ChooseYourPet())
            .ignoresSafeArea()
    }
}
