//
//  Sound.swift
//  MahjongGame
//
//  Created by David Fernando Alatorre Guerrero on 4/10/16.
//  Copyright © 2016 David Fernando Alatorre Guerrero. All rights reserved.
//

//import Foundation
import AVFoundation
import SpriteKit

class Sound {
 
    var activeSounds = false
    var mainThemeMusic: AVAudioPlayer?
    
    init(activeSounds: Bool, withMainTheme: Bool) {
    
        if withMainTheme {
            
           // let path = NSBundle.mainBundle().URLForResource("main_theme", withExtension: "m4a")
            let path = Bundle.main.url(forResource: "main_theme", withExtension: "m4a", subdirectory: "sounds")
            
            if let songPath = path {
                do {
                    mainThemeMusic = try AVAudioPlayer(contentsOf: songPath)
                    mainThemeMusic?.numberOfLoops = -1
                    mainThemeMusic?.volume = 0.03
                    self.activeSounds = activeSounds
                } catch {
                    print("error creating the Auido player from the main theme")
                }
            } else {
                print("No find sound")
            }
            
        } else {
            self.activeSounds = activeSounds
        }
    }
    
    
    func playSound(_ name: String, scene: SKScene) {
        
        if activeSounds {
            scene.run(SKAction.playSoundFileNamed("sounds/" + name, waitForCompletion: false))
        }
    }
    
    func playMainMusic() {
        if activeSounds {
            if let mainTheme = mainThemeMusic {
                mainTheme.play()
            }
        }
    }
    
    func stopMainMusic() {
        if let mainTheme = mainThemeMusic {
            mainTheme.stop()
        }
    }
}


