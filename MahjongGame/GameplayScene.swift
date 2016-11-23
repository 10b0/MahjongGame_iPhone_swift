//
//  GameplayScene.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 3/31/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit

class GameplayScene: SKScene {

    var select = false
    var board = Board()
    var gameOver = false
    var scanBoard = false
    var deletedAnimationCount = 0
    var tilesInBoard: [[[Ficha?]]]?
    var fichaOldSelected: Ficha?
    var fichaNewSelected: Ficha?
    var undoArray = [Ficha?]()
    var inGameMenu: InGameMenu?
    
    let background = SKSpriteNode.init(imageNamed: "background")
    let buttonUndo = TextAndButtons.createdSmallButton()
    let buttonPause = TextAndButtons.createdSmallButton()
    let buttonHint = TextAndButtons.createdSmallButton()
    
    //win/lose message
    var exitWindow: SKSpriteNode?
    var buttonFinish: SKSpriteNode?
    
    var dontSelectDuringAnimation = false   //fix bug, can select durin delete animation
    
    // Hint
    struct PositionFicha {
        var posZ: Int
        var posI: Int
        var posJ: Int
        
        init(posZ: Int, posI: Int, posJ: Int) {
            self.posZ = posZ
            self.posI = posI
            self.posJ = posJ
        }

    }
    
    var savePositionFicha1: PositionFicha?
    var savePositionFicha2: PositionFicha?
    
    var blockUpdate = false    //fix bug, don't draw main menu
    
    var soundManager: Sound?
    
    //Selectors
    var drawSelect: SKShapeNode?
    var hintSelect1: SKShapeNode?
    var hintSelect2: SKShapeNode?

