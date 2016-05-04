//
//  InGameMenu.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 4/5/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit


class InGameMenu {
    
    var buttonMark: SKSpriteNode?
    var buttonMusic: SKSpriteNode?
    var ficha01: SKSpriteNode?
    var ficha02: SKSpriteNode?
    var ficha03: SKSpriteNode?
    var buttonResume: SKSpriteNode?
    var buttonSelectTiles: SKSpriteNode?
    var buttonHelp: SKSpriteNode?
    var buttonExit: SKSpriteNode?
    var backGround2: SKSpriteNode?
    
    //Exit windows
    var exitWindow: SKSpriteNode?
    var buttonYes: SKSpriteNode?
    var buttonNo: SKSpriteNode?
    
    var inGameMenuHelp: Help?
    var inGameSelectToken: ShiftSelection?
    
    init(scene: GameplayScene) {
    
        backGround2 = SKSpriteNode(color: orangeColorBackground, size: scene.frame.size)
        backGround2!.anchorPoint = CGPointMake(0, 0)
    
        let menuDecoLeft = SKSpriteNode.init(imageNamed: "menu_deco")
        menuDecoLeft.size = CGSizeMake(menuDecoLeft.size.width, backGround2!.size.height)
        let menuDecoRight = SKSpriteNode.init(imageNamed: "menu_deco")
        menuDecoRight.size = CGSizeMake(menuDecoRight.size.width, backGround2!.size.height)
        menuDecoRight.zRotation = CGFloat.init(M_PI)
    
        loadMarkTokens(scene)
    
        if scene.board.showSelectableTokens {
            buttonMark = SKSpriteNode.init(imageNamed: "switch_on")
        } else {
            buttonMark = SKSpriteNode.init(imageNamed: "switch_off")
        }
    
        if scene.soundManager!.activeSounds {
            buttonMusic = SKSpriteNode.init(imageNamed: "music_on")
        } else {
            buttonMusic = SKSpriteNode.init(imageNamed: "music_off")
        }
    
        buttonResume = TextAndButtons.createdButton()
        buttonSelectTiles = TextAndButtons.createdButton()
        buttonHelp = TextAndButtons.createdButton()
        buttonExit = TextAndButtons.createdButton()
    
        backGround2!.position = CGPointMake(CGRectGetMaxX(scene.frame), 0)
        menuDecoLeft.position = CGPointMake(menuDecoLeft.size.width/2, CGRectGetMidY(scene.frame))
        menuDecoRight.position = CGPointMake(CGRectGetMaxX(scene.frame) - menuDecoRight.size.width/2, CGRectGetMidY(scene.frame));
        
        buttonMusic!.position = CGPointMake(scene.frame.size.width/3, (CGRectGetMaxY(scene.frame) / 6) * 4)
        buttonMark!.position = CGPointMake(scene.frame.size.width/1.5, ficha01!.position.y - ficha01!.size.height/2 - buttonMark!.size.height/2 - 10)
        
        backGround2!.zPosition = 610
        
        TextAndButtons.drawText("OPTIOS", size: 40, position: CGPointMake(CGRectGetMidX(scene.frame), (CGRectGetMaxY(scene.frame) / 6) * 5.5), scene: backGround2!)
        
        backGround2!.addChild(menuDecoLeft)
        backGround2!.addChild(menuDecoRight)
        backGround2!.addChild(buttonMusic!)
        backGround2!.addChild(buttonMark!)
        
        //30 in the position is for the font size
        TextAndButtons.drawText("Sound:", size: 30, position: CGPointMake(scene.frame.size.width/3, buttonMusic!.position.y + buttonMusic!.size.height/2 + 30 / 2 + 15), scene: backGround2!)
        //30 in the position is for the font size
        TextAndButtons.drawText("Highlight:", size: 30, position: CGPointMake(scene.frame.size.width/1.5, ficha01!.position.y + ficha01!.size.height / 2 + 30 / 2), scene: backGround2!)
        TextAndButtons.drawButton(buttonResume!, text: "Resume Game", position: CGPointMake(CGRectGetMidX(scene.frame), (CGRectGetMaxY(scene.frame) / 8) * 4), scene: backGround2!)
        TextAndButtons.drawButton(buttonSelectTiles!, text: "Select Tiles", position: CGPointMake(CGRectGetMidX(scene.frame), (CGRectGetMaxY(scene.frame) / 8) * 3), scene: backGround2!)
        TextAndButtons.drawButton(buttonHelp!, text: "Help", position: CGPointMake(CGRectGetMidX(scene.frame), (CGRectGetMaxY(scene.frame) / 8) * 2), scene: backGround2!)
        TextAndButtons.drawButton(buttonExit!, text: "Exit Game", position: CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMaxY(scene.frame) / 8), scene: backGround2!)
        
        //in game menu help screen
        inGameMenuHelp = Help(scene: scene)
        
