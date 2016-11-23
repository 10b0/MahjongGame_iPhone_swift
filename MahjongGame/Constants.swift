//
//  Constants.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 3/30/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit

let orangeColorBackground = UIColor.init(red: 0.992, green: 0.686, blue: 0.243, alpha: 1.0)
var initState = true
var currentState = 0
var boardSelected = boardSet.turtle.hashValue
var tilesSelected = tilesSet.original.hashValue

let MENU_SPEED: TimeInterval = 1

enum gameStates {
    case main_MENU_SCREEN
    case select_BOARD_SCREEN
    case select_TOKEN_SCREEN
    case options_SCREEN
    case help_SCREEN
    case about_SCREEN
    case state_GAMEPLAY
    case in_GAME_MENU
    case in_GAME_MENU_HELP
    case in_GAME_MENU_SELECT_TOKEN
}

enum tilesSet {
    case original
    case memes
    case tiles_MAX
}

enum boardSet {
    case turtle
    case pyramid
    case spider
    case space_INVADERS
    case ms_PACMAN
    case mario_BROS
    case tetris
    case board_MAX
}


enum specialTokens {
    case token_NORMAL
    case token_DOBLE_NORTH
    case token_DOBLE_SOUTH
    case token_QUATUPLE_NORTH
    case token_QUATUPLE_SOUTH
    case token_QUATUPLE_EAST_NORTH
    case token_QUATUPLE_EAST_SOUTH
}

//enum gameStates {
//    case STATE_GAMEPLAY
//    case STATE_INGAME_MENU
//}


    
var backButton: SKSpriteNode?
var stackStates = NSMutableArray()
//var redraw = false

func drawBackButton(_ scene: SKNode) {
    if initState {
        backButton = TextAndButtons.createdSmallButton()
    }
    TextAndButtons.drawButton(backButton!, text: "Back", position: CGPoint(x: scene.frame.maxX - backButton!.size.width/2 - 10, y: backButton!.size.height/2 + 10), scene: scene)
}

func updateBackButton(_ point: CGPoint, ended: Bool) {
  //  backButton!.colorBlendFactor = 1.0
    
    if TextAndButtons.checkTouch(point, button: backButton!, ended: ended) {
        if ended {
            pullState()
        }
    }
}

func pullState() {

    // the first state, this not have previous stages
    if stackStates.count <= 1 {
        return
    }
    
    stackStates.removeLastObject()
    currentState = (stackStates.lastObject! as AnyObject).intValue

    initState = true
    
}

func changeState(_ newState: Int) {
    // Main Menu and In Game Menu are the root states, the first states, this not have previous stages that why the stack most be clean
    if newState == gameStates.main_MENU_SCREEN.hashValue || newState == gameStates.state_GAMEPLAY.hashValue {
        stackStates = NSMutableArray()   //clean the stack
    }
    
    let value = NSNumber(value: newState as Int)
    stackStates.add(value)
    currentState = newState

    initState = true

}


