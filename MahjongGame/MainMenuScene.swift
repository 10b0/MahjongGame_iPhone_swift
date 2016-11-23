//
//  MainMenuScene.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 4/4/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit

class MainMenuScene: SKScene {

    var enebleMark = false
    
    //Main Menu Screen interface
    var gameButton: SKSpriteNode?
    var optionsButton: SKSpriteNode?
    var helpButton: SKSpriteNode?
    var aboutButton:SKSpriteNode?
    
    //Option Interface
    var ficha01: SKSpriteNode?
    var ficha02: SKSpriteNode?
    var ficha03: SKSpriteNode?
    var buttonMusic: SKSpriteNode?
    var buttonMark: SKSpriteNode?
    var labelMusic: SKLabelNode?
    var labelMark: SKLabelNode?
    
    //Select screen
    var blockArrows = false
    
    //Select Tiles interface
    var tiles0: SKSpriteNode?
    var tiles1: SKSpriteNode?
    var selectTilesButton: SKSpriteNode?
    
    var selector: SKSpriteNode?
    var selector_on: SKSpriteNode?
    var selectBoardButton: SKSpriteNode?
    var bigArrowLeft: SKSpriteNode?
    var bigArrowRight: SKSpriteNode?
    
    var helpScreen: Help?
    var selectorScreen: ShiftSelection?
    
    var backGroundMenu: SKSpriteNode?
    
    var blockUpdate = false    //fix bug, don't draw main menu
    
    var soundManager: Sound?
    
    var menuInitFlame: SKSpriteNode?
    