    init(size: CGSize, music: Bool, mark: Bool) {
        
        super.init(size: size)
        
        board.showSelectableTokens = mark  //config in menus of the game
      //  board.selectedBoard = boardType
        //board.selectedTiles = tilesType
        
        //Sounds
        soundManager = Sound(activeSounds: music, withMainTheme: false)
        
         //init config
        //background"
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.zPosition = -1;
        
        //in game Menu
        inGameMenu = InGameMenu(scene: self)
        
        //win/lose label
        exitWindow = SKSpriteNode.init(imageNamed: "exitFrame")
        exitWindow!.position = CGPoint(x: frame.midX, y: frame.midY)
        exitWindow!.zPosition = 600
        buttonFinish = TextAndButtons.createdButton()
        TextAndButtons.drawButton(buttonFinish!, text: "Finish", position: CGPoint(x: 0, y: -100), scene: exitWindow!)
        exitWindow!.setScale(0)
        
        gameOver = false  //init game
        
        initFichas()
        updateBoard()
        //drawScreen()
        
        //scan board properties
        savePositionFicha1 = PositionFicha(posZ: board.boardZ - 1, posI: board.boardX - 1, posJ: board.boardY - 1)
        savePositionFicha2 = PositionFicha(posZ: board.boardZ - 1, posI: board.boardX - 1, posJ: board.boardY - 1)
        
        //if for some streange reason can not remove any token in the begining
        //scanBoard(0, consI: 0, consJ: 0)
        scanBoard = true
        deletedAnimationCount = 0
        
        changeState(gameStates.state_GAMEPLAY.hashValue)  //Root state
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func initFichas() {
        
        select = false
        
        tilesInBoard = board.createdBoardWithDeep()
           // print("Error al crear el tablero!!!!!")
        
        print("screen width    \(frame.size.width)")
        print("screen height    \(frame.size.height)")
        
    }
    
    func configSelectorGlowing(_ selector: SKShapeNode) {
        
        selector.lineWidth = 3
        selector.glowWidth = 8.0
        
        //glowing animation
        let a = SKAction.fadeOut(withDuration: 1)
        let b = SKAction.fadeIn(withDuration: 1)
        selector.run(SKAction.repeatForever(SKAction.sequence([a, b])))
    }
    
    
    func drawScreen() {
        
        removeAllChildren()
        
        //background
        addChild(background)
        
        for z in 0..<tilesInBoard!.count {
            for i in 0..<tilesInBoard![z].count {
                for j in 0..<tilesInBoard![z][i].count {
                    
                    if let ficha = tilesInBoard![z][i][j] {
                        
                        //but first creating the selectors
                        let newSize = CGSize(width: ficha.figura!.size.width - 9, height: ficha.figura!.size.height - 9)
                        
                        drawSelect = SKShapeNode(rectOf: newSize, cornerRadius: 1)
                        hintSelect1 = SKShapeNode(rectOf: newSize, cornerRadius: 1)
                        hintSelect2 = SKShapeNode(rectOf: newSize, cornerRadius: 1)
                        drawSelect!.strokeColor = UIColor.green
                        hintSelect1!.strokeColor = UIColor.orange
                        hintSelect2!.strokeColor = UIColor.orange
                        
                        configSelectorGlowing(drawSelect!)
                        configSelectorGlowing(hintSelect1!)
                        configSelectorGlowing(hintSelect2!)
                        
                        
                        // OK now the tokes
                        if ficha.special == specialTokens.token_NORMAL.hashValue ||
                            ficha.special == specialTokens.token_DOBLE_NORTH.hashValue ||
                            ficha.special == specialTokens.token_QUATUPLE_NORTH.hashValue {
                            
                            let boardWidth = CGFloat.init(tilesInBoard![z].count) * (ficha.size!.width - 9)
                            let boardHeight = CGFloat.init(tilesInBoard![z][i].count) * (ficha.size!.height - 9)
                            let screenWidth = frame.width
                            let screenHeight = frame.height - buttonUndo.size.height
                            let fichaWidth = ficha.size!.width
                            let fichaHeight = ficha.size!.height
                            
                            //set position
                            let coodX_1 = (fichaWidth * CGFloat.init(i)) + CGFloat.init(-(i * 9) - (z * 9))
                            let coodX_2 = fichaWidth/2 + (screenWidth - boardWidth) / 2
                            let coodX_3 = (fichaWidth - 9) / 2
                            
                            let coodY_1 = screenHeight - fichaHeight/2
                            let coodY_2 = -(fichaHeight * CGFloat.init(j)) + CGFloat.init((j * 9) + (z * 9))
                            let coodY_3 = -(screenHeight - boardHeight) / 2
                            let coodY_4 = -(fichaHeight - 9) / 2
                            
                            if ficha.special == specialTokens.token_DOBLE_NORTH.hashValue {
                                
                                ficha.figura!.position = CGPoint(x: coodX_1 + coodX_2, y: coodY_1 + coodY_2 + coodY_3 + coodY_4)
                                
                            } else if ficha.special == specialTokens.token_QUATUPLE_NORTH.hashValue {
                                
                                ficha.figura!.position = CGPoint(x: coodX_1 + coodX_2 + coodX_3, y: coodY_1 + coodY_2 + coodY_3 + coodY_4)
                                
                            } else {
                                
                                ficha.figura!.position = CGPoint(x: coodX_1 + coodX_2, y: coodY_1 + coodY_2 + coodY_3)
                            }
                            
                            addChild(ficha.figura!)
                        }
                        
                    }
                    
                }
            }
        }
        
        //
        if !gameOver {
            
            if currentState == gameStates.state_GAMEPLAY.hashValue {
                
                TextAndButtons.drawButton(buttonUndo, text:"Undo", position:CGPoint(x: frame.minX + buttonUndo.size.width/2 + 10, y: frame.maxY - buttonUndo.size.height/2 - 15), scene:self)
                TextAndButtons.drawButton(buttonHint, text:"Hint", position:CGPoint(x: buttonUndo.position.x + buttonUndo.size.width/2 + 40 + buttonHint.size.width/2, y: frame.maxY - buttonUndo.size.height/2 - 15), scene:self)
                TextAndButtons.drawButton(buttonPause, text:"Menu", position:CGPoint(x: frame.maxX - buttonPause.size.width/2 - 10, y: frame.maxY - buttonPause.size.height/2 - 15), scene:self)
            }
            
            if currentState == gameStates.in_GAME_MENU.hashValue ||
               currentState == gameStates.in_GAME_MENU_HELP.hashValue ||
               currentState == gameStates.in_GAME_MENU_SELECT_TOKEN.hashValue {
                
                inGameMenu!.drawInGameMenu(self)
            }
        } else {
            
            if exitWindow!.xScale == 0 {
                let animation1 = SKAction.scale(to: 1.3, duration: 0.5)
                let animation2 = SKAction.scale(to: 1, duration:0.2)
                exitWindow!.run(SKAction.sequence([animation1, animation2]))
            }
            
            addChild(exitWindow!)
        }
        
        
    }
  
    
    func updateBoard() {
        
        select = false
        
        for z in 0..<tilesInBoard!.count {
            for i in 0..<tilesInBoard![z].count {
                for j in 0..<tilesInBoard![z][i].count {
                    
                    if let ficha = tilesInBoard![z][i][j] {
                        
                        if ficha.special == specialTokens.token_NORMAL.hashValue ||
                            ficha.special == specialTokens.token_DOBLE_NORTH.hashValue ||
                            ficha.special == specialTokens.token_QUATUPLE_NORTH.hashValue {
                            
                            ficha.selected = false   //fixed con el select = false de arriba... pero por si acaso
                            
                            if (z < tilesInBoard!.count - 1 && tilesInBoard![z + 1][i].count > j && tilesInBoard![z + 1][i][j] == nil) || (tilesInBoard!.count == z + 1) {
                                
                                if i == 0 {
                                    ficha.libre = true;
                                } else if i > 0 {
                                    
                                    if let _ = tilesInBoard![z][i - 1][j] {
                                        ficha.libre = false
                                    } else {
                                        ficha.libre = true
                                    }
                                    
                                    if ficha.special == specialTokens.token_DOBLE_NORTH.hashValue && ficha.libre == true {
                                        if j < tilesInBoard![z][i].count - 1 {
                                            if let _ = tilesInBoard![z][i - 1][j + 1] {
                                                ficha.libre = false
                                            }
                                        }
                                        
                                    }
                                }
                                
                                if i == tilesInBoard![z].count - 1 {
                                    ficha.libre = true
                                } else if i < tilesInBoard![z].count - 1 && ficha.libre == false {
                                    if tilesInBoard![z][i + 1][j] == nil {
                                        ficha.libre = true
                                    }
                                    if ficha.special == specialTokens.token_DOBLE_NORTH.hashValue && ficha.libre == true {
                                        
                                        if j < tilesInBoard![z][i].count - 1 {
                                            if let _ = tilesInBoard![z][i + 1][j + 1] {
                                                ficha.libre = false
                                            }
                                        }
                                        
                                    }
                                }
                            } else {
                                ficha.libre = false
                            }
                            
                            normalColor(ficha)
                            
                        }
                    }
                }
            }
        }
        
        if scanBoard {
            scanBoard(0, consI: 0, consJ: 0)
            scanBoard = false
        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        
        for touch in touches {
            let location = touch.location(in: self)
            touchScreen(location, ended: false, touchMove: false)
        }
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            let location = touch.location(in: self)
            touchScreen(location, ended: false, touchMove: true)
        }
    }
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            touchScreen(location, ended: true, touchMove: false)
        }
    }


    func touchScreen(_ location: CGPoint, ended: Bool, touchMove: Bool) {
        
        if currentState == gameStates.state_GAMEPLAY.hashValue {
            if !gameOver {
                
                if TextAndButtons.checkTouch(location, button: buttonUndo, ended: ended) {
                    if ended {
                        undoTokens()
                    }
                } else if TextAndButtons.checkTouch(location, button: buttonHint, ended: ended) {
                    if ended {
                        checkHint()
                    }
                } else if TextAndButtons.checkTouch(location, button: buttonPause, ended: ended) {
                    if ended {
                        removeSelected()
                        changeState(gameStates.in_GAME_MENU.hashValue)
                        inGameMenu!.showInGameMenu()
                    }
                }
                
                //touch move fix bug
                if !ended && !touchMove {
                    removeAllHint()
                    
                    //for i in (tilesInBoard!.count - 1)...0 {
                    for profuncidad in tilesInBoard! {
                        for columna in profuncidad {
                            for fichaEnFila in columna {
                                if let ficha = fichaEnFila {
                                    
                                    if location.x >= ficha.figura!.position.x - ficha.figura!.size.width/2 && location.x <= ficha.figura!.position.x + ficha.figura!.size.width/2 {
                                        if location.y <= ficha.figura!.position.y + ficha.figura!.size.height/2 && location.y >= ficha.figura!.position.y - ficha.figura!.size.height/2 {
                                            selectingToken(ficha)
                                            // return
                                        }
                                    }
                                }
                            }  //for j
                        }  //for i
                    }  //for z
                }
            } else {
                
                //some strange point fixeds
                let newPoint = CGPoint(x: location.x - size.width / 2.0, y: location.y - size.height / 2.0)
                
                if TextAndButtons.checkTouch(newPoint, button: buttonFinish!, ended: ended) {
                    if ended {
                        blockUpdate = true
                        let transition = SKTransition.doorsCloseHorizontal(withDuration: 1.5)
                        let toMainMenu = MainMenuScene(size: size, music: soundManager!.activeSounds, mark: board.showSelectableTokens)
                        view?.presentScene(toMainMenu, transition: transition)
                    }
                }
            }
            
        } else if currentState == gameStates.in_GAME_MENU.hashValue ||
            currentState == gameStates.in_GAME_MENU_HELP.hashValue ||
            currentState == gameStates.in_GAME_MENU_SELECT_TOKEN.hashValue {
            
            inGameMenu!.touchScreen(location, scene: self, ended: ended)
        }
        
        //drawScreen()
    }
    
    func changeGreenColor(_ ficha: Ficha) {
        ficha.figura!.color = UIColor.green
        ficha.figura!.colorBlendFactor = 0.7
        ficha.selected = true;
        
        drawSelect!.position = CGPoint(x: ficha.figura!.position.x - 4, y: ficha.figura!.position.y + 4)
        drawSelect!.zPosition = CGFloat.init((tilesInBoard![ficha.zPos].count * tilesInBoard![ficha.zPos][Int.init(ficha.position!.x)].count) * (ficha.zPos + 1))
        addChild(drawSelect!)
       
    }
    
    func changeOrangeColor(_ ficha: Ficha, fichaOne: Bool) {
        ficha.figura!.color = UIColor.orange
        ficha.figura!.colorBlendFactor = 0.9
        ficha.hint = true
        if ficha.selected {
            ficha.selected = false
            select = false
        }
        
        if fichaOne {
            hintSelect1!.position = CGPoint(x: ficha.figura!.position.x - 4, y: ficha.figura!.position.y + 4)
            hintSelect1!.zPosition = CGFloat.init((tilesInBoard![ficha.zPos].count * tilesInBoard![ficha.zPos][Int.init(ficha.position!.x)].count) * (ficha.zPos + 1))
            addChild(hintSelect1!)
        } else {
            hintSelect2!.position = CGPoint(x: ficha.figura!.position.x - 4, y: ficha.figura!.position.y + 4)
            hintSelect2!.zPosition = CGFloat.init((tilesInBoard![ficha.zPos].count * tilesInBoard![ficha.zPos][Int.init(ficha.position!.x)].count) * (ficha.zPos + 1))
            addChild(hintSelect2!)
        }
    }
    
