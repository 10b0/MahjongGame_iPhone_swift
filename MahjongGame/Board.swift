//
//  Board.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 3/30/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import Foundation
import SpriteKit

class Board {

    var boardX = 0
    var boardY = 0
    var boardZ = 0
    var showSelectableTokens = false
    //var selectedBoard = boardSet.TURTLE.hashValue
   // var selectedTiles = tilesSet.ORIGINAL.hashValue
    var resultArray = [Int?]()
    var arrayOfTokens = [Int]()
    var arrayNumRepeted = [Int]()
    var specialToken = [Int]()

    
    
    
    func createdBoardWithDeep() -> [[[Ficha?]]] {
    
        var count = 0
        initTokenList()
        var tilesInBoard = [[[Ficha?]]]()
    
        // init variables
        for z in 0..<boardZ {
            tilesInBoard.append([[Ficha?]]())
            
            for j in 0..<boardX {
                tilesInBoard[z].append([Ficha?]())
                    
                for i in 0..<boardY {
                    
                    if let _ = resultArray[count] {
                        tilesInBoard[z][j].append(createdFicha(z, posX: j, posY: i))
                    } else {
                        tilesInBoard[z][j].append(nil)
                    }
                    count += 1
                }  //for i
            }  //for j

        }  //for z
    
        return tilesInBoard
    }

    
    
    func initTokenList() {
        //variables of cofiguration of token list
        var maxToken = 0
        var numTokenRepeted = 0
        
        switch boardSelected {
        case boardSet.TURTLE.hashValue:
            //init variables
            boardZ = 5
            boardX = 15
            boardY = 8
            
            //list of 8 diferent token 8 time each
            maxToken = 36
            numTokenRepeted = 4
            
            //maxToken = @9;
            //numTokenRepeted = @16;
            
           // maxToken = 2
           // numTokenRepeted = 72
            break
        case boardSet.PYRAMID.hashValue:
            //init variables
            boardZ = 4
            boardX = 8
            boardY = 8
            
            //list of 8 diferent token 8 time each
            maxToken = 30
            numTokenRepeted = 4
            
            //maxToken = @12;
            //numTokenRepeted = @10;
            //maxToken = @2;
            //numTokenRepeted = @60;
            
            break
            
        case boardSet.SPIDER.hashValue:
            //init variables
            boardZ = 4
            boardX = 15
            boardY = 8
            
            maxToken = 36
            numTokenRepeted = 4
            break
            
        case boardSet.SPACE_INVADERS.hashValue:
            //init variables
            boardZ = 4
            boardX = 11
            boardY = 8
            
            maxToken = 29
            numTokenRepeted = 4
            break
            
        case boardSet.MS_PACMAN.hashValue:
            //init variables
            boardZ = 4
            boardX = 14
            boardY = 8
            
            maxToken = 30
            numTokenRepeted = 4
            break
            
        case boardSet.MARIO_BROS.hashValue:
            //init variables
            boardZ = 4
            boardX = 11
            boardY = 8
            
            maxToken = 36
            numTokenRepeted = 4
            break
            
        case boardSet.TETRIS.hashValue:
            //init variables
            boardZ = 5
            boardX = 10
            boardY = 8
            
            maxToken = 36
            numTokenRepeted = 4
            break
            
        default:
            //original (turtle)
            //init variables
            boardZ = 5
            boardX = 15
            boardY = 8
            
            //list of 8 diferent token 8 time each
            maxToken = 36
            numTokenRepeted = 4
            
            break
        }
        
        //comfigurate token list
        for i in 0..<maxToken {
            arrayOfTokens.append(i)
            arrayNumRepeted.append(numTokenRepeted)
            
            print("Tokens List[\(i)]: T=\(arrayOfTokens[i]), N=\(arrayNumRepeted[i])")
        }
        
        print("-------------------------------------")
        print("-------------------------------------")
        
        makeRandomTokenList()
    }
    
    
    func createdFicha(posZ: Int, posX: Int, posY: Int) -> Ficha {
        
        var index = posX * (boardY - 1) + (posX + posY) + (((((boardX - 1) * (boardY - 1)) + ((boardX - 1) + (boardY - 1))) + 1) * posZ)
        print("index: \(index)")
        
        if index > resultArray.count {
            // ERROR this must not happen!!!!!!!
            print("ERROR ERROR ERROR ERROR")
            index = resultArray.count
        }
        
        let newFicha = Ficha(number: resultArray[index]!, position: CGPointMake(CGFloat.init(posX), CGFloat.init(posY)), zPos: posZ, libre: false, special: specialToken[index], figura: loadImageTile(resultArray[index]!), index: index)
        
        return newFicha
    
    }
    
    
    