    init(size: CGSize, music: Bool, mark: Bool) {

        super.init(size: size)
        
        enebleMark = mark
        
        //Sounds
        soundManager = Sound(activeSounds: music, withMainTheme: true)
        
        helpScreen = Help(scene: self)
        selectorScreen = ShiftSelection(newScene: self)
        
        changeState(gameStates.main_MENU_SCREEN.hashValue)  //Root state
        
        
        backGroundMenu = SKSpriteNode(color: orangeColorBackground, size: frame.size)
        backGroundMenu!.zPosition = -20
        backGroundMenu!.position = CGPoint(x: frame.size.width/2, y: frame.size.height/2)
        
        
        initState = true
        gameButton = TextAndButtons.createdButton()
        optionsButton = TextAndButtons.createdButton()
        helpButton = TextAndButtons.createdButton()
        aboutButton = TextAndButtons.createdButton()
        
        let backgroundMenuImg = SKSpriteNode(imageNamed: "DragonMenu")
        backgroundMenuImg.zPosition = -10
        backgroundMenuImg.position = CGPoint(x: frame.width/2, y: frame.height/2)
        
        // menu animation
        let menuAtlas = SKTextureAtlas(named: "DragonMenuAnim")
        let textureNames = menuAtlas.textureNames
        var menuArray = [SKTexture]()
        
        for i in 1...textureNames.count {
            menuArray.append(SKTexture(imageNamed: "DragonMenu\(i)"))
        }
        menuArray.append(SKTexture(imageNamed: "DragonMenu1"))
        
        menuInitFlame = SKSpriteNode(texture: menuArray[0])
        menuInitFlame!.position = CGPoint(x: frame.midX, y: frame.midY)
        menuInitFlame!.run(SKAction.repeatForever(SKAction.sequence([SKAction.animate(with: menuArray, timePerFrame: 0.15), SKAction.wait(forDuration: 6
            )])))
        
        print("main menu init state:\(currentState)   init:\(initState)")
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.location(in: self)
            feedbackButtons(location, ended: false)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            feedbackButtons(location, ended: false)
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            feedbackButtons(location, ended: true)
        }
    }
    
    func feedbackButtons(_ location: CGPoint, ended: Bool) {
        
        switch currentState {
        case gameStates.main_MENU_SCREEN.hashValue:
            updateMainMenuScreen(location, ended: ended)
        case gameStates.select_BOARD_SCREEN.hashValue:
            
            if selectorScreen!.updateSelectBoardScreen(location, ended: ended) {
                changeState(gameStates.select_TOKEN_SCREEN.hashValue)
            }
            
        case gameStates.select_TOKEN_SCREEN.hashValue:
            
            if selectorScreen!.updateSelectBoardScreen(location, ended: ended) {
                
                blockUpdate = true
                
                let transition = SKTransition.doorsOpenHorizontal(withDuration: 1.5)
                //check music
                let gameplayScene = GameplayScene(size: size, music: soundManager!.activeSounds, mark: enebleMark)
                view?.presentScene(gameplayScene, transition: transition)
                
                soundManager!.stopMainMusic()
                
            }
        case gameStates.options_SCREEN.hashValue:
            updateOptionsScreen(location, ended: ended)
        case gameStates.help_SCREEN.hashValue:
            helpScreen!.updateHelpScreen(location, ended: ended)
        case gameStates.about_SCREEN.hashValue:
            updateAboutScreen(location, ended: ended)
        default:
            break
            
        }
    }
    

    func drawScreen() {
        //DRAW
        removeAllChildren()
        
        switch currentState {
        case gameStates.main_MENU_SCREEN.hashValue:
            drawMainMenuScreen()
        case gameStates.select_BOARD_SCREEN.hashValue, gameStates.select_TOKEN_SCREEN.hashValue:
            selectorScreen!.drawSelectScreen()
        case gameStates.options_SCREEN.hashValue:
            drawOptionsScreen()
        case gameStates.help_SCREEN.hashValue:
            helpScreen!.drawHelpScreen(tilesSelected, scene: self)
        case gameStates.about_SCREEN.hashValue:
            drawAboutScreen()
        default:
            break
            
        }
    }
    
    
    //////MAIN MENU SCREEN///////
    func drawMainMenuScreen() {

        addChild(backGroundMenu!)
        
        //addChild(backgroundMenuImg)
        
        
        print("main menu paint: \(initState)")

        addChild(menuInitFlame!)
        
        
        TextAndButtons.drawText("MENU", size: 40, position: CGPoint(x: frame.midX + frame.size.width/8, y: frame.size.height/4 * 2.5), scene: self)
        
        TextAndButtons.drawButton(gameButton!, text: "Start Game", position: CGPoint(x: frame.midX + frame.size.width/8, y: frame.size.height/4 * 2.125), scene: self)
        TextAndButtons.drawButton(optionsButton!, text: "Options", position: CGPoint(x: frame.midX + frame.size.width/8, y: frame.size.height/4 * 1.75), scene: self)
        TextAndButtons.drawButton(helpButton!, text: "Help", position: CGPoint(x: frame.midX + frame.size.width/8, y: frame.size.height/4 * 1.375), scene: self)
        TextAndButtons.drawButton(aboutButton!, text: "About", position: CGPoint(x: frame.midX + frame.size.width/8, y: frame.size.height/4), scene: self)
        
        soundManager!.playMainMusic()
        
    }
    
    
    func updateMainMenuScreen(_ point: CGPoint, ended: Bool) {

        
        if TextAndButtons.checkTouch(point, button: gameButton!, ended: ended) {
            if ended {
                changeState(gameStates.select_BOARD_SCREEN.hashValue)
            }
        }
        
        if TextAndButtons.checkTouch(point, button: optionsButton!, ended: ended) {
            if ended {
                changeState(gameStates.options_SCREEN.hashValue)
            }
        }
        
        if TextAndButtons.checkTouch(point, button: helpButton!, ended:  ended) {
            if ended {
                changeState(gameStates.help_SCREEN.hashValue)
            }
        }
        
        if TextAndButtons.checkTouch(point, button: aboutButton!, ended: ended) {
            if ended {
                changeState(gameStates.about_SCREEN.hashValue)
            }
        }
    }
    
    //////MAIN MENU SCREEN///////
    
        
    
    //////OPTIONS SCREEN///////
    
    func drawOptionsScreen() {
        
        var color: SKColor?
        
        addChild(backGroundMenu!)
        drawBackButton(self)
        
        
        initState = false
        if tilesSelected == tilesSet.original.hashValue {
            ficha01 = SKSpriteNode(imageNamed: "ficha0")
            ficha02 = SKSpriteNode(imageNamed: "ficha8")
            ficha03 = SKSpriteNode(imageNamed: "ficha11")
        } else {
            ficha01 = SKSpriteNode(imageNamed: "fichaM0")
            ficha02 = SKSpriteNode(imageNamed: "fichaM8")
            ficha03 = SKSpriteNode(imageNamed: "fichaM11")
        }
        
        ficha01!.position = CGPoint(x: frame.size.width/1.5 - ficha01!.size.width, y: ((frame.maxY / 6) * 3) + 15)
        ficha02!.position = CGPoint(x: frame.size.width/1.5 - 9, y: ((frame.maxY / 6) * 3) + 15)
        ficha03!.position = CGPoint(x: frame.size.width/1.5 - 9 + ficha01!.size.width - 9, y: ((frame.maxY / 6) * 3) + 15)
        
        switch arc4random() % 4 {
        case 0:
            color = SKColor.red
        case 1:
            color = SKColor.blue
        case 2:
            color = SKColor.yellow
        case 3:
            color = SKColor.purple
        default:
            color = SKColor.yellow
        }
        
        ficha01!.color = color!
        ficha02!.color = color!
        ficha03!.color = color!
        
        ficha01!.colorBlendFactor = 0.35
        ficha02!.colorBlendFactor = 0.35
        ficha03!.colorBlendFactor = 0.35
        
        ficha02!.zPosition = ficha01!.zPosition + 1
        ficha03!.zPosition = ficha02!.zPosition + 1
        
        if enebleMark {
            buttonMark = SKSpriteNode.init(imageNamed: "switch_on")
            ficha02!.colorBlendFactor = 0.1
        } else {
            buttonMark = SKSpriteNode.init(imageNamed: "switch_off")
            ficha02!.colorBlendFactor = 0.35
        }
        buttonMark!.position = CGPoint(x: frame.size.width/1.5, y: ficha01!.position.y - ficha01!.size.height/2 - buttonMark!.size.height/2 - 10)
        
        labelMark = SKLabelNode.init(fontNamed: "Superclarendon-Black")
        labelMark!.text = "Highlight:"
        labelMark!.fontColor = UIColor.black
        labelMark!.position = CGPoint(x: frame.size.width/1.5, y: ficha01!.position.y + ficha01!.size.height/2 + labelMark!.frame.size.height/2)
        labelMark!.fontSize = 30
        
        if soundManager!.activeSounds {
            buttonMusic = SKSpriteNode.init(imageNamed: "music_on")
        } else {
            buttonMusic = SKSpriteNode.init(imageNamed: "music_off")
        }
        buttonMusic!.position = CGPoint(x: frame.size.width/3, y: ((frame.maxY / 6) * 3) - 15)
        
        labelMusic = SKLabelNode.init(fontNamed: "Superclarendon-Black")
        labelMusic!.text = "Sound:"
        labelMusic!.fontColor = UIColor.black
        labelMusic!.position = CGPoint(x: frame.size.width/3, y: buttonMusic!.position.y + buttonMusic!.size.height/2 + labelMusic!.frame.size.height/2 + 15)
        labelMusic!.fontSize = 30
        
        
        TextAndButtons.drawText("Options", size: 40, position: CGPoint(x: frame.midX, y: frame.size.height/6 * 5), scene: self)
        addChild(buttonMusic!)
        addChild(labelMusic!)
        addChild(ficha01!)
        addChild(ficha02!)
        addChild(ficha03!)
        addChild(buttonMark!)
        addChild(labelMark!)
        
    }
    
    
    func updateOptionsScreen(_ point: CGPoint, ended: Bool) {
        updateBackButton(point, ended: ended)
        
        //Sound Button
        if point.x > buttonMusic!.position.x - buttonMusic!.size.width/2 && point.x < buttonMusic!.position.x + buttonMusic!.size.width/2 {
            if point.y < buttonMusic!.position.y + buttonMusic!.size.height/2 && point.y > buttonMusic!.position.y - buttonMusic!.size.height/2 {
                if ended {
                    buttonMusic!.removeFromParent()
                    
                    if soundManager!.activeSounds {
                        soundManager!.stopMainMusic()
                        soundManager!.activeSounds = false
                        buttonMusic = SKSpriteNode(imageNamed: "music_off")
                    } else {
                        soundManager!.activeSounds = true
                        buttonMusic = SKSpriteNode(imageNamed: "music_on")
                        soundManager!.playMainMusic()
                    }
                    buttonMusic!.position = CGPoint(x: frame.size.width/3, y: ((frame.maxY / 6) * 3) - 15)
                    addChild(buttonMusic!)
                }
            }
        }
        
        // Mark button
        if point.x > ficha01!.position.x - ficha01!.size.width/2 && point.x < ficha03!.position.x + ficha03!.size.width/2 {
            if point.y < ficha01!.position.y + ficha01!.size.height/2 && point.y > buttonMark!.position.y - buttonMark!.size.height/2 {
                if ended {
                    
                    buttonMark!.removeFromParent()
                    
                    if enebleMark {
                        enebleMark = false
                        buttonMark = SKSpriteNode(imageNamed: "switch_off")
                        ficha02!.colorBlendFactor = 0.35
                    } else {
                        enebleMark = true
                        buttonMark = SKSpriteNode(imageNamed: "switch_on")
                        ficha02!.colorBlendFactor = 0.1
                    }
                    buttonMark!.position = CGPoint(x: frame.size.width/1.5, y: ficha01!.position.y - ficha01!.size.height/2 - buttonMark!.size.height/2 - 10)
                    addChild(buttonMark!)
                    
                }
            }
        }
    }
    
    
    //////OPTIONS SCREEN///////
        
    
    //////ABOUT SCREEN///////
    
    func drawAboutScreen() {
        addChild(backGroundMenu!)
        
        //get the version
        let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString")
        let build = Bundle.main.object(forInfoDictionaryKey: kCFBundleVersionKey as String)
        let displayVerison = "Version: \(version!)\(build!)"
        
        let aboutImg = SKSpriteNode.init(imageNamed: "AboutImage")
        aboutImg.zPosition = -20
        aboutImg.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(aboutImg)
        
        drawBackButton(self)
        
        initState = false
            
        TextAndButtons.drawText("About", size:40, position:CGPoint(x: frame.midX + frame.midX/2.5, y: frame.size.height/6 * 5), scene:self)
        TextAndButtons.drawText(displayVerison, size:20, position:CGPoint(x: frame.midX + frame.midX/2.5, y: frame.size.height/6 * 4.7), scene:self)
        TextAndButtons.drawText("2016", size:20, position:CGPoint(x: frame.midX + frame.midX/2.5, y: frame.size.height/6 * 4.4), scene:self)
        
    }
    
    
    func updateAboutScreen(_ point:CGPoint, ended:Bool) {
        updateBackButton(point, ended:ended)
    }
    
    //////ABOUT SCREEN///////
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
       // print("main menu update state:\(currentState)   init:\(initState)")
        if initState && !blockUpdate {
            drawScreen()
        }
    }
    
}