//    func createdSelector(rect: CGRect) {
//        
//        let drawSelect = SKShapeNode(rect: rect)
//        drawSelect.strokeColor = UIColor.greenColor()
//        drawSelect.glowWidth = 5.0
//
////        
////        CGMutablePathRef myPath = CGPathCreateMutable();
////        CGPathAddRect(myPath, NULL, size);
////        self.drawSelect.path = myPath;
////        self.drawSelect.strokeColor = [UIColor greenColor];
////        self.drawSelect.lineWidth = 3;
////        self.drawSelect.glowWidth = 5.0;
////        self.drawSelect.zPosition = [self.board.resultArray count] +1;  //the biggest number of elements (para estar al mero enfrene
//    }
    
    func normalColor(_ ficha: Ficha) {
        if boardSelected == boardSet.mario_BROS.hashValue {
            switch ficha.zPos {
            case 0:
                ficha.figura!.color = UIColor.yellow
                break
            case 1:
                ficha.figura!.color = UIColor.gray
                break
            case 2:
                ficha.figura!.color = UIColor.brown
                break
            case 3:
                ficha.figura!.color = UIColor.red
                break
            default:
                ficha.figura!.color = UIColor.white
                break
            }
            
            ficha.figura!.colorBlendFactor = 0.5
        } else {
            switch ficha.zPos {
            case 0:
                ficha.figura!.color = UIColor.red
                break
            case 1:
                ficha.figura!.color = UIColor.blue
                break
            case 2:
                ficha.figura!.color = UIColor.yellow
                break
            case 3:
                ficha.figura!.color = UIColor.purple
                break
            case 4:
                ficha.figura!.color = UIColor.red
                break
            default:
                ficha.figura!.color = UIColor.white
                break
            }
            ficha.figura!.colorBlendFactor = 0.35
        }
        
        if board.showSelectableTokens && !ficha.libre {
            ficha.figura!.colorBlendFactor = 0.1
        }
        if ficha.selected {
            drawSelect!.removeFromParent()
            ficha.selected = false
        }
        select = false
        ficha.hint = false
    }
    
    func selectingToken(_ ficha: Ficha) {
        if !dontSelectDuringAnimation{
            if !select {
                fichaOldSelected = ficha
                fichaNewSelected = nil
                
                if fichaOldSelected!.libre {
                    select = true
                    changeGreenColor(fichaOldSelected!)
                    soundManager!.playSound("select.m4a", scene: self)
                }
            } else {
                fichaNewSelected = ficha;
                if fichaOldSelected! === fichaNewSelected! && fichaOldSelected!.libre {
                    normalColor(fichaOldSelected!)
                    fichaOldSelected = nil
                    fichaNewSelected = nil
                    
                    // select = false
                    //drawSelect!.removeFromParent()
                    soundManager!.playSound("select.m4a", scene: self)
                    
                } else if fichaNewSelected!.libre {
                    //drawSelect!.removeFromParent()
                    if processSelectedFichas() {
                        //  select = false
                        normalColor(fichaOldSelected!)
                        
                    } else {
                        normalColor(fichaOldSelected!)
                        fichaOldSelected = ficha
                        fichaNewSelected = nil
                        
                        changeGreenColor(fichaOldSelected!)
                        select = true
                        soundManager!.playSound("select.m4a", scene: self)
                    }
                }
            }
        }  //if dont select
    }
    
    
    
    
    func processSelectedFichas() -> Bool {

        //check if is the same ficha
        if fichaOldSelected!.number == fichaNewSelected!.number
        {
            dontSelectDuringAnimation = true
            //removed fichas
            for z in 0..<tilesInBoard!.count {
                for i in 0..<tilesInBoard![z].count {
                    for j in 0..<tilesInBoard![z][i].count {
                        //removed selected new ficha
                        if fichaNewSelected!.position!.x == CGFloat.init(i) && fichaNewSelected!.position!.y == CGFloat.init(j) && fichaNewSelected!.zPos == z {
                            deletedAnimation(fichaNewSelected!)
                        }
                        
                        //removed selected old ficha
                        if fichaOldSelected!.position!.x == CGFloat.init(i) && fichaOldSelected!.position!.y == CGFloat.init(j) && fichaOldSelected!.zPos == z {
                            deletedAnimation(fichaOldSelected!)
                        }
                        
                    }
                }
            }
            
            return true
        }
        return false
    }
    
    
    func deletedAnimation(_ token: Ficha) {
        let animation = SKAction.scale(to: 0, duration: 0.3)
        let deleted = SKAction.run {
            
            let profundidad = Int.init(token.zPos)
            let columna = Int.init(token.position!.x)
            let fila = Int.init(token.position!.y)
            
            self.removeToken(token, profundidad: profundidad, columna: columna, fila: fila)
            
            self.deletedAnimationCount += 1
            if self.deletedAnimationCount == 2 {
                //self.drawScreen()  //need this here to work!!!!
                self.updateBoard()
                self.deletedAnimationCount = 0
                self.dontSelectDuringAnimation = false
            }
            
        }
        
        token.figura?.run(SKAction.sequence([animation, deleted]))  //remove animation
        soundManager!.playSound("delete.m4a", scene: self)
    }
    
    
    
    func removeToken(_ token: Ficha, profundidad: Int, columna: Int, fila: Int) {
        
        if token.special == specialTokens.token_DOBLE_NORTH.hashValue {
            
            undoArray.append(tilesInBoard![profundidad][columna][fila + 1])
            tilesInBoard![profundidad][columna][fila + 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna][fila + 1] = nil
            
        }
        
        if token.special == specialTokens.token_DOBLE_SOUTH.hashValue {
            
            undoArray.append(tilesInBoard![profundidad][columna][fila - 1])
            tilesInBoard![profundidad][columna][fila - 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna][fila - 1] = nil
            
        }
        
        if token.special == specialTokens.token_QUATUPLE_NORTH.hashValue {
            
            undoArray.append(tilesInBoard![profundidad][columna][fila + 1])
            tilesInBoard![profundidad][columna][fila + 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna][fila + 1] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna + 1][fila])
            tilesInBoard![profundidad][columna + 1][fila]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna + 1][fila] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna + 1][fila + 1])
            tilesInBoard![profundidad][columna + 1][fila + 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna + 1][fila + 1] = nil
        }
        
        if token.special == specialTokens.token_QUATUPLE_SOUTH.hashValue {
            
            undoArray.append(tilesInBoard![profundidad][columna][fila - 1])
            tilesInBoard![profundidad][columna][fila - 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna][fila - 1] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna + 1][fila])
            tilesInBoard![profundidad][columna + 1][fila]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna + 1][fila] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna + 1][fila - 1])
            tilesInBoard![profundidad][columna + 1][fila - 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna + 1][fila - 1] = nil
        }

        if token.special == specialTokens.token_QUATUPLE_EAST_NORTH.hashValue {
            
            undoArray.append(tilesInBoard![profundidad][columna][fila + 1])
            tilesInBoard![profundidad][columna][fila + 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna][fila + 1] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna - 1][fila])
            tilesInBoard![profundidad][columna - 1][fila]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna - 1][fila] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna - 1][fila + 1])
            tilesInBoard![profundidad][columna - 1][fila + 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna - 1][fila + 1] = nil
        }
        
        if token.special == specialTokens.token_QUATUPLE_EAST_SOUTH.hashValue {
            
            undoArray.append(tilesInBoard![profundidad][columna][fila - 1])
            tilesInBoard![profundidad][columna][fila - 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna][fila - 1] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna - 1][fila])
            tilesInBoard![profundidad][columna - 1][fila]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna - 1][fila] = nil
            
            undoArray.append(tilesInBoard![profundidad][columna - 1][fila - 1])
            tilesInBoard![profundidad][columna - 1][fila - 1]!.figura!.removeFromParent()
            tilesInBoard![profundidad][columna - 1][fila - 1] = nil
        }
        
        tilesInBoard![profundidad][columna][fila]!.figura!.removeFromParent()
        tilesInBoard![profundidad][columna][fila] = nil
        undoArray.append(token)
        
        scanBoard = true  // Check if win or lose
    }
    
  
    func removeAllHint() {
        for profuncidad in tilesInBoard! {
            for columna in profuncidad {
                for fichaEnFila in columna {
                    if let ficha = fichaEnFila {
                        if ficha.hint {
                            normalColor(ficha)
                        }
                    }
                }
            }
        }
        hintSelect1!.removeFromParent()
        hintSelect2!.removeFromParent()
    }
    
  
    func removeSelected() {
        for profuncidad in tilesInBoard! {
            for columna in profuncidad {
                for fichaEnFila in columna {
                    if let ficha = fichaEnFila {
                        if ficha.selected {
                            normalColor(ficha)
                        }
                    }
                }
            }
        }
        drawSelect!.removeFromParent()
    }
    
    func undoTokens() {
        print("undo array count : \(undoArray.count)")
            
        if undoArray.count >= 2 {
            removeSelected()
            
            var blockRepeat = 0;
            
            //first and second token undo
            var i = 0
            while i < 2 {
                let getToken = undoArray.last
                print("getToken special : \(getToken!!.special)")
                
                if getToken!!.special == specialTokens.token_NORMAL.hashValue ||
                   getToken!!.special == specialTokens.token_DOBLE_NORTH.hashValue ||
                   getToken!!.special == specialTokens.token_QUATUPLE_NORTH.hashValue {
                    
                    addChild(getToken!!.figura!)
                }
                
                getToken!!.figura!.run(SKAction.scale(to: 1.0, duration: 0.3))
                
                tilesInBoard![getToken!!.zPos][Int.init(getToken!!.position!.x)][Int.init(getToken!!.position!.y)] = getToken!!
                undoArray.removeLast()
                
                if getToken!!.special == specialTokens.token_DOBLE_NORTH.hashValue ||
                    getToken!!.special == specialTokens.token_DOBLE_SOUTH.hashValue {
                    if blockRepeat == 0 {
                        i -= 1
                    }
                    blockRepeat += 1
                    if blockRepeat == 2 {
                        blockRepeat = 0
                    }
                }
                if getToken!!.special == specialTokens.token_QUATUPLE_NORTH.hashValue ||
                    getToken!!.special == specialTokens.token_QUATUPLE_SOUTH.hashValue ||
                    getToken!!.special == specialTokens.token_QUATUPLE_EAST_NORTH.hashValue ||
                    getToken!!.special == specialTokens.token_QUATUPLE_EAST_SOUTH.hashValue {
                    if blockRepeat == 0 {
                        i -= 3
                    }
                    blockRepeat += 1
                    if blockRepeat == 4 {
                        blockRepeat = 0
                    }
                }
                i += 1
            }
            updateBoard()
            soundManager!.playSound("undo.m4a", scene: self)
            
        } else {
            soundManager!.playSound("stop.m4a", scene: self)
        }
        
    }
    
    
    func scanBoard(_ consZ: Int, consI: Int, consJ: Int) {
        
        var varZ = consZ
        var varI = consI
        var varJ = consJ
       
        var fichaAux: Ficha? = nil
        
        gameOver = true
        
        for z in varZ..<tilesInBoard!.count {
            for i in varI..<tilesInBoard![z].count {
                for j in varJ..<tilesInBoard![z][i].count {
                    
                    if let ficha1 = fichaAux {
                        
                        if ficha1.libre {
                            
                            let fichaAux2 = tilesInBoard![z][i][j]
                            if let ficha2 = fichaAux2 {
                               // Ficha *ficha2 = fichaAux2;
                                
                                if (ficha2.libre) {
                                    if (ficha1.number == ficha2.number) {
                                        self.gameOver = false
                                        return
                                    }
                                }
                            }
                            
                        }
                    } else {
                        fichaAux = tilesInBoard![z][i][j]
                    }
                }  //for j
                varJ = 0;
            }  //for i
            varI = 0;
        }  //for z
        
        varI = consI
        varJ = consJ
        
        varJ += 1
        if varJ == tilesInBoard![varZ][varI].count {
            varJ = 0
            varI += 1
            if varI == tilesInBoard![varZ].count {
                varI = 0
                varZ += 1
                if varZ == tilesInBoard!.count {
                    varZ -= 1
                }
            }
        }
        
        
        if varZ == tilesInBoard!.count - 1 && varI == tilesInBoard![varZ].count - 1 && varJ == tilesInBoard![varZ][varI].count - 1 {
            
            if gameOver {
                for z in 0..<tilesInBoard!.count {
                    for i in 0..<tilesInBoard![z].count {
                        for j in 0..<tilesInBoard![z][i].count {
                            if fichaAux == nil {
                                fichaAux = tilesInBoard![z][i][j]
                            }
                        }
                    }
                }
                if let _ = fichaAux {
                    showMessageWin(false)
                } else {
                    showMessageWin(true)
                }
                //drawScreen()
                initState = true    // set true for Redraw the screen wiht the game over message
            }
        } else {
            scanBoard(varZ, consI: varI, consJ: varJ)
        }
        
    }

    
    func checkHint() {
        
        var fichaAux: Ficha? = nil
        
        if savePositionFicha2!.posZ == board.boardZ && savePositionFicha2!.posI == board.boardX && savePositionFicha2!.posJ == board.boardY {
            
            savePositionFicha2!.posZ = savePositionFicha1!.posZ
            savePositionFicha2!.posI = savePositionFicha1!.posI
            savePositionFicha2!.posJ = savePositionFicha1!.posJ
        }
        
        var z = savePositionFicha1!.posZ
        var i = savePositionFicha1!.posI
        var j = savePositionFicha1!.posJ
        
        while z >= 0 {
            while i >= 0 {
                while j >= 0 {
                    
                    if let ficha1 = fichaAux {
                        
                        if ficha1.libre &&
                        (ficha1.special == specialTokens.token_NORMAL.hashValue ||
                        ficha1.special == specialTokens.token_DOBLE_NORTH.hashValue ||
                        ficha1.special == specialTokens.token_QUATUPLE_NORTH.hashValue) {
                            
                            let fichaAux2 = tilesInBoard![z][i][j]
                            if let ficha2 = fichaAux2 {
                                
                                if ficha2.libre &&
                                    (ficha1.special == specialTokens.token_NORMAL.hashValue ||
                                    ficha1.special == specialTokens.token_DOBLE_NORTH.hashValue ||
                                    ficha1.special == specialTokens.token_QUATUPLE_NORTH.hashValue) {
                                    
                                    if ficha1.number == ficha2.number {
                                        removeSelected()
                                        changeOrangeColor(ficha1, fichaOne: true)
                                        changeOrangeColor(ficha2, fichaOne: false)
                                        
                                        //save the position
                                        savePositionFicha2!.posZ = z;
                                        savePositionFicha2!.posI = i;
                                        savePositionFicha2!.posJ = j;
                                        
                                        soundManager!.playSound("stop.m4a", scene: self)
                                        
                                        return
                                    }
                                }
                            }
                            
                        }
                    } else {
                    
                        fichaAux = tilesInBoard![z][i][j]
                        
                        if let _ = fichaAux {
                            savePositionFicha1!.posI = i
                            savePositionFicha1!.posJ = j
                            savePositionFicha1!.posZ = z
                            
                            if savePositionFicha2!.posZ > savePositionFicha1!.posZ {
                                
                                savePositionFicha2!.posZ = savePositionFicha1!.posZ
                                savePositionFicha2!.posI = savePositionFicha1!.posI
                                savePositionFicha2!.posJ = savePositionFicha1!.posJ
                                
                            } else if savePositionFicha2!.posZ == savePositionFicha1!.posZ {
                                
                                if savePositionFicha2!.posI > savePositionFicha1!.posI {
                                    
                                    savePositionFicha2!.posI = savePositionFicha1!.posI
                                    savePositionFicha2!.posJ = savePositionFicha1!.posJ
                                    
                                } else if savePositionFicha2!.posI == savePositionFicha1!.posI {
                                    
                                    if savePositionFicha2!.posJ > savePositionFicha1!.posJ {
                                        savePositionFicha2!.posJ = savePositionFicha1!.posJ
                                    }
                                }
                            }
                            
                            z = savePositionFicha2!.posZ
                            i = savePositionFicha2!.posI
                            j = savePositionFicha2!.posJ
                        }
                    }
                    j -= 1
                }  //for j
                
                j = board.boardY - 1
                i -= 1
            }  //for i
            
            i = board.boardX - 1
            z -= 1;
        }  //for z
        
        savePositionFicha1!.posJ -= 1
        if savePositionFicha1!.posJ < 0 {
            
            savePositionFicha1!.posJ = board.boardY - 1
            savePositionFicha1!.posI -= 1
            
            if savePositionFicha1!.posI < 0 {
                
                savePositionFicha1!.posI = board.boardX - 1
                savePositionFicha1!.posZ -= 1
                
                if savePositionFicha1!.posZ < 0 {
                    savePositionFicha1!.posZ = board.boardZ - 1
                }
            }
        }
        
        savePositionFicha2!.posZ = board.boardZ - 1
        savePositionFicha2!.posI = board.boardX - 1
        savePositionFicha2!.posJ = board.boardY - 1
        
        checkHint()
        
    }
    
    
    
    func showMessageWin(_ win: Bool) {
        
        if win {
            TextAndButtons.drawText("Congratulation!!", size: 30, position: CGPoint(x: 0, y: 100), scene: exitWindow!)
            TextAndButtons.drawText("You WIN!!", size: 30, position: CGPoint(x: 0, y: 0), scene: exitWindow!)
            soundManager!.playSound("win.m4a", scene: self)
            
        } else {
            TextAndButtons.drawText("No more moves", size: 30, position: CGPoint(x: 0, y: 100), scene: exitWindow!)
            TextAndButtons.drawText("Game Over :(", size: 30, position: CGPoint(x: 0, y: 0), scene: exitWindow!)
        }
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        if initState && !blockUpdate {
            drawScreen()
            initState = false
        }
    }
    

 
}
