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

struct AuthScene: View {
    @State private var user = ""
    @State private var pass = ""
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
                        register()
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
    func register() {
        Auth.auth().createUser(withEmail: user, password: pass) { result, error in if error != nil {
            print(error!.localizedDescription)
        }
        }
    }
}
