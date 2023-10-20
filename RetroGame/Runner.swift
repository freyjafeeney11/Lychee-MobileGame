//
//  Runner.swift
//  RetroGame
//
//  Created by Tess Ann Ritter on 10/19/23.
//

import SpriteKit

class Runner: SKScene{
    
    let cityFront = SKSpriteNode(imageNamed: "FrontBuilding")
    let cityBack = SKSpriteNode(imageNamed: "BackBuilding")
    let cityFront2 = SKSpriteNode(imageNamed: "FrontBuilding")
    let cityBack2 = SKSpriteNode(imageNamed: "BackBuilding")
    
    
    let sky = SKSpriteNode(imageNamed: "NightClouds")
    let sky2 = SKSpriteNode(imageNamed: "NightClouds")
    let sky3 = SKSpriteNode(imageNamed: "NightClouds")
    
    
    let backgroundVelocity1: CGFloat = 2.0
    let backgroundVelocity2: CGFloat = 1.5
    let skyVelocity: CGFloat = 1.0
    
    
    override func didMove(to view: SKView){
        self.createCity()
    }
    
    func createCity() {
        
        cityFront.anchorPoint = CGPoint(x: 2, y: -2)
        cityFront.position = CGPoint(x: 2, y: 0.5)
        cityFront.setScale(1.5)
        cityFront.zPosition = 3
        self.addChild(cityFront)
        
        cityBack.anchorPoint = CGPoint(x: 2, y: -2)
        cityBack.position = CGPoint(x: 2, y: 0.5)
        cityBack.setScale(1.5)
        cityBack.zPosition = 2
        self.addChild(cityBack)
        
        
        cityFront2.anchorPoint = CGPoint(x: 2, y: -2)
        cityFront2.position = CGPoint(x: 2, y: 0.5)
        cityFront2.setScale(1.5)
        cityFront2.zPosition = 3
        self.addChild(cityFront2)
        
        cityBack2.anchorPoint = CGPoint(x: 2, y: -2)
        cityBack2.position = CGPoint(x: 2, y: 0.5)
        cityBack2.setScale(1.5)
        cityBack2.zPosition = 2
        self.addChild(cityBack2)
        
        
        sky.anchorPoint = CGPoint(x: 2, y: -1.5)
        sky.position = CGPoint(x: 2, y: 0.5)
        sky.setScale(2)
        self.addChild(sky)
        
        sky2.anchorPoint = CGPoint(x: 2, y: -1.5)
        sky2.position = CGPoint(x: 2, y: 0.5)
        sky2.setScale(2)
        self.addChild(sky2)
        
        sky3.anchorPoint = CGPoint(x: 2, y: -1.5)
        sky3.position = CGPoint(x: 2, y: 0.5)
        sky3.setScale(2)
        self.addChild(sky3)
        
        
    }
    
    override func update(_ currentTime: TimeInterval){
        cityFront.position = CGPoint(x: cityFront.position.x - self.backgroundVelocity1, y: cityFront.position.y)
        cityBack.position = CGPoint(x: cityBack.position.x - self.backgroundVelocity2, y: cityBack.position.y)
        
        cityFront2.position = CGPoint(x: cityFront2.position.x - self.backgroundVelocity1, y: cityFront2.position.y)
        cityBack2.position = CGPoint(x: cityBack2.position.x - self.backgroundVelocity2, y: cityBack2.position.y)
        
        
        //sky position
        sky.position = CGPoint(x: sky.position.x - self.skyVelocity, y: sky.position.y)
        sky2.position = CGPoint(x: sky2.position.x - self.skyVelocity, y: sky2.position.y)
        sky3.position = CGPoint(x: sky3.position.x - self.skyVelocity, y: sky3.position.y)
        
        
        
        if(cityFront.position.x <= cityFront.size.width){
            cityFront.position = CGPointMake(cityFront2.position.x + cityFront2.size.width, cityFront.position.y)
        }
        
        if(cityFront2.position.x <= cityFront2.size.width){
            cityFront2.position = CGPointMake(cityFront.position.x + cityFront.size.width, cityFront2.position.y)
        }
        
        if(cityBack.position.x <= cityBack.size.width){
            cityBack.position = CGPointMake(cityBack2.position.x + cityBack2.size.width, cityBack.position.y)
        }
        
        if(cityBack2.position.x <= cityBack2.size.width){
            cityBack2.position = CGPointMake(cityBack.position.x + cityBack.size.width, cityBack2.position.y)
        }
        
        
        //when sky goes off screen
        if(sky.position.x <= sky.size.width){
            sky.position = CGPointMake(sky2.position.x + sky2.size.width, sky.position.y)
        }
        
        if(sky2.position.x <= sky2.size.width){
            sky2.position = CGPointMake(sky3.position.x + sky3.size.width, sky2.position.y)
        }
        
        if(sky3.position.x <= sky3.size.width){
            sky3.position = CGPointMake(sky.position.x + sky.size.width, sky3.position.y)
        }
    
        
    }
    /*
    var cityBack = SKSpriteNode()
    let backgroundVelocity: CGFloat = 3.0
    
    override func didMove(to view: SKView){
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        self.createCity()
    }
    
    override func update(_ currentTime: TimeInterval){
        self.moveBack()
    }
    
    func createCity(){
        for i in 0..<3{
            let cityBack = SKSpriteNode(imageNamed: "BackBuilding")
            cityBack.name = "CityBack"
            cityBack.anchorPoint = CGPoint(x: 0, y: 0)
            cityBack.position = CGPoint(x: i * Int(cityBack.size.width), y: 0)
            
            self.addChild(cityBack)
        }
    }
    
    func moveBack(){
        self.enumerateChildNodes(withName: "BackBuilding", using: {(node, stop) -> Void in
            if let back  = node as? SKSpriteNode {
                back.position = CGPoint(x: back.position.x - self.backgroundVelocity, y: back.position.y)
                
                if back.position.x <= -back.size.width {
                    back.position = CGPoint(x: back.position.x + back.size.width * 2, y: back.position.y)
                }
            }
        })
    }
     */
}