    func loadImageTile(numberOfTile: Int) -> SKSpriteNode {
        
        let figura: SKSpriteNode
        if tilesSelected == tilesSet.ORIGINAL.hashValue {
            switch numberOfTile {
            case 0:
                figura = SKSpriteNode.init(imageNamed: "ficha0")
                break
            case 1:
                figura = SKSpriteNode.init(imageNamed: "ficha1")
                break
            case 2:
                figura = SKSpriteNode.init(imageNamed: "ficha2")
                break
            case 3:
                figura = SKSpriteNode.init(imageNamed: "ficha3")
                break
            case 4:
                figura = SKSpriteNode.init(imageNamed: "ficha4")
                break
            case 5:
                figura = SKSpriteNode.init(imageNamed: "ficha5")
                break
            case 6:
                figura = SKSpriteNode.init(imageNamed: "ficha6")
                break
            case 7:
                figura = SKSpriteNode.init(imageNamed: "ficha7")
                break
            case 8:
                figura = SKSpriteNode.init(imageNamed: "ficha8")
                break
            case 9:
                figura = SKSpriteNode.init(imageNamed: "ficha9")
                break
            case 10:
                figura = SKSpriteNode.init(imageNamed: "ficha10")
                break
            case 11:
                figura = SKSpriteNode.init(imageNamed: "ficha11")
                break
            case 12:
                figura = SKSpriteNode.init(imageNamed: "ficha12")
                break
            case 13:
                figura = SKSpriteNode.init(imageNamed: "ficha13")
                break
            case 14:
                figura = SKSpriteNode.init(imageNamed: "ficha14")
                break
            case 15:
                figura = SKSpriteNode.init(imageNamed: "ficha15")
                break
            case 16:
                figura = SKSpriteNode.init(imageNamed: "ficha16")
                break
            case 17:
                figura = SKSpriteNode.init(imageNamed: "ficha17")
                break
            case 18:
                figura = SKSpriteNode.init(imageNamed: "ficha18")
                break
            case 19:
                figura = SKSpriteNode.init(imageNamed: "ficha19")
                break
            case 20:
                figura = SKSpriteNode.init(imageNamed: "ficha20")
                break
            case 21:
                figura = SKSpriteNode.init(imageNamed: "ficha21")
                break
            case 22:
                figura = SKSpriteNode.init(imageNamed: "ficha22")
                break
            case 23:
                figura = SKSpriteNode.init(imageNamed: "ficha23")
                break
            case 24:
                figura = SKSpriteNode.init(imageNamed: "ficha24")
                break
            case 25:
                figura = SKSpriteNode.init(imageNamed: "ficha25")
                break
            case 26:
                figura = SKSpriteNode.init(imageNamed: "ficha26")
                break
            case 27:
                figura = SKSpriteNode.init(imageNamed: "ficha27")
                break
            case 28:
                figura = SKSpriteNode.init(imageNamed: "ficha28")
                break
            case 29:
                figura = SKSpriteNode.init(imageNamed: "ficha29")
                break
            case 30:
                figura = SKSpriteNode.init(imageNamed: "ficha30")
                break
            case 31:
                figura = SKSpriteNode.init(imageNamed: "ficha31")
                break
            case 32:
                figura = SKSpriteNode.init(imageNamed: "ficha32")
                break
            case 33:
                figura = SKSpriteNode.init(imageNamed: "ficha33")
                break
            case 34:
                figura = SKSpriteNode.init(imageNamed: "ficha34")
                break
            case 35:
                figura = SKSpriteNode.init(imageNamed: "ficha35")
                break
            default:
                figura = SKSpriteNode.init(imageNamed: "ficha0")
                break
            }
        } else {
            switch numberOfTile {
            case 0:
                figura = SKSpriteNode.init(imageNamed: "fichaM0")
                break
            case 1:
                figura = SKSpriteNode.init(imageNamed: "fichaM1")
                break
            case 2:
                figura = SKSpriteNode.init(imageNamed: "fichaM2")
                break
            case 3:
                figura = SKSpriteNode.init(imageNamed: "fichaM3")
                break
            case 4:
                figura = SKSpriteNode.init(imageNamed: "fichaM4")
                break
            case 5:
                figura = SKSpriteNode.init(imageNamed: "fichaM5")
                break
            case 6:
                figura = SKSpriteNode.init(imageNamed: "fichaM6")
                break
            case 7:
                figura = SKSpriteNode.init(imageNamed: "fichaM7")
                break
            case 8:
                figura = SKSpriteNode.init(imageNamed: "fichaM8")
                break
            case 9:
                figura = SKSpriteNode.init(imageNamed: "fichaM9")
                break
            case 10:
                figura = SKSpriteNode.init(imageNamed: "fichaM10")
                break
            case 11:
                figura = SKSpriteNode.init(imageNamed: "fichaM11")
                break
            case 12:
                figura = SKSpriteNode.init(imageNamed: "fichaM12")
                break
            case 13:
                figura = SKSpriteNode.init(imageNamed: "fichaM13")
                break
            case 14:
                figura = SKSpriteNode.init(imageNamed: "fichaM14")
                break
            case 15:
                figura = SKSpriteNode.init(imageNamed: "fichaM15")
                break
            case 16:
                figura = SKSpriteNode.init(imageNamed: "fichaM16")
                break
            case 17:
                figura = SKSpriteNode.init(imageNamed: "fichaM17")
                break
            case 18:
                figura = SKSpriteNode.init(imageNamed: "fichaM18")
                break
            case 19:
                figura = SKSpriteNode.init(imageNamed: "fichaM19")
                break
            case 20:
                figura = SKSpriteNode.init(imageNamed: "fichaM20")
                break
            case 21:
                figura = SKSpriteNode.init(imageNamed: "fichaM21")
                break
            case 22:
                figura = SKSpriteNode.init(imageNamed: "fichaM22")
                break
            case 23:
                figura = SKSpriteNode.init(imageNamed: "fichaM23")
                break
            case 24:
                figura = SKSpriteNode.init(imageNamed: "fichaM24")
                break
            case 25:
                figura = SKSpriteNode.init(imageNamed: "fichaM25")
                break
            case 26:
                figura = SKSpriteNode.init(imageNamed: "fichaM26")
                break
            case 27:
                figura = SKSpriteNode.init(imageNamed: "fichaM27")
                break
            case 28:
                figura = SKSpriteNode.init(imageNamed: "fichaM28")
                break
            case 29:
                figura = SKSpriteNode.init(imageNamed: "fichaM29")
                break
            case 30:
                figura = SKSpriteNode.init(imageNamed: "fichaM30")
                break
            case 31:
                figura = SKSpriteNode.init(imageNamed: "fichaM31")
                break
            case 32:
                figura = SKSpriteNode.init(imageNamed: "fichaM32")
                break
            case 33:
                figura = SKSpriteNode.init(imageNamed: "fichaM33")
                break
            case 34:
                figura = SKSpriteNode.init(imageNamed: "fichaM34")
                break
            case 35:
                figura = SKSpriteNode.init(imageNamed: "fichaM35")
                break
            default:
                figura = SKSpriteNode.init(imageNamed: "ficha0")
                break
            }
            
        }
        return figura
    }

 


