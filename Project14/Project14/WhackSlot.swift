//
//  WhackSlot.swift
//  Project14
//
//  Created by Tareq Alhammoodi on 8.08.2023.
//

import UIKit
import SpriteKit

class WhackSlot: SKNode {
    
    var charNode: SKSpriteNode!
    var isHit = false
    var isVisible = false
    
    func configure(at position: CGPoint) {
        self.position = position
        let sprite = SKSpriteNode(imageNamed: "whackHole")
        addChild(sprite)
        let cropNode = SKCropNode()
        cropNode.position = CGPoint(x: 0, y: 15)
        cropNode.zPosition = 1
        cropNode.maskNode = SKSpriteNode(imageNamed: "whackHole")
        charNode=SKSpriteNode(imageNamed: "penguinGood")
        charNode.position = CGPoint(x: 0, y: -90)
        charNode.name = "character"
        cropNode.addChild(charNode)
        addChild(cropNode)
    }
    
    func show(hideTime: Double) {
        if isVisible { return }
        charNode.xScale = 1
        charNode.yScale = 1
        if let mud = SKEmitterNode(fileNamed: "Mud") {
            mud.position = CGPoint(x: charNode.position.x, y: charNode.position.y + 50)
            showEffect(particleNode: mud)
        }
        charNode.run(SKAction.moveBy(x: 0, y: 80, duration: 0.05))
        isVisible = true
        isHit = false
        if Int.random(in: 0...2) == 0 {
            charNode.texture = SKTexture(imageNamed: "penguinGood")
            charNode.name = "charFriend"
        } else {
            charNode.texture = SKTexture(imageNamed: "penguinEvil")
            charNode.name = "charEnemy"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + (hideTime * 3.5)) { [weak self] in
            self?.hide()
        }
    }
    
    func hide() {
        if !isVisible { return }
        if let mud = SKEmitterNode(fileNamed: "Mud") {
            mud.position = CGPoint(x: charNode.position.x, y: charNode.position.y - 30)
            mud.particleColor = .brown
            showEffect(particleNode: mud)
        }
        charNode.run(SKAction.moveBy(x: 0, y: -80, duration: 0.05))
        isVisible = false
    }
    
    func hit() {
        isHit = true
        let smoke = SKEmitterNode(fileNamed: "Smoke")!
        showEffect(particleNode: smoke)
        let delay = SKAction.wait(forDuration: 0.5)
        let hide = SKAction.moveBy(x: 0, y: -80, duration: 0.5)
        let notVisible = SKAction.run { [weak self] in self?.isVisible = false }
        let sequence = SKAction.sequence([delay, hide, notVisible])
        charNode.run(sequence)
    }
    
    func showEffect(particleNode: SKEmitterNode) {
        let effect = SKAction.run { [weak self] in
            self?.addChild(particleNode)
        }
        let duration = SKAction.wait(forDuration: 2)
        let removal = SKAction.run { [weak self] in
            self?.removeChildren(in: [particleNode])
        }
        run(SKAction.sequence([effect, duration, removal]))
    }

}
