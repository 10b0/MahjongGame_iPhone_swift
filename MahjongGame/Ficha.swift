//
//  Ficha.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 3/30/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit

class Ficha {
    var number = 0
    var libre = true
    var zPos = 0
    var position: CGPoint?
    var size: CGSize?
    var figura: SKSpriteNode?
    var special = specialTokens.TOKEN_NORMAL.hashValue
    var selected = false
    var hint = false
    
    init(number: Int, position: CGPoint, zPos: Int, libre: Bool, special: Int, figura: SKSpriteNode, index: Int) {
        self.number = number
        self.position = position  //coordenadas en la matriz
        self.zPos = zPos
        self.libre = libre
        self.special = special
        self.figura = figura
        
        self.size = figura.size
        self.size = figura.size
        self.figura!.zPosition = CGFloat.init(index)

    }
    

}