    func makeRandomTokenList() {
        //resultArray = NSMutableArray alloc] init]
        //self.specialToken = [[NSMutableArray alloc] init]
    
        var count = 0  //debug purpose
        
        
        switch boardSelected {
        case boardSet.TURTLE.hashValue:
            //  default:
            
            for z in 0..<boardZ {
                for i in 0..<boardX {
                    for j in 0..<boardY {
                        //draw turtle
                        // cabeza
                        if z == 0 && i == 0 && j != 3 {
                            resultArray.append(nil)
                        } else if z == 0 && i == 1 && (j == 1 || j == 2 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 2 && (j == 1 || j == 6) {
                            resultArray.append(nil)
                        }
                            //cola
                        else if z == 0 && i == 11 && (j == 1 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 12 && (j == 1 || j == 2 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && i >= 13 && j != 3 {
                            resultArray.append(nil)
                        }
                            //concha
                        else if  z > 0 && z < boardZ - 1 && i < z + 3 {
                            resultArray.append(nil)
                        } else if z > 0 && z < boardZ - 1 && i > (boardX - 1) - z - 4 {
                            resultArray.append(nil)
                        } else if z < boardZ - 1 && j <= z - 1 {
                            resultArray.append(nil)
                        } else if z < boardZ - 1 && j > (boardY - 1) - z {
                            resultArray.append(nil)
                            //last token in the top
                        } else if z == boardZ - 1 && (i != 6 || j != 3) {
                            resultArray.append(nil)
                        } else {
                            
                            addNewTokeToTheList()
                            
                        }
                        if z == 0 && i == 0 && j == 3 {
                            specialToken.append(specialTokens.TOKEN_DOBLE_NORTH.hashValue)
                        } else if z == 0 && i >= 13 && j == 3 {
                            specialToken.append(specialTokens.TOKEN_DOBLE_NORTH.hashValue)
                        } else if z == boardZ - 1 && i == 6 && j == 3 {
                            specialToken.append(specialTokens.TOKEN_QUATUPLE_NORTH.hashValue)
                        } else {
                            specialToken.append(specialTokens.TOKEN_NORMAL.hashValue)
                        }
                        print("Array Tokens Result[\(count)] coor[\(z)][\(i)][\(j)] T=\(resultArray[count])")
                        count += 1
                    }  //for j
                    print("-------------------------------------")
                }   //for i
            } //for z
            print("-------------------------------------")
            print("-------------------------------------")
            
            break
        case boardSet.PYRAMID.hashValue :
            for z in 0..<boardZ {
                for i in 0..<boardX {
                    for j in 0..<boardY {
                        
                        specialToken.append(specialTokens.TOKEN_NORMAL.hashValue)
                        //Draw Piramid
                        if i <= z - 1 {
                            resultArray.append(nil)
                        } else if i > (boardX - 1) - z {
                            resultArray.append(nil)
                        } else if j <= z - 1 {
                            resultArray.append(nil)
                        } else if j > (boardY - 1) - z {
                            resultArray.append(nil)
                        } else {
                            addNewTokeToTheList()
                        }
                        print("Array Tokens Result[\(count)]T=\(resultArray[count])")
                        count += 1
                    }  //for j
                    print("-------------------------------------")
                }   //for i
            } //for z
            print("-------------------------------------")
            print("-------------------------------------")
            break
        case boardSet.SPIDER.hashValue:
            for z in 0..<boardZ {
                for i in 0..<boardX {
                    for j in 0..<boardY {
                        if z == 0 && (i == 0 || i == 14) && (j == 0 || j == 2 || j == 3 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 1 || i == 13) && (j == 0 || j == 1 || j == 3 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 2 || i == 12) && (j == 1 || j == 3 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 3 || i == 11) && (j == 2 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 4 || i == 10) && (j == 0 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 5 || i == 9) && (j == 0 || j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 6 || i == 8) && (j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 7 && (j == 0) {
                            resultArray.append(nil)
                            
                        } else if z == 1 && (i == 0 || i == 14) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 1 || i == 13) && (j == 0 || j == 1 || j == 3 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 2 || i == 12) && (j == 0 || j == 1 || j == 3 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 3 || i == 11) && (j == 2 || j == 3 || j == 4 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 4 || i == 10) && (j == 0 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 5 || i == 9) && (j == 0 || j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 6 || i == 8) && (j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && i == 7 && (j == 0 || j == 7) {
                            resultArray.append(nil)
                            
                        } else if z == 2 && (i < 5 || i > 9) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 5 || i == 9) && (j == 0 || j == 1 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 6 || i == 8) && (j == 0 || j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && i == 7 && (j == 0 || j == 1 || j == 7) {
                            resultArray.append(nil)
                            
                        } else if z == 3 && (i < 6 || i > 8) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 6 || i == 8) && (j == 0 || j == 1 || j == 2 || j == 3 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 3 && i == 7 && (j == 0 || j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else {
                            
                            addNewTokeToTheList()
                            
                        }
                        
                        if z == 0 && (i == 0 || i == 14) && (j == 1 || j == 4) {
                            specialToken.append(specialTokens.TOKEN_DOBLE_NORTH.hashValue)
                        } else if (z == 0 || z == 1) && (i == 1 || i == 13) && (j == 4) {
                            specialToken.append(specialTokens.TOKEN_DOBLE_NORTH.hashValue)
                        } else if (z == 0 || z == 1) && (i == 2 || i == 12) && (j == 2 || j == 4 || j == 6) {
                            specialToken.append(specialTokens.TOKEN_DOBLE_NORTH.hashValue)
                        } else if (z == 0) && (i == 3 || i == 11) && (j == 4) {
                            specialToken.append(specialTokens.TOKEN_DOBLE_NORTH.hashValue)
                        } else if (z == 0 || z == 1) && (i == 4 || i == 10) && (j == 1) {
                            specialToken.append(specialTokens.TOKEN_DOBLE_NORTH.hashValue)
                        } else {
                            specialToken.append(specialTokens.TOKEN_NORMAL.hashValue)
                        }
                        
                        count += 1
                    }  //end for j
                }  // end for i
            }  // end for z
            break
            
        case boardSet.SPACE_INVADERS.hashValue:
            for z in 0..<boardZ {
                for i in 0..<boardX {
                    for j in 0..<boardY {
                        if z == 0 && (i == 0 || i == 10) && (j == 0 || j == 1 || j == 2 || j == 3 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 1 || i == 9) && (j == 0 || j == 1 || j == 2 || j == 5 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 2 || i == 8) && (j == 1 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 3 || i == 7) && (j == 0 || j == 3 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 4 || i == 6) && (j == 0 || j == 1 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 5) && (j == 0 || j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                            
                        } else if z == 1 && (i == 0 || i == 10) && (j == 0 || j == 1 || j == 2 || j == 3 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 1 || i == 9) && (j == 0 || j == 1 || j == 2 || j == 5 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 2 || i == 8) && (j == 0 || j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 3 || i == 7) && (j == 0 || j == 3 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 4 || i == 6) && (j == 0 || j == 1 || j == 6  || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 5) && (j == 0 || j == 1 || j == 6 || j == 7) {
                            resultArray.append(nil)
                            
                        } else if z == 2 && (i == 0 || i == 10) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 1 || i == 9) && (j != 4) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 2 || i == 8) && (j == 0 || j == 1 || j == 2 || j == 5 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 3 || i == 7) && (j == 0 || j == 1 || j == 3 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 4 || i == 6) && (j == 0 || j == 1 || j == 2  || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 5) && (j == 0 || j == 1 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                            
                        } else if z == 3 && (i < 2 || i > 8) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 2 || i == 8) && (j != 4) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 3 || i == 7) && (j != 4) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 4 || i == 6) && (j == 0 || j == 1 || j == 2 || j == 3 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 5) && (j == 0 || j == 1 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else {
                            addNewTokeToTheList()
                        }
                        specialToken.append(specialTokens.TOKEN_NORMAL.hashValue)
                    }  //end for j
                }  //end for i
            } //end for z
            break
            
        case boardSet.MS_PACMAN.hashValue:
            for z in 0..<boardZ {
                for i in 0..<boardX {
                    for j in 0..<boardY {
                        if z == 0 && i == 0 && (j == 0 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 1 && (j == 1 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 2 && (j == 0) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 3 && (j == 2) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 4 || i == 5) && (j == 4) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 6 && (j == 3 || j == 4 || j == 5) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 7 && (j == 0 || j == 3 || j == 4 || j == 5) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 8 && (j == 0 || j == 1 || j == 3 || j == 4 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 9 || i == 11 || i == 13) && (j != 4) {
                            resultArray.append(nil)
                        } else if z == 0 && (i == 10 || i == 12) {
                            resultArray.append(nil)
                            
                        } else if z == 1 && i == 0 && (j != 1) {
                            resultArray.append(nil)
                        } else if z == 1 && i == 1 && (j == 1 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && i == 2 && (j == 0 || j == 1 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && i == 3 && (j == 0 || j == 2) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 4 || i == 5) && (j == 4) {
                            resultArray.append(nil)
                        } else if z == 1 && i == 6 && (j == 0 || j == 3 || j == 4 || j == 5) {
                            resultArray.append(nil)
                        } else if z == 1 && (i == 7 || i == 8) && (j == 0 || j == 1 || j == 3 || j == 4 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 1 && i == 9 && (j != 4) {
                            resultArray.append(nil)
                        } else if z == 1 && i > 8 {
                            resultArray.append(nil)
                            
                        } else if z == 2 && (i < 2 || i > 8) {
                            resultArray.append(nil)
                        } else if z == 2 && i == 2 && (j == 0 || j == 1 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && i == 3 && (j == 0 || j == 1 || j == 2 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 4 || i == 5) && (j == 0 || j == 4) {
                            resultArray.append(nil)
                        } else if z == 2 && (i == 6 || i == 7 || i == 8) && (j == 0 || j == 1 || j == 3 || j == 4 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 2 && i == 9 && (j != 4) {
                            resultArray.append(nil)
                            
                        } else if z == 3 && (i < 3 || i == 4 || i == 5 || i == 6 || i > 8) {
                            resultArray.append(nil)
                        } else if z == 3 && i == 3 && (j != 5) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 7 || i == 8) && (j == 0 || j == 1 || j == 3 || j == 4 || j == 5 || j == 7) {
                            resultArray.append(nil)
                            
                            
                        } else {
                            addNewTokeToTheList()
                        }
                        
                        if(z == 3 && i == 3 && (j == 5)) {
                            specialToken.append(specialTokens.TOKEN_QUATUPLE_NORTH.hashValue)
                        } else {
                            specialToken.append(specialTokens.TOKEN_NORMAL.hashValue)
                        }
                        
                    } //end if j
                }  //end if i
            }  //end if z
            break
        case boardSet.MARIO_BROS.hashValue:
            for z in 0..<boardZ {
                for i in 0..<boardX {
                    for j in 0..<boardY {
                        if (z == 0 || z == 1 || z == 2) && i == 0 && (j == 0 || j == 1 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 1 && (j == 0 || j == 1 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 2 && (j == 0) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 7 && (j == 0 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 8 && (j == 0 || j == 2 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 9 && (j == 0 || j == 2 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 10 && (j != 4) {
                            resultArray.append(nil)
                            
                            
                        } else if (z == 1 || z == 2) && i == 1 && (j == 0 || j == 1 || j == 3 || j == 4 || j == 6) {
                            resultArray.append(nil)
                        } else if (z == 1 || z == 2) && i == 2 && (j == 0 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if (z == 1 || z == 2) && i == 3 && (j == 3 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if (z == 1 || z == 2) && (i == 4 || i == 5) && (j == 2 || j == 3 || j == 4 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 1 && i == 6 && (j == 4 || j == 6) {
                            resultArray.append(nil)
                        } else if (z == 1 || z == 2) && i == 7 && (j == 0 || j == 2 || j == 3 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if (z == 1 || z == 2) && (i == 8 || i == 9) && (j == 0 || j == 2 || j == 3 || j == 4 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if (z == 1 || z == 2) && i == 10 {
                            resultArray.append(nil)
                            
                            
                        } else if z == 2 && i == 6 && (j == 2 || j == 3 || j == 4 || j == 6) {
                            resultArray.append(nil)
                            
                            
                        } else if z == 3 && i == 2 && (j != 1) {
                            resultArray.append(nil)
                        } else if z == 3 && i == 3 && (j == 2 || j == 3 || j == 4 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 4 || i == 5 || i == 6) && (j >= 2) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 7 || i == 8 || i == 9) && (j != 1) {
                            resultArray.append(nil)
                        } else if z == 3 && (i == 0 || i == 1 || i == 10) {
                            resultArray.append(nil)
                        } else {
                            addNewTokeToTheList()
                        }
                        specialToken.append(specialTokens.TOKEN_NORMAL.hashValue)
                    }  //end if j
                }  //end if i
            } //end if z
            break
            
        case boardSet.TETRIS.hashValue:
            for z in 0..<boardZ {
                for i in 0..<boardX {
                    for j in 0..<boardY {
                        if (z == 0 || z == 1 || z == 2) && (i == 0 || i == 5 || i == 8) && (j <= 2) {
                            resultArray.append(nil)
                        } else if (z == 0 || z == 1 || z == 2) && (i == 1 || i == 2 || i == 4) && (j <= 3) {
                            resultArray.append(nil)
                        } else if (z == 0 || z == 1 || z == 2 || z == 3) && i == 3 && (j <= 3 || j == 5 || j == 7) {
                            resultArray.append(nil)
                        } else if (z == 0 || z == 1) && i == 6 && (j == 0 || j == 1 || j == 5) {
                            resultArray.append(nil)
                        } else if (z == 0 || z == 1) && i == 7 && (j <= 1) {
                            resultArray.append(nil)
                        } else if z == 0 && i == 9 && (j >= 4) {
                            resultArray.append(nil)
                            
                        } else if (z == 1 || z == 2 || z == 3 || z == 4) && i == 9 {
                            resultArray.append(nil)
                            
                        } else if (z == 2) && (i == 1 || i == 2) && (j <= 3 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if (z == 2) && i == 6 && (j <= 3 || j == 5) {
                            resultArray.append(nil)
                        } else if (z == 2) && i == 7 && (j <= 3) {
                            resultArray.append(nil)
                            
                        } else if (z == 3) && (i == 0) && (j <= 5) {
                            resultArray.append(nil)
                        } else if (z == 3) && (i == 1) && (j != 7) {
                            resultArray.append(nil)
                        } else if (z == 3) && (i == 2) && (j <= 3 || j == 5 || j == 6) {
                            resultArray.append(nil)
                        } else if (z == 3) && i == 4 && (j <= 3) {
                            resultArray.append(nil)
                        } else if (z == 3) && i == 5 && (j != 7) {
                            resultArray.append(nil)
                        } else if (z == 3) && i == 6 {
                            resultArray.append(nil)
                        } else if (z == 3) && i == 7 && (j <= 3 || j == 6) {
                            resultArray.append(nil)
                        } else if (z == 3) && i == 8 && (j <= 2) {
                            resultArray.append(nil)
                            
                        } else if (z == 4) && (i <= 2 || i == 6) {
                            resultArray.append(nil)
                        } else if (z == 4) && (i == 3) && (j != 6) {
                            resultArray.append(nil)
                        } else if (z == 4) && (i == 4) && (j <= 5) {
                            resultArray.append(nil)
                        } else if (z == 4) && (i == 5) && (j != 7) {
                            resultArray.append(nil)
                        } else if (z == 4) && (i == 7) && (j <= 3 || j == 6 || j == 7) {
                            resultArray.append(nil)
                        } else if (z == 4) && (i == 8) && (j <= 2 || j >= 5) {
                            resultArray.append(nil)
                            
                        } else {
                            addNewTokeToTheList()
                        }
                        specialToken.append(specialTokens.TOKEN_NORMAL.hashValue)
                        
                    }  //end if j
                }  //end if i
            }  //end if z
            break
        default:
            break
            
        }
        
        //Update special Token (double and cuatripe tokensss)
        count = 0
        for _ in 0..<boardZ {
            for _ in 0..<boardX {
                for _ in 0..<boardY {
                    if specialToken[count] == specialTokens.TOKEN_DOBLE_NORTH.hashValue {
                        resultArray[count + 1] = resultArray[count]
                        specialToken[count + 1] = specialTokens.TOKEN_DOBLE_SOUTH.hashValue
                    }
                    if specialToken[count] == specialTokens.TOKEN_QUATUPLE_NORTH.hashValue {
                        
                        resultArray[count + 1] = resultArray[count]
                        specialToken[count + 1] = specialTokens.TOKEN_QUATUPLE_SOUTH .hashValue
                        
                        resultArray[count + boardY] = resultArray[count]
                        specialToken[count + boardY] = specialTokens.TOKEN_QUATUPLE_EAST_NORTH.hashValue
                        
                        resultArray[count + boardY + 1] = resultArray[count]
                        specialToken[count + boardY + 1] = specialTokens.TOKEN_QUATUPLE_EAST_SOUTH.hashValue
                    }
                    count += 1
                }  //for j
            }   //for i
        } //for z
        
        if arrayOfTokens.count != 0 {
            //ERROR ERROR ERROR this must not happen
            print("ERROR ERROR ERROR no todas las fichas estan puestas")
        }
    }


    
    func addNewTokeToTheList() {
        
        let numRamdom = Int.init(arc4random() % UInt32.init(arrayOfTokens.count))
        
        if arrayNumRepeted[numRamdom] > 0 {
            resultArray.append(arrayOfTokens[numRamdom])
            
            let aux = arrayNumRepeted[numRamdom] - 1
            if aux == 0 {
                arrayNumRepeted.removeAtIndex(numRamdom)
                arrayOfTokens.removeAtIndex(numRamdom)
            } else {
                arrayNumRepeted[numRamdom] = aux
            }
            
        }
    }
    
    
}