        //In game menu select token screen
        inGameSelectToken = ShiftSelection(newScene: scene)
        
    }
    
    
    func showInGameMenu() {
        backGround2!.runAction(SKAction.moveToX(0, duration: MENU_SPEED))
    }
    
    
    func loadMarkTokens(scene: GameplayScene) {
        
        if(tilesSelected == 0) {
            ficha01 = SKSpriteNode.init(imageNamed: "ficha0")
            ficha02 = SKSpriteNode.init(imageNamed: "ficha8")
            ficha03 = SKSpriteNode.init(imageNamed: "ficha11")
        } else {
            ficha01 = SKSpriteNode.init(imageNamed: "fichaM0")
            ficha02 = SKSpriteNode.init(imageNamed: "fichaM8")
            ficha03 = SKSpriteNode.init(imageNamed: "fichaM11")
        }
    
        ficha01!.position = CGPointMake(scene.frame.size.width/1.5 - ficha01!.size.width, ((CGRectGetMaxY(scene.frame) / 6) * 4) + 30)
        ficha02!.position = CGPointMake(scene.frame.size.width/1.5 - 9, ((CGRectGetMaxY(scene.frame) / 6) * 4) + 30)
        ficha03!.position = CGPointMake(scene.frame.size.width/1.5 - 9 + ficha01!.size.width - 9, ((CGRectGetMaxY(scene.frame) / 6) * 4) + 30)
    
        let colorRandom = arc4random() % 4
        let  color: SKColor
        switch colorRandom {
        case 0:
            color = SKColor.redColor()
            break
        case 1:
            color = SKColor.blueColor()
            break
        case 2:
            color = SKColor.yellowColor()
            break
        case 3:
            color = SKColor.purpleColor()
            break
        default:
            color = SKColor.yellowColor()
        }
        ficha01!.color = color
        ficha02!.color = color
        ficha03!.color = color
        ficha01!.colorBlendFactor = 0.35
        if scene.board.showSelectableTokens {
            ficha02!.colorBlendFactor = 0.1
        } else {
            ficha02!.colorBlendFactor = 0.35
        }
        ficha03!.colorBlendFactor = 0.35
        
        ficha01!.zPosition = 600
        ficha02!.zPosition = ficha01!.zPosition + 1
        ficha03!.zPosition = ficha02!.zPosition + 1
        
        backGround2!.addChild(ficha01!)
        backGround2!.addChild(ficha02!)
        backGround2!.addChild(ficha03!)
    }
    
    func drawInGameMenu(scene: GameplayScene) {
    
      //  if(self.helpState == NO && self.selectTokenState == NO) {
      //  scene.addChild(backGround2!)

//        } else if( self.helpState) {
//            [self drawHelpScreen:scene];
//        } else if(self.selectTokenState) {
//            [self drawSelectTokenScreen:scene];
//        }
//    

//        

        switch currentState {
        case gameStates.IN_GAME_MENU.hashValue:
            
            scene.addChild(backGround2!)
            
            //if let windows = exitWindow {
               // backGround2!.addChild(windows)
            //}
            break
        case gameStates.IN_GAME_MENU_HELP.hashValue:
            inGameMenuHelp!.drawHelpScreen(tilesSelected, scene: scene)
            break
        case gameStates.IN_GAME_MENU_SELECT_TOKEN.hashValue:
            inGameSelectToken!.drawSelectScreen()
        default:
            scene.addChild(backGround2!)
            break
        }

    }
    
    
    func exitWindowInScene(scene: GameplayScene) {
        
        exitWindow = SKSpriteNode.init(imageNamed: "exitFrame")
        exitWindow!.position = CGPointMake(CGRectGetMidX(scene.frame), CGRectGetMidY(scene.frame))
        exitWindow!.zPosition = 604
    
        TextAndButtons.drawText("Are your sure?", size: 30, position: CGPointMake(0, 100), scene: exitWindow!)
        
        buttonYes = TextAndButtons.createdButton()
        TextAndButtons.drawButton(buttonYes!, text: "Yes", position: CGPointMake(0, 0), scene: exitWindow!)
        
        buttonNo = TextAndButtons.createdButton()
        TextAndButtons.drawButton(buttonNo!, text: "No", position: CGPointMake(0, -100), scene: exitWindow!)

        exitWindow!.setScale(0)
    
        let action1 = SKAction.scaleTo(1.2, duration: 0.5)
        let action2 = SKAction.scaleTo(1.0, duration: 0.2)
    
        exitWindow!.runAction(SKAction.sequence([action1, action2]))
    
        backGround2!.addChild(exitWindow!)
    }
    
    
    func touchScreen(location: CGPoint, scene: GameplayScene, ended: Bool) {
        
        if let _ = exitWindow {
            
            //some strange point fixeds
            let point = CGPointMake(location.x - scene.size.width / 2.0, location.y - scene.size.height / 2.0)
            
            //Yes Button
            if TextAndButtons.checkTouch(point, button: buttonYes!, ended: ended) {
                if ended {
                    scene.blockUpdate = true
                    let transition = SKTransition.doorsCloseHorizontalWithDuration(1.5)
                    let toMainMenu = MainMenuScene(size: scene.size, music: scene.soundManager!.activeSounds, mark: scene.board.showSelectableTokens)
                    scene.view?.presentScene(toMainMenu, transition: transition)
                }
            }
            //No Button
            if TextAndButtons.checkTouch(point, button: buttonNo!, ended: ended) {
                if ended {
                    exitWindow!.removeFromParent()
                    exitWindow = nil
                }
            }
        } else {
            if currentState == gameStates.IN_GAME_MENU.hashValue {
                
                if ended {
                    
                    //Sound Button
                    if (location.x > buttonMusic!.position.x - buttonMusic!.size.width/2 && location.x < buttonMusic!.position.x + buttonMusic!.size.width/2) {
                        if(location.y < buttonMusic!.position.y + buttonMusic!.size.height/2 && location.y > buttonMusic!.position.y - buttonMusic!.size.height/2) {
                            
                            buttonMusic!.removeFromParent()
                            
                            if scene.soundManager!.activeSounds {
                                scene.soundManager!.activeSounds = false
                                buttonMusic = SKSpriteNode.init(imageNamed: "music_off")
                            } else {
                                scene.soundManager!.activeSounds = true
                                buttonMusic = SKSpriteNode.init(imageNamed: "music_on")
                                scene.soundManager!.playSound("select.m4a", scene: scene)
                            }
                            
                            buttonMusic!.position = CGPointMake(scene.frame.size.width / 3, (CGRectGetMaxY(scene.frame) / 6) * 4)
                            backGround2!.addChild(buttonMusic!)
                            
                        }
                        
                    }
                    
                    //Mark Button
                    if (location.x > ficha01!.position.x - ficha01!.size.width/2 && location.x < ficha03!.position.x + ficha03!.size.width/2) {
                        if(location.y < ficha01!.position.y + ficha01!.size.height/2 && location.y > buttonMark!.position.y - buttonMark!.size.height/2) {
                            
                            buttonMark!.removeFromParent()
                            
                            if (scene.board.showSelectableTokens) {
                                scene.board.showSelectableTokens = false
                                buttonMark! = SKSpriteNode.init(imageNamed: "switch_off")
                                ficha02!.colorBlendFactor = 0.35
                            } else {
                                scene.board.showSelectableTokens = true
                                buttonMark! = SKSpriteNode.init(imageNamed: "switch_on")
                                ficha02!.colorBlendFactor = 0.1
                            }
                            scene.updateBoard()
                            buttonMark!.position = CGPointMake(scene.frame.size.width/1.5, ficha01!.position.y - ficha01!.size.height/2 - buttonMark!.size.height/2 - 10)
                            
                            backGround2!.addChild(buttonMark!)
                            
                        }
                    }
                    
                }
                
                //Resume Button
                if TextAndButtons.checkTouch(location, button: buttonResume!, ended: ended) {
                    if ended {
                        backGround2!.runAction(SKAction.sequence([
                            SKAction.moveToX(CGRectGetMaxX(scene.frame), duration: MENU_SPEED),
                            SKAction.runBlock({
                                changeState(gameStates.STATE_GAMEPLAY.hashValue)
                            })]))
                    }
                }
                //Select Tiles Button
                if TextAndButtons.checkTouch(location, button: buttonSelectTiles!, ended: ended) {
                    if ended {
                        changeState(gameStates.IN_GAME_MENU_SELECT_TOKEN.hashValue)
                    }
                }
                //Help Button
                if TextAndButtons.checkTouch(location, button: buttonHelp!, ended: ended) {
                    if ended {
                        changeState(gameStates.IN_GAME_MENU_HELP.hashValue)
                    }
                }
                //Exit Button
                if TextAndButtons.checkTouch(location, button: buttonExit!, ended: ended) {
                    if ended {
                        exitWindowInScene(scene)
                    }
                }
            } else if currentState == gameStates.IN_GAME_MENU_HELP.hashValue {
                inGameMenuHelp!.updateHelpScreen(location, ended: ended)

            } else if currentState == gameStates.IN_GAME_MENU_SELECT_TOKEN.hashValue {
                if inGameSelectToken!.updateSelectBoardScreen(location, ended: ended) {
                    
                    for z in 0..<scene.tilesInBoard!.count {
                        for i in 0..<scene.tilesInBoard![z].count {
                            for j in 0..<scene.tilesInBoard![z][i].count {
                                if let _ = scene.tilesInBoard![z][i][j] {
                                    scene.tilesInBoard![z][i][j] = scene.board.createdFicha(z, posX: i, posY: j)
                                }
                            }
                        }
                    }
                    scene.updateBoard()
                    ficha01!.removeFromParent()
                    ficha02!.removeFromParent()
                    ficha03!.removeFromParent()
                    loadMarkTokens(scene)
                    pullState()
                }
            }
        }
    }
    
    

}

