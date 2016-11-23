//
//  TextAndButtons.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 3/28/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

import SpriteKit


class TextAndButtons {
    
    static func drawText(_ text: String, size: CGFloat, position: CGPoint, scene: SKNode) {
        let label = SKLabelNode(fontNamed: "Superclarendon-Black")
        label.fontSize = size
        label.position = position
        label.text = text
        label.fontColor = UIColor.black
        label.zPosition = 600
        scene.addChild(label)
    }
    
    
    static func createdButton() -> SKSpriteNode {
        return SKSpriteNode(imageNamed: "boton_large")
    }
    
    
    static func createdSmallButton() -> SKSpriteNode {
        return SKSpriteNode.init(imageNamed: "boton")
    }
    
    static func createdArrowButton(_ right: Bool) -> SKSpriteNode {
        let button = SKSpriteNode.init(imageNamed: "buttonArrowBack")
        if right {
            button.zRotation = CGFloat.init(M_PI)
        }
        return button
    }
    
    static func createdBigArrowButton(_ right: Bool) -> SKSpriteNode {
        let button = SKSpriteNode.init(imageNamed: "big_arrow")
        if right {
            button.zRotation = CGFloat.init(M_PI)
        }
        return button
    }

    
    static func drawButton(_ button: SKSpriteNode, text: String, position: CGPoint, scene: SKNode) {
        
        // Config and draw button
        button.position = position
        button.zPosition = 600
        scene.addChild(button)
        
        // Config and draw text of the button
        let buttonText = SKLabelNode(fontNamed: "Superclarendon-Black")
        buttonText.text = text
        buttonText.fontSize = 30
        buttonText.position = CGPoint(x: button.position.x, y: button.position.y - button.frame.size.height/6)
        buttonText.zPosition = button.zPosition + 1
        buttonText.fontColor = UIColor.black
        scene.addChild(buttonText)
        
    }
    
    
    static func checkTouch(_ touch: CGPoint, button: SKSpriteNode, ended: Bool) -> Bool {
        let position = button.position
        let size = button.size

        button.colorBlendFactor = 1.0
        button.color = UIColor.white
        
        if touch.x >= position.x - size.width/2 && touch.x <= position.x + size.width/2 {
            if touch.y <= position.y + size.height/2 && touch.y >= position.y - size.height/2 {
                if !ended {
                    button.colorBlendFactor = 0.5
                    button.color = UIColor.black
                }
                return true
            }
        }
        return false
    }

}


