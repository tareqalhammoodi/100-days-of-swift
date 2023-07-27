//
//  GameScene.swift
//  Project11
//
//  Created by Tareq Alhammoodi on 27.07.2023.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var editLabel: SKLabelNode!
    var scoreLabel: SKLabelNode!
    var ballsNumberLabel: SKLabelNode!
    var balls = ["ballBlue", "ballCyan", "ballGreen", "ballGrey", "ballPurple", "ballRed", "ballYellow"]
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editLabel.text = "Done"
            } else {
                editLabel.text = "Edit"
            }
        }
    }
    var ballsNumber = 5 {
        didSet {
            ballsNumberLabel.text = "Balls: \(ballsNumber)"
            if ballsNumber == 0 {
                endTheGame()
            }
        }
    }
    
    override func didMove(to view: SKView) {
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x: 512, y: 384)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: \(score)"
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        ballsNumberLabel = SKLabelNode(fontNamed: "Chalkduster")
        ballsNumberLabel.text = "Balls: \(ballsNumber)"
        ballsNumberLabel.horizontalAlignmentMode = .right
        ballsNumberLabel.position = CGPoint(x: 980, y: 650)
        addChild(ballsNumberLabel)
        
        editLabel = SKLabelNode(fontNamed: "Chalkduster")
        editLabel.text = "Edit"
        editLabel.position = CGPoint(x: 80, y: 700)
        addChild(editLabel)
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        
        makeSlot(at: CGPoint(x: 128, y: 30), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 30), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 30), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 30), isGood: false)
        
        makeBouncer(at: CGPoint(x: 0, y: 10))
        makeBouncer(at: CGPoint(x: 256, y: 10))
        makeBouncer(at: CGPoint(x: 512, y: 10))
        makeBouncer(at: CGPoint(x: 768, y: 10))
        makeBouncer(at: CGPoint(x: 1024, y: 10))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let objects = nodes(at: location)
        if objects.contains(editLabel) {
            editingMode.toggle()
        } else {
            if editingMode {
                let size = CGSize(width: Int.random(in: 16...128), height: 16)
                let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                box.zRotation = CGFloat.random(in: 0...3)
                box.position = location
                box.physicsBody = SKPhysicsBody(rectangleOf: box.size)
                box.physicsBody?.isDynamic = false
                box.name = "box"
                addChild(box)
            } else {
                if location.y > 500 && ballsNumber > 0 {
                    let ball = SKSpriteNode(imageNamed: balls.randomElement() ?? "ballRed")
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0)
                    ball.physicsBody?.restitution = 0.4
                    ball.physicsBody?.contactTestBitMask = ball.physicsBody?.collisionBitMask ?? 0
                    ball.position = location
                    ball.name = "ball"
                    addChild(ball)
                }
            }
        }
    }
    
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer")
        bouncer.position = position
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false
        addChild(bouncer)
    }
    
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"
        }
        slotBase.position = position
        slotGlow.position = position
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)
        slotBase.physicsBody?.isDynamic = false
        addChild(slotBase)
        addChild(slotGlow)
        let spin = SKAction.rotate(byAngle: .pi, duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
    }
    
    func collision(between ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(element: ball)
            score += 1
            ballsNumber += 1
        } else if object.name == "bad" {
            destroy(element: ball)
            ballsNumber -= 1
        }
        if object.name == "box" {
            destroy(element: object)
        }
    }
    
    func destroy(element: SKNode) {
        if let fireParticles = SKEmitterNode(fileNamed: "FireParticles") {
            fireParticles.position = element.position
            addChild(fireParticles)
        }
        element.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        if nodeA.name == "ball" {
            collision(between: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collision(between: nodeB, object: nodeA)
        }
    }
    
    func endTheGame() {
        isUserInteractionEnabled = false
        let alert = UIAlertController(title: "Game Over!", message: "Let's try again.", preferredStyle: UIAlertController.Style.alert)
        if let vc = self.scene?.view?.window?.rootViewController {
            vc.present(alert, animated: true, completion: nil)
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) { [weak self] in
            alert.dismiss(animated: true, completion: nil)
            self?.replay()
        }
    }
    
    func replay() {
        let newScene = GameScene(size: self.size)
        newScene.scaleMode = self.scaleMode
        self.view?.presentScene(newScene, transition: SKTransition.fade(withDuration: 1.0))
    }
    
}
