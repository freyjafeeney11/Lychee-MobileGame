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
struct AuthScene: View {
    @State private var user = ""
    @State private var pass = ""
    //@Published var userSession: FirebaseAuth.User?
    //@Published var currentUser: User?
    
    /*
    init(){
        self.userSession = Auth.auth().currentUser
    } */
    
    
    @State private var showMainScreen = false
    
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(
                    destination: MainView(),
                    isActive: $showMainScreen
                ) {
                    EmptyView()
                }
                Image("keypad")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 8000, height: 420)
                NavigationLink(destination: MainView(), isActive: $showMainScreen) {
                    EmptyView()}
                VStack(spacing:40){
                    TextField("USERNAME!!", text:$user)
                        .foregroundColor(.white)
                    SecureField("PASSWORD!!", text:$pass)
                        .foregroundColor(.white)
                    
                    //register here
                    Button {
                        Task{
                            await self.register(withEmail: self.user, password: self.pass)
                        }
                    } label: {
                        Text("Create Account")
                            .bold()
                            .frame(width:200, height:20)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(.linearGradient(colors:[.pink, .red], startPoint: .top, endPoint: .bottomTrailing)))
                    }
                    // login here
                    Button {
                        login()
                    } label: {
                        Text("Login")
                            .bold()
                            .foregroundColor(.white)
                    }
                    // added this to bypass and move to main screen for now
                    Button {
                        showMainScreen = true
                    } label: {
                        Text("Go to main screen")
                            .bold()
                            .foregroundColor(.white)
                    }
                }
                .frame(width: 350)
                .padding(.trailing, -1800)
            }
            .onAppear {
                if showMainScreen {
                    withAnimation(.interactiveSpring) {
                        // You can choose a different transition effect here
                        // For example: scaleEffect, rotationEffect, etc.
                        // destinationViewTransitionEffect = ...
                    }
                }
            }
            .ignoresSafeArea()
        }
    }
    func login() {
        Auth.auth().signIn(withEmail: user, password: pass) { result, error in if error != nil {
            print(error!.localizedDescription)
        }
        }
    }
    //not sure how to do this
    func mainScreen() {
        //
    }
    func register(withEmail email: String, password: String) async {
        do{
            let _ = try await Auth.auth().createUser(withEmail: user, password: pass)
            let userID = Auth.auth().currentUser!.uid
            var atSign = email.firstIndex(of: "@")!
            var name = email[...atSign]
            let user = UserHealth(id: userID, name: String(name), user: email, pass: password, hunger: 100, social: 100, hygiene: 100, happiness: 100, energy: 100, volume: true, coins: 0)
            let encodedUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(email).setData(encodedUser)
        }
        catch {
            print("DEBUG: Failed to create user with error \(error)")
        }
    }
}
