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
var boardSelected = boardSet.TURTLE.hashValue
var tilesSelected = tilesSet.ORIGINAL.hashValue

let MENU_SPEED: NSTimeInterval = 1

enum gameStates {
    case MAIN_MENU_SCREEN
    case SELECT_BOARD_SCREEN
    case SELECT_TOKEN_SCREEN
    case OPTIONS_SCREEN
    case HELP_SCREEN
    case ABOUT_SCREEN
    case STATE_GAMEPLAY
    case IN_GAME_MENU
    case IN_GAME_MENU_HELP
    case IN_GAME_MENU_SELECT_TOKEN
}

enum tilesSet {
    case ORIGINAL
    case MEMES
    case TILES_MAX
}

enum boardSet {
    case TURTLE
    case PYRAMID
    case SPIDER
    case SPACE_INVADERS
    case MS_PACMAN
    case MARIO_BROS
    case TETRIS
    case BOARD_MAX
}


enum specialTokens {
    case TOKEN_NORMAL
    case TOKEN_DOBLE_NORTH
    case TOKEN_DOBLE_SOUTH
    case TOKEN_QUATUPLE_NORTH
    case TOKEN_QUATUPLE_SOUTH
    case TOKEN_QUATUPLE_EAST_NORTH
    case TOKEN_QUATUPLE_EAST_SOUTH
}

//enum gameStates {
//    case STATE_GAMEPLAY
//    case STATE_INGAME_MENU
//}


    
var backButton: SKSpriteNode?
var stackStates = NSMutableArray()
//var redraw = false

func drawBackButton(scene: SKNode) {
    if initState {
        backButton = TextAndButtons.createdSmallButton()
    }
    TextAndButtons.drawButton(backButton!, text: "Back", position: CGPointMake(CGRectGetMaxX(scene.frame) - backButton!.size.width/2 - 10, backButton!.size.height/2 + 10), scene: scene)
}

func updateBackButton(point: CGPoint, ended: Bool) {
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
    currentState = stackStates.lastObject!.integerValue

    initState = true
    
}

func changeState(newState: Int) {
    // Main Menu and In Game Menu are the root states, the first states, this not have previous stages that why the stack most be clean
    if newState == gameStates.MAIN_MENU_SCREEN.hashValue || newState == gameStates.STATE_GAMEPLAY.hashValue {
        stackStates = NSMutableArray()   //clean the stack
    }
    
    let value = NSNumber(integer: newState)
    stackStates.addObject(value)
    currentState = newState

    initState = true

}


