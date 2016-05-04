//
//  ShiftSelection.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 4/7/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit

class ShiftSelection: NSObject {
    
    //Select Board Screen interface
    var items: [SKSpriteNode?]?
    var selector: SKSpriteNode?
    var selector_on: SKSpriteNode?
    var selectBoardButton: SKSpriteNode?
    var bigArrowLeft: SKSpriteNode?
    var bigArrowRight: SKSpriteNode?
    var blockArrows = false
    var selection = 0
    
    var backGroundSelect: SKSpriteNode?
    
    var scene: SKScene?
    
    var initPosSelector = CGFloat.init(-75)
    var spacesBetweenSelectors = CGFloat.init(25)

    
    //////SELECT BOAD SCREEN///////
    
    
    
    init(newScene: SKScene) {
        
        super.init()
        
        scene = newScene
        
        backGroundSelect = SKSpriteNode(color: orangeColorBackground, size: scene!.frame.size)
        backGroundSelect!.zPosition = 600
        backGroundSelect!.position = CGPointMake(scene!.frame.size.width/2, scene!.frame.size.height/2)

    }
    
    func createdItmes() {

        items = [SKSpriteNode]()
        selector_on = SKSpriteNode.init(imageNamed: "selector_on")
        
        if currentState == gameStates.SELECT_BOARD_SCREEN.hashValue {
            
            selection = boardSelected
            
            var item = SKSpriteNode.init(imageNamed: "turtle")
            items!.append(item)
            
            item = SKSpriteNode.init(imageNamed: "pyramid")
            items!.append(item)
            
            item = SKSpriteNode.init(imageNamed: "spider")
            items!.append(item)
            
            item = SKSpriteNode.init(imageNamed: "space_invaders")
            items!.append(item)
            
            item = SKSpriteNode.init(imageNamed: "ms_pacman")
            items!.append(item)
            
            item = SKSpriteNode.init(imageNamed: "mario_bros")
            items!.append(item)
            
            item = SKSpriteNode.init(imageNamed: "tetris")
            items!.append(item)
            
            initPosSelector = -75
            spacesBetweenSelectors = 25
            selector = SKSpriteNode.init(imageNamed: "selector_board")

        } else {
            
            selection = tilesSelected
            
            var item = SKSpriteNode.init(imageNamed: "tilesClassic")
            items!.append(item)
            
            item = SKSpriteNode.init(imageNamed: "tilesMemes")
            items!.append(item)
            
            initPosSelector = -48
            spacesBetweenSelectors = 96
            selector = SKSpriteNode.init(imageNamed: "selector")

        }
        
        for i in 0..<items!.count {
            items![i]!.position = CGPointMake(CGRectGetMaxX(scene!.frame) * CGFloat.init(i - selection) + CGRectGetMidX(scene!.frame), CGRectGetMidY(scene!.frame))
            items![i]!.zPosition = 601
        }
        
        selector!.position = CGPointMake(scene!.size.width/2, items![0]!.position.y - items![0]!.size.height/2 - 30)
        selector_on!.position = CGPointMake(scene!.size.width/2 + (initPosSelector + (spacesBetweenSelectors * CGFloat.init(selection))), items![0]!.position.y - items![0]!.size.height/2 - 30)
        selector!.zPosition = 601
        selector_on!.zPosition = selector!.zPosition + 1

    }
    
    
    func drawSelectScreen() {
        
        scene!.addChild(backGroundSelect!)
        drawBackButton(scene!)
        
        if initState {
            createdItmes()
            
            let moveLeft = UISwipeGestureRecognizer.init(target: self, action: #selector(moveBoardLeft(_:)))
            moveLeft.direction = .Left
            
            let moveRight = UISwipeGestureRecognizer.init(target: self, action: #selector(moveBoardRight(_:)))
            moveRight.direction = .Right
            
            scene!.view?.addGestureRecognizer(moveLeft)
            scene!.view?.addGestureRecognizer(moveRight)
                        
            bigArrowLeft = TextAndButtons.createdBigArrowButton(false)
            bigArrowRight = TextAndButtons.createdBigArrowButton(true)
            selectBoardButton = TextAndButtons.createdButton()
            
            initState = false
            
        }
        
        TextAndButtons.drawText("Select Board", size:40, position:CGPointMake(CGRectGetMidX(scene!.frame), scene!.frame.size.height/6 * 5), scene: scene!)
        
        for item in items! {
            scene!.addChild(item!)
        }

        scene!.addChild(selector!)
        scene!.addChild(selector_on!)
        
        TextAndButtons.drawButton(bigArrowLeft!, text:"", position:CGPointMake(bigArrowLeft!.size.width/2 + 10, CGRectGetMidY(scene!.frame)), scene:scene!)
        TextAndButtons.drawButton(bigArrowRight!, text:"", position:CGPointMake(CGRectGetMaxX(scene!.frame) - bigArrowRight!.size.width/2 - 10, CGRectGetMidY(scene!.frame)), scene:scene!)
        TextAndButtons.drawButton(selectBoardButton!, text:"Select", position:CGPointMake(CGRectGetMidX(scene!.frame), items![0]!.position.y - items![0]!.size.height/2 - 80), scene:scene!)
        
    }
    
    
    func updateSelectBoardScreen(point:CGPoint, ended:Bool) -> Bool{
        
        updateBackButton(point, ended: ended)
        
        if TextAndButtons.checkTouch(point, button: selectBoardButton!, ended: ended) {
            if ended {
                return true
            }
        }
        
        if !blockArrows && TextAndButtons.checkTouch(point, button: bigArrowLeft!, ended: ended) {
            if ended {
                shiftBoardToRight()
            }
        }
        
        if !blockArrows && TextAndButtons.checkTouch(point, button: bigArrowRight!, ended: ended) {
            if ended {
                shiftBoardToLeft()
            }
        }
        return false
    }
    
    
    func moveBoardLeft(gestureRecognizer: UISwipeGestureRecognizer) {
        // CGPoint location = [gestureRecognizer locationInView:self.view];
        // NSLog(@"location x:%f, y:%f", location.x, location.y);
        
        //   if(location.y + self.board0.size.height/2 >= self.board0.position.y - self.board0.size.height/2 && location.y  + self.board0.size.height/2 <= self.frame.size.height - self.board0.position.y + self.board0.size.height/2) {
        //if(!self.blockArrows && location.y <= self.board0.position.y + self.board0.size.height/2 && location.y >= self.board0.position.y - self.board0.size.height/2) {
        if !blockArrows {
            shiftBoardToLeft()
            print("board selected \(boardSelected)")
        }
    }
    
    
    func moveBoardRight(gestureRecognizer: UISwipeGestureRecognizer) {
        //CGPoint location = [gestureRecognizer locationInView:self.view];
        // NSLog(@"location x:%f, y:%f", location.x, location.y);
        
        //  if(location.y + self.board0.size.height/2 >= self.board0.position.y - self.board0.size.height/2 && location.y + self.board0.size.height/2 <= self.board0.position.y + self.board0.size.height/2) {
        //if(!self.blockArrows && location.y <= self.board0.position.y + self.board0.size.height/2 && location.y >= self.board0.position.y - self.board0.size.height/2) {
        if !blockArrows {
            shiftBoardToRight()
            print("board selected \(boardSelected)")
        }
    }
    
    
    func shiftBoardToLeft() {
        selection += 1
        blockArrows = true
        if selection >= items!.count {
            selection = 0
            
            selector_on!.position = CGPointMake(scene!.size.width/2 + initPosSelector, items![0]!.position.y - items![0]!.size.height/2 - 30)
            
            for i in 0..<items!.count {
                if i == 0 {
                    items![i]!.runAction(SKAction.sequence([
                        SKAction.moveToX(CGRectGetMaxX(scene!.frame) + CGRectGetMidX(scene!.frame), duration: 0),
                        SKAction.moveToX(CGRectGetMidX(scene!.frame), duration: 0.3)]))
                } else if i == items!.count - 1 {
                    items![i]!.runAction(SKAction.sequence([
                        SKAction.moveToX(items![i]!.position.x - CGRectGetMaxX(scene!.frame), duration: 0.3),
                        SKAction.moveToX(CGRectGetMaxX(scene!.frame) * CGFloat.init(i) + CGRectGetMidX(scene!.frame), duration: 0),
                        SKAction.runBlock({
                            self.blockArrows = false
                        })]))
                } else {
                    items![i]!.runAction(SKAction.moveToX(CGRectGetMaxX(scene!.frame) * CGFloat.init(i) + CGRectGetMidX(scene!.frame), duration:0))
                }
            }
            
        } else {
            
            selector_on!.position = CGPointMake(selector_on!.position.x + spacesBetweenSelectors, items![0]!.position.y - items![0]!.size.height/2 - 30)
            
            for i in 0..<items!.count {
                if i == items!.count - 1 {
                    items![i]!.runAction(SKAction.sequence([
                        SKAction.moveToX(items![i]!.position.x - CGRectGetMaxX(scene!.frame), duration:0.3),
                        SKAction.runBlock({
                            self.blockArrows = false
                        })]))
                } else {
                    items![i]!.runAction(SKAction.moveToX(items![i]!.position.x - CGRectGetMaxX(scene!.frame), duration:0.3))
                }
            }
        }
        if currentState == gameStates.SELECT_BOARD_SCREEN.hashValue {
            boardSelected = selection
        } else {
            tilesSelected = selection
        }
    }
    
    
    func shiftBoardToRight() {
        selection -= 1
        blockArrows = true
        if selection <= -1 {
            selection = items!.count - 1
            
            selector_on!.position = CGPointMake(scene!.size.width/2 + (initPosSelector + (spacesBetweenSelectors * CGFloat.init(selection))), items![0]!.position.y - items![0]!.size.height/2 - 30)
            
            for i in 0..<items!.count {
                if i == 0 {
                    items![i]!.runAction(SKAction.sequence([
                        SKAction.moveToX(items![i]!.position.x + CGRectGetMaxX(scene!.frame), duration: 0.3),
                        SKAction.moveToX(CGRectGetMaxX(scene!.frame) * -CGFloat.init((items!.count - 2 - i)) - CGRectGetMidX(scene!.frame), duration: 0)]))
                } else if i == items!.count - 1 {
                    items![i]!.runAction(SKAction.sequence([
                        SKAction.moveToX(-CGRectGetMidX(scene!.frame), duration: 0),
                        SKAction.moveToX(CGRectGetMidX(scene!.frame), duration: 0.3),
                        SKAction.runBlock({
                            self.blockArrows = false
                        })]))
                } else {
                    items![i]!.runAction(SKAction.moveToX(CGRectGetMaxX(scene!.frame) * -CGFloat.init((items!.count - 2 - i)) - CGRectGetMidX(scene!.frame), duration:0))
                }
            }
            
        } else {
            selector_on!.position = CGPointMake(selector_on!.position.x - spacesBetweenSelectors, items![0]!.position.y - items![0]!.size.height/2 - 30)
            
            for i in 0..<items!.count {
                if i == items!.count - 1 {
                    items![i]!.runAction(SKAction.sequence([
                        SKAction.moveToX(items![i]!.position.x + CGRectGetMaxX(scene!.frame), duration:0.3),
                        SKAction.runBlock({
                            self.blockArrows = false
                        })]))
                } else {
                    items![i]!.runAction(SKAction.moveToX(items![i]!.position.x + CGRectGetMaxX(scene!.frame), duration:0.3))
                }
            }
        }
        
        if currentState == gameStates.SELECT_BOARD_SCREEN.hashValue {
            boardSelected = selection
        } else {
            tilesSelected = selection
        }
    }
    
    //////SELECT BOAD SCREEN///////
    

}