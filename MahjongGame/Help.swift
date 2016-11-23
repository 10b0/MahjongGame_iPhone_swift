//
//  File.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 4/4/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit

class Help {
    
    //Help
    let HELP_PAGES_MAX = 3
    
    //help interface
    var pageNum = 0
    var colorRandom = 0
    var previousButton: SKSpriteNode?
    var nextButton: SKSpriteNode?
    var hintButton: SKSpriteNode?
    var undoButton: SKSpriteNode?
    
    //help animation
    var ficha1: SKSpriteNode?
    var ficha2: SKSpriteNode?
    var hand: SKSpriteNode?
    var handLike: SKSpriteNode?
    var handPress1: SKSpriteNode?
    
    var color: SKColor?
    
    var backGroundHelp: SKSpriteNode?
    
    init(scene: SKNode) {
        backGroundHelp = SKSpriteNode(color: orangeColorBackground, size: scene.frame.size)
        backGroundHelp!.zPosition = 600
        backGroundHelp!.position = CGPoint(x: scene.frame.size.width/2, y: scene.frame.size.height/2)
        
        pageNum = 0
    }
    //////HELP SCREEN///////
    
    func drawHelpScreen(_ tilesSelected: Int, scene: SKNode) {
        
        
        scene.addChild(backGroundHelp!)
        drawBackButton(scene)
        
        if initState {
            initState = false

            if pageNum <= 0 {
                // Animation
                if tilesSelected == tilesSet.original.hashValue {
                    ficha1 = SKSpriteNode(imageNamed: "ficha0")
                    ficha2 = SKSpriteNode(imageNamed: "ficha0")
                } else {
                    ficha1 = SKSpriteNode(imageNamed: "fichaM0")
                    ficha2 = SKSpriteNode(imageNamed: "fichaM0")
                }
                hand = SKSpriteNode(imageNamed: "hand")
                handPress1 = SKSpriteNode(imageNamed: "hand_press")
                handLike = SKSpriteNode(imageNamed: "hand_like")
                
                ficha1!.position = CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2, y: scene.frame.size.height/6 * 2);
                ficha2!.position = CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2 + ficha1!.size.width - 9, y: scene.frame.size.height/6 * 2);
                
                hand!.position = CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2 + ficha1!.size.width - 9 + ficha1!.size.width/2 + 60, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/4);
                handPress1!.position = CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2 + ficha1!.size.width - 9 + ficha1!.size.width/2, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/4);
                handLike!.position = CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2 + ficha1!.size.width/2, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/4);
                
                ficha1!.zPosition = 601
                ficha2!.zPosition = ficha1!.zPosition + 1
                hand!.zPosition = ficha2!.zPosition + 1
                handPress1!.zPosition = hand!.zPosition + 1
                handLike!.zPosition = handPress1!.zPosition + 1
                
                colorRandom = Int.init(arc4random() % 4)
                switch colorRandom {
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
                
                ficha1!.color = color!
                ficha2!.color = color!
                ficha1!.colorBlendFactor = 0.35
                ficha2!.colorBlendFactor = 0.35
                
                let handInitPos = SKAction.move(to: CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2 + ficha1!.size.width - 16 + ficha1!.size.width/2 + 60, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/4), duration: 0)
                let moveHandPos2 = SKAction.move(to: CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2 + ficha1!.size.width - 16 + ficha1!.size.width/2, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/4), duration: 0.3)
                let moveHandPos3 = SKAction.move(to: CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width/2 + ficha1!.size.width/2, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/4), duration:0.3)
                let waith1 = SKAction.wait(forDuration: 1)
                let waith0_3 = SKAction.wait(forDuration: 0.3)
                let changeColor = SKAction.colorize(with: UIColor.green, colorBlendFactor: 0.7, duration: 0)
                let restoreColor = SKAction.colorize(with: color!, colorBlendFactor: 0.35, duration: 0)
                let deleteFicha = SKAction.scale(to: 0, duration: 0.3)
                let restoreFicha = SKAction.scale(to: 1, duration: 0)
                let hide = SKAction.hide()
                let unhide = SKAction.unhide()
                
                // 3 3 1 3 3 3 1
                // 3 3 1 3 3 3 1
                let aFicha2 = SKAction.sequence([waith0_3, changeColor, waith0_3, waith1, waith0_3, deleteFicha, waith0_3, waith1, restoreColor, restoreFicha])
                let aFicha1 = SKAction.sequence([waith0_3, waith0_3, waith1, waith0_3, changeColor, deleteFicha, waith0_3, waith1, restoreColor, restoreFicha])
                let aHand1 = SKAction.sequence([moveHandPos2, hide, waith0_3, unhide, waith1, moveHandPos3, hide, waith0_3, unhide, waith0_3, hide, waith1, handInitPos, unhide])
                let aHandPress1 = SKAction.sequence([hide, waith0_3, unhide, waith0_3, hide, waith1, moveHandPos3, unhide, waith0_3, hide, moveHandPos2, waith1])
                let aHandLike1 = SKAction.sequence([hide, waith0_3, waith0_3, waith1, waith0_3, waith0_3, waith0_3, unhide, waith1])
                
                ficha1!.run(SKAction.repeatForever(aFicha1))
                ficha2!.run(SKAction.repeatForever(aFicha2))
                hand!.run(SKAction.repeatForever(aHand1))
                handPress1!.run(SKAction.repeatForever(aHandPress1))
                handLike!.run(SKAction.repeatForever(aHandLike1))
                
                previousButton = TextAndButtons.createdArrowButton(false)
                nextButton = TextAndButtons.createdArrowButton(true)
                undoButton = TextAndButtons.createdSmallButton()
                hintButton = TextAndButtons.createdSmallButton()
            }
            
        }
        
        TextAndButtons.drawText("Help", size:40, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 5), scene:scene)
            
        TextAndButtons.drawButton(previousButton!, text:"previous", position:CGPoint(x: scene.frame.size.width/2 - previousButton!.size.width/2 - 60, y: previousButton!.size.height + 15), scene:scene)
        TextAndButtons.drawButton(nextButton!, text:"next", position:CGPoint(x: scene.frame.size.width/2 + nextButton!.size.width/2 + 60, y: nextButton!.size.height + 15), scene:scene)
        
        if pageNum <= 0
        {
            TextAndButtons.drawText("Remove all the tiles to win!!", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 4.5), scene:scene)
            TextAndButtons.drawText("How you can remove the tiles?", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 4), scene:scene)
            TextAndButtons.drawText("You can remove pair of tiles ", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 3.5), scene:scene)
            TextAndButtons.drawText("of the same figure by selecting them.", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 3), scene:scene)
            
            scene.addChild(ficha1!)
            scene.addChild(ficha2!)
            scene.addChild(hand!)
            scene.addChild(handPress1!)
            scene.addChild(handLike!)
            
        } else if pageNum == 1 {
            
            TextAndButtons.drawText("But you only can remove them if the tiles", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 4.5), scene:scene)
            TextAndButtons.drawText("have one of their side left or right free of other", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 4), scene:scene)
            TextAndButtons.drawText("tile or do not have other tile above of them.", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 3.5), scene:scene)
            
            let ficha1: SKSpriteNode?
            let ficha2: SKSpriteNode?
            let ficha3: SKSpriteNode?
            
            let ficha4: SKSpriteNode?
            let ficha5: SKSpriteNode?
            let ficha6: SKSpriteNode?
            let ficha7: SKSpriteNode?
            
            let ficha8: SKSpriteNode?
            let ficha9: SKSpriteNode?
            let ficha10: SKSpriteNode?
            let ficha11: SKSpriteNode?
            let ficha12: SKSpriteNode?
            
            
            if tilesSelected == tilesSet.original.hashValue {
                ficha1 = SKSpriteNode(imageNamed: "ficha0")
                ficha2 = SKSpriteNode(imageNamed: "ficha8")
                ficha3 = SKSpriteNode(imageNamed: "ficha11")
                
                ficha4 = SKSpriteNode(imageNamed: "ficha0")
                ficha5 = SKSpriteNode(imageNamed: "ficha4")
                ficha6 = SKSpriteNode(imageNamed: "ficha8")
                ficha7 = SKSpriteNode(imageNamed: "ficha11")
                
                ficha8 = SKSpriteNode(imageNamed: "ficha0")
                ficha9 = SKSpriteNode(imageNamed: "ficha4")
                ficha10 = SKSpriteNode(imageNamed: "ficha8")
                ficha11 = SKSpriteNode(imageNamed: "ficha11")
                ficha12 = SKSpriteNode(imageNamed: "ficha9")
                
            } else {
                ficha1 = SKSpriteNode(imageNamed: "fichaM0")
                ficha2 = SKSpriteNode(imageNamed: "fichaM8")
                ficha3 = SKSpriteNode(imageNamed: "fichaM11")
                
                ficha4 = SKSpriteNode(imageNamed: "fichaM0")
                ficha5 = SKSpriteNode(imageNamed: "fichaM4")
                ficha6 = SKSpriteNode(imageNamed: "fichaM8")
                ficha7 = SKSpriteNode(imageNamed: "fichaM11")
                
                ficha8 = SKSpriteNode(imageNamed: "fichaM0")
                ficha9 = SKSpriteNode(imageNamed: "fichaM4")
                ficha10 = SKSpriteNode(imageNamed: "fichaM8")
                ficha11 = SKSpriteNode(imageNamed: "fichaM11")
                ficha12 = SKSpriteNode(imageNamed: "fichaM9")
                
            }
            
            let yes1 = SKSpriteNode.init(imageNamed: "yes")
            let no1 = SKSpriteNode.init(imageNamed: "no")
            let yes2 = SKSpriteNode.init(imageNamed: "yes")
            
            let yes3 = SKSpriteNode.init(imageNamed: "yes")
            let no2 = SKSpriteNode.init(imageNamed: "no")
            let no3 = SKSpriteNode.init(imageNamed: "no")
            let yes4 = SKSpriteNode.init(imageNamed: "yes")
            
            let no4 = SKSpriteNode.init(imageNamed: "no")
            let no5 = SKSpriteNode.init(imageNamed: "no")
            let no6 = SKSpriteNode.init(imageNamed: "no")
            let no7 = SKSpriteNode.init(imageNamed: "no")
            let yes5 = SKSpriteNode.init(imageNamed: "yes")
            
            ficha1!.color = color!
            ficha2!.color = color!
            ficha3!.color = color!
            ficha4!.color = color!
            ficha5!.color = color!
            ficha6!.color = color!
            ficha7!.color = color!
            ficha8!.color = color!
            ficha9!.color = color!
            ficha10!.color = color!
            ficha11!.color = color!
            
            switch colorRandom {
            case 0:
                ficha12!.color = SKColor.blue
            case 1:
                ficha12!.color = SKColor.yellow
            case 2:
                ficha12!.color = SKColor.purple
            case 3:
                ficha12!.color = SKColor.red
            default:
                ficha1!.color = SKColor.yellow
                ficha2!.color = SKColor.yellow
                ficha3!.color = SKColor.yellow
                ficha4!.color = SKColor.yellow
                ficha5!.color = SKColor.yellow
                ficha6!.color = SKColor.yellow
                ficha7!.color = SKColor.yellow
                ficha8!.color = SKColor.yellow
                ficha9!.color = SKColor.yellow
                ficha10!.color = SKColor.yellow
                ficha11!.color = SKColor.yellow
                ficha12!.color = SKColor.yellow
            }
            
            ficha1!.colorBlendFactor = 0.35;
            ficha2!.colorBlendFactor = 0.1;
            ficha3!.colorBlendFactor = 0.35;
            ficha4!.colorBlendFactor = 0.35;
            ficha5!.colorBlendFactor = 0.1;
            ficha6!.colorBlendFactor = 0.1;
            ficha7!.colorBlendFactor = 0.35;
            ficha8!.colorBlendFactor = 0.1;
            ficha9!.colorBlendFactor = 0.1;
            ficha10!.colorBlendFactor = 0.1;
            ficha11!.colorBlendFactor = 0.1;
            ficha12!.colorBlendFactor = 0.35;
            
            
            ficha1!.position = CGPoint(x: scene.frame.size.width/4 - ficha1!.size.width, y: scene.frame.size.height/6 * 2)
            ficha2!.position = CGPoint(x: scene.frame.size.width/4 - 9, y: scene.frame.size.height/6 * 2)
            ficha3!.position = CGPoint(x: scene.frame.size.width/4 - 9 + ficha1!.size.width - 9, y: scene.frame.size.height/6 * 2)
            yes1.position = CGPoint(x: scene.frame.size.width/4 - ficha1!.size.width, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/3)
            no1.position = CGPoint(x: scene.frame.size.width/4 - 9, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/3)
            yes2.position = CGPoint(x: scene.frame.size.width/4 - 9 + ficha1!.size.width - 9, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/3)
            
            ficha1!.zPosition = 601
            ficha2!.zPosition = ficha1!.zPosition + 1
            ficha3!.zPosition = ficha2!.zPosition + 1
            yes1.zPosition = ficha3!.zPosition + 1
            no1.zPosition = yes1.zPosition + 1
            yes2.zPosition = no1.zPosition + 1
            
            scene.addChild(ficha1!)
            scene.addChild(ficha2!)
            scene.addChild(ficha3!)
            scene.addChild(yes1)
            scene.addChild(no1)
            scene.addChild(yes2)
            
            
            ficha4!.position = CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width, y: scene.frame.size.height/6 * 2)
            ficha5!.position = CGPoint(x: scene.frame.size.width/2 - 9, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/2 - 4.5)
            ficha6!.position = CGPoint(x: scene.frame.size.width/2 - 9, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/2 + 4.5)
            ficha7!.position = CGPoint(x: scene.frame.size.width/2 - 9 + ficha1!.size.width - 9, y: scene.frame.size.height/6 * 2)
            
            yes3.position = CGPoint(x: scene.frame.size.width/2 - ficha1!.size.width, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/3)
            no2.position = CGPoint(x: scene.frame.size.width/2 - 9, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/2 - 4.5 + ficha1!.size.height/3)
            no3.position = CGPoint(x: scene.frame.size.width/2 - 9, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/2 + 9 - ficha1!.size.height/3)
            yes4.position = CGPoint(x: scene.frame.size.width/2 - 9 + ficha1!.size.width - 9, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/3)
            
            ficha4!.zPosition = 601
            ficha5!.zPosition = ficha4!.zPosition + 1
            ficha6!.zPosition = ficha5!.zPosition + 1
            ficha7!.zPosition = ficha6!.zPosition + 1
            yes3.zPosition = ficha6!.zPosition + 1
            no2.zPosition = yes3.zPosition + 1
            no3.zPosition = no2.zPosition + 1
            yes4.zPosition = no3.zPosition + 1
            
            scene.addChild(ficha4!)
            scene.addChild(ficha5!)
            scene.addChild(ficha6!)
            scene.addChild(ficha7!)
            scene.addChild(yes3)
            scene.addChild(no2)
            scene.addChild(no3)
            scene.addChild(yes4)
            
            
            ficha8!.position = CGPoint(x: scene.frame.size.width/1.35 - ficha1!.size.width/2 + 4.5, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/2 - 4.5)
            ficha9!.position = CGPoint(x: scene.frame.size.width/1.35 - ficha1!.size.width/2 + 4.5, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/2 + 4.5)
            ficha10!.position = CGPoint(x: scene.frame.size.width/1.35 + ficha1!.size.width/2 - 4.5, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/2 - 4.5)
            ficha11!.position = CGPoint(x: scene.frame.size.width/1.35 + ficha1!.size.width/2 - 4.5, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/2 + 4.5)
            ficha12!.position = CGPoint(x: scene.frame.size.width/1.35 - 4.5, y: scene.frame.size.height/6 * 2 + 4.5)
            no4.position = CGPoint(x: scene.frame.size.width/1.35 - ficha1!.size.width/2 + 4.5, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/2 - 4.5 + ficha1!.size.height/3)
            no5.position = CGPoint(x: scene.frame.size.width/1.35 - ficha1!.size.width/2 + 4.5, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/2 + 9 - ficha1!.size.height/3)
            no6.position = CGPoint(x: scene.frame.size.width/1.35 + ficha1!.size.width/2 - 4.5, y: scene.frame.size.height/6 * 2 + ficha1!.size.height/2 - 4.5 + ficha1!.size.height/3)
            no7.position = CGPoint(x: scene.frame.size.width/1.35 + ficha1!.size.width/2 - 4.5, y: scene.frame.size.height/6 * 2 - ficha1!.size.height/2 + 9 - ficha1!.size.height/3)
            yes5.position = CGPoint(x: scene.frame.size.width/1.35 - 4.5, y: scene.frame.size.height/6 * 2 + 4.5 + ficha1!.size.height/3)
            
            ficha8!.zPosition = 601
            ficha9!.zPosition = ficha8!.zPosition + 1
            ficha10!.zPosition = ficha9!.zPosition + 1
            ficha11!.zPosition = ficha10!.zPosition + 1
            ficha12!.zPosition = ficha11!.zPosition + 1
            no4.zPosition = ficha12!.zPosition + 1
            no5.zPosition = no4.zPosition + 1
            no6.zPosition = no5.zPosition + 1
            no7.zPosition = no6.zPosition + 1
            yes5.zPosition = no7.zPosition + 1
            
            scene.addChild(ficha8!)
            scene.addChild(ficha9!)
            scene.addChild(ficha10!)
            scene.addChild(ficha11!)
            scene.addChild(ficha12!)
            scene.addChild(no4)
            scene.addChild(no5)
            scene.addChild(no6)
            scene.addChild(no7)
            scene.addChild(yes5)
            
        } else if pageNum == 2 {
            
            TextAndButtons.drawButton(undoButton!, text:"Undo", position:CGPoint(x: scene.frame.size.width/2, y: scene.frame.size.height/6 * 4), scene:scene)
            
            TextAndButtons.drawText("Remove some tiles you don’t want to,", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 3), scene:scene)
            TextAndButtons.drawText("no problem, press the undo button to", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 2.5), scene:scene)
            TextAndButtons.drawText("undo your last movement.", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 2), scene:scene)
            
        } else if pageNum >= 3 {
            
            TextAndButtons.drawButton(hintButton!, text:"Hint", position:CGPoint(x: scene.frame.size.width/2, y: scene.frame.size.height/6 * 4), scene:scene)
            
            TextAndButtons.drawText("If you get stock and want help,", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 3), scene:scene)
            TextAndButtons.drawText("you always can press the hint button", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 2.5), scene:scene)
            TextAndButtons.drawText("and show you what tiles can remove.", size:30, position:CGPoint(x: scene.frame.midX, y: scene.frame.size.height/6 * 2), scene:scene)
        }
        
        TextAndButtons.drawText("Page", size:30, position:CGPoint(x: scene.frame.size.width/2, y: previousButton!.size.height + 30), scene:scene)
        TextAndButtons.drawText("\(pageNum + 1) / \(HELP_PAGES_MAX + 1)", size:30, position:CGPoint(x: scene.frame.size.width/2, y: previousButton!.size.height), scene:scene)
    }
    
    
    func updateHelpScreen(_ point: CGPoint, ended: Bool) {
        updateBackButton(point, ended: ended)
        
        
        if TextAndButtons.checkTouch(point, button: previousButton!, ended: ended) {
            if ended {
                pageNum -= 1
                
                if pageNum < 0 {
                    pageNum = HELP_PAGES_MAX
                }
                
                initState = true
            }
        }
        
        if TextAndButtons.checkTouch(point, button: nextButton!, ended: ended) {
            if ended {
                pageNum += 1
                
                if pageNum > HELP_PAGES_MAX {
                    pageNum = 0
                }
                
                initState = true
            }
        }
        
    }
    
    //////HELP SCREEN///////

    
}
