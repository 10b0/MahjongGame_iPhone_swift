//
//  GameScene.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 3/28/16.
//  Copyright (c) 2016 David Fernando Alatorre Guerrero. All rights reserved.
//


import SpriteKit



class GameScene: SKScene {
    
    var previousTime: Double = 0.0
    var backGroundSplash: SKSpriteNode?
    var blockUpdate = false    //fix bug, don't show main menu
    var soundManager: Sound?
    var touchScreenText: SKLabelNode?
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        backGroundSplash = SKSpriteNode(color: orangeColorBackground, size: frame.size)
        backGroundSplash!.zPosition = -20
        backGroundSplash!.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        
        soundManager = Sound(activeSounds: true, withMainTheme: true)
        soundManager!.playMainMusic()
        
        
        drawSplashScreen()
    }
    

    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        blockUpdate = updateSplashScreen()
    }
    
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        // DRAW
        if !blockUpdate {
            if currentTime - previousTime < 0.5 {
                if initState {
                  //  drawSplashScreen()
                  //  TextAndButtons.drawText("Touch screen", size: 50, position: CGPointMake(CGRectGetMidX(frame), frame.size.height/5), scene: self)
                    addChild(touchScreenText!)
                    initState = false
                }
            } else if currentTime - previousTime < 1 {
                if !initState {
                   // drawSplashScreen()
                    touchScreenText!.removeFromParent()
                    initState = true
                }
            } else {
                previousTime = currentTime
            }
        }
    }
    
    
    //////SPLASH SCREEN///////
    
    func drawSplashScreen() {
        
       // removeAllChildren()
        
        //Text
        touchScreenText = SKLabelNode(fontNamed: "Superclarendon-Black")
        touchScreenText!.text = "Touch screen"
        touchScreenText!.fontSize = 50
        touchScreenText!.position = CGPointMake(CGRectGetMidX(frame), frame.size.height/5)
        touchScreenText!.zPosition = 10
        touchScreenText!.fontColor = UIColor.blackColor()
        
        
        //background animation
        let spriteAtlas = SKTextureAtlas(named: "blue_background")
        let texturesNames = spriteAtlas.textureNames
        var spritesArray = [SKTexture]()
        
        for i in 1...texturesNames.count {
            spritesArray.append(SKTexture(imageNamed: "blue_background\(i)"))
        }
        
        let blue_back = SKSpriteNode(imageNamed: "blue_background1")
        blue_back.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        blue_back.runAction(SKAction.repeatActionForever(SKAction.animateWithTextures(spritesArray, timePerFrame: 1.2)))
        
        let cover = SKSpriteNode(imageNamed: "mahjong_cover")
        cover.zPosition = blue_back.zPosition + 1
        cover.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        
        addChild(backGroundSplash!)
        addChild(blue_back)
        addChild(cover)

    }
    
    func updateSplashScreen() -> Bool {
        soundManager!.stopMainMusic()
        soundManager!.playSound("select.m4a", scene: self)
        let transition = SKTransition.doorsOpenHorizontalWithDuration(1.5)
        let toMainMenu = MainMenuScene(size: size, music: true, mark: false)
        view?.presentScene(toMainMenu, transition: transition)
        return true
    }
    
    //////SPLASH SCREEN///////
    
  
    
}






