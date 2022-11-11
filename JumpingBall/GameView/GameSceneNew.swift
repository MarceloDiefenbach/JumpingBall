//
//  GameSceneNew.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 11/11/22.
//

import Foundation
import SpriteKit
import GameplayKit

class GameScene2: SKScene, SKPhysicsContactDelegate {

    var viewModel: GameViewModel?
    var rightMargin: CGFloat = 0
    var leftMargin: CGFloat = 0
    var center: CGFloat = 0
    var topMargin: CGFloat = 0
    var bottomMargin: CGFloat = 0
    
    // MARK: - Time
    private var lastCurrentTime: Double = -1
    
    //MARK: - Points
    private var pointsToChangeDifficultyOfHard: Int = 20
    private var controlCoinCreate: Bool = true
    
    
    //MARK: - nodes
    private var background: SKSpriteNode = SKSpriteNode()
    
    // MARK: - Collision
    
    let ballCategory: UInt32 = 1 << 3
    let pipeCategory: UInt32 = 1 << 2
    let floorCategory: UInt32 = 1 << 1
    
    //MARK: -
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        createBackground()
        createFloor()
        createObstacle()
        
        rightMargin = (self.scene?.size.width)!/2
        leftMargin = -(self.scene?.size.width)!/2
        topMargin = (self.scene?.size.height)!/2
        bottomMargin = -(self.scene?.size.height)!/2
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == ballCategory) &&
            (contact.bodyB.categoryBitMask == pipeCategory) {
            gameOver()
        } else if (contact.bodyA.categoryBitMask == ballCategory) &&
                    (contact.bodyB.categoryBitMask == floorCategory) {
            gameOver()
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        if lastCurrentTime == -1 {
            lastCurrentTime = currentTime
        }
        
        let deltaTime = currentTime - lastCurrentTime
        
        moveGrounds()
        
        if ((self.viewModel?.didStartGame) != false) {
            
            var time: Double = 3.0
            
            if viewModel?.difficulty == .hard && viewModel!.actualScore > pointsToChangeDifficultyOfHard {
                time = 2.0
            }
            print(time)
            
            if deltaTime > time {
                
                createObstacle()
                
                lastCurrentTime = currentTime
                controlCoinCreate = true
            }
            
            if deltaTime > 1.5 && controlCoinCreate == true {
                createCoin(sizeTop: 1)
                controlCoinCreate = false
            }
            movePipes()
        }
        setPipesPhysics()
        
        removePipes()
        
//        updateScore()
    }
    
    //MARK: - create functions
    
    func createBackground() {
        for index in 0...3 {
            let background = SKSpriteNode(imageNamed: "Background")
            background.name = "Background"
            
            let backgroundSize = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            background.size = backgroundSize
            
            let backgroundPosition = CGPoint(x: (CGFloat(index) * (self.scene?.size.width)!), y: 0)
            background.position = backgroundPosition
            
            addChild(background)
        }
    }
    
    func createFloor() {
        for index in 0...3 {
            let floor = SKSpriteNode()
            floor.name = "Floor"
            
            let floorSize = CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!)
            floor.size = floorSize
            
            let floorPosition = CGPoint(x: (CGFloat(index) * (self.scene?.size.width)!), y: 0)
            floor.position = floorPosition
            floor.zPosition = 0.9
            
            addChild(floor)
        }
    }
    
    func moveGrounds() {
        self.enumerateChildNodes(withName: "Background") { node, error in
            node.position.x -= 2
            if node.position.x < -((self.scene?.size.width)!) {
                node.position.x += ((self.scene?.size.width)! * 3)
            }
        }
        self.enumerateChildNodes(withName: "Floor") { node, error in
            node.position.x -= 2
            if node.position.x < -((self.scene?.size.width)!) {
                node.position.x += ((self.scene?.size.width)! * 3)
            }
        }
    }
    
    func createObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "Pipe")
        obstacle.name = "Obstacle"
        
        let obstacleSize = CGSize(width: 30, height: 180)
        obstacle.size = obstacleSize
        
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.frame.size)
        obstacle.physicsBody!.affectedByGravity = false
        obstacle.physicsBody!.usesPreciseCollisionDetection = true
        obstacle.physicsBody!.isDynamic = false
        
        obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        obstacle.position.x = (self.scene?.size.width)!/2 + 180
        obstacle.position.y = CGFloat(getRandomPositionToObstacle())
        obstacle.zPosition = 0.8
        
        rotatePipe(node: obstacle)
        
        addChild(obstacle)
    }
    
    func createCoin(sizeTop: Int) {
        let coin = SKSpriteNode(imageNamed: "coin")
        coin.name = "coin"
        
        let coinSize = CGSize(width: 40, height: 40)
        coin.size = coinSize
        
        coin.physicsBody = SKPhysicsBody(rectangleOf: coin.frame.size)
        coin.physicsBody!.affectedByGravity = false
        coin.physicsBody!.usesPreciseCollisionDetection = true
        coin.physicsBody!.isDynamic = false
        
        coin.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let yPipe = 0
        let xPipe = (self.scene?.size.width)!/2 + 30
        coin.position.x = xPipe
        coin.position.y = CGFloat(yPipe)
        coin.zPosition = 0.8
        
        addChild(coin)
    }
    
    //MARK: - actions
    
    func rotatePipe(node: SKSpriteNode) {
        var rotateAction: SKAction
        
        rotateAction = SKAction.rotate(byAngle: CGFloat(180), duration: 1)
        
        let rotateSequence = SKAction.sequence([rotateAction])
        let rotateRepeat = SKAction.repeatForever(rotateSequence)
        
        node.run(rotateRepeat)
    }
    
    func movePipes() {
        
        var moveValue: CGFloat = 2
        
        if viewModel?.difficulty == .hard && viewModel!.actualScore > pointsToChangeDifficultyOfHard {
            moveValue = 3
        }
        
        self.enumerateChildNodes(withName: "Obstacle") { node, error in
            node.position.x -= moveValue
            if node.position.x < -((self.scene?.size.width)!) {
                node.position.x += ((self.scene?.size.width)! * 3)
            }
        }
        self.enumerateChildNodes(withName: "coin") { node, error in
            node.position.x -= moveValue
            if node.position.x < -((self.scene?.size.width)!) {
                node.position.x += ((self.scene?.size.width)! * 3)
            }
        }
        
    }
    
    func setPipesPhysics() {
        self.enumerateChildNodes(withName: "Obstacle") { node, error in
            guard let body = node.physicsBody else { return }
            body.usesPreciseCollisionDetection = true
            body.categoryBitMask = self.pipeCategory
        }
        
        self.enumerateChildNodes(withName: "coin") { node, error in
            guard let body = node.physicsBody else { return }
            body.usesPreciseCollisionDetection = true
            body.categoryBitMask = self.pipeCategory
        }
    }
    
    func removePipes() {
        self.enumerateChildNodes(withName: "Obstacle") { node, error in
            if node.position.x <= -((self.scene?.size.width)!)/2 - 100{
                node.removeFromParent()
            }
        }

        self.enumerateChildNodes(withName: "coin") { node, error in
            if node.position.x <= -((self.scene?.size.width)!)/2 - 100 {
                node.removeFromParent()
            }
        }
    }
    
    //MARK: - logic functions
    
    func getRandomPositionToObstacle() -> Int {
        let random = Int.random(in: Int(-(self.scene?.size.height)!/2)..<Int((self.scene?.size.height)!/2))
        return random
    }
    
    func gameOver() {
        GameDataBase.standard.setHighScore(newHighScore: self.viewModel!.actualScore, difficulty: viewModel!.difficulty)
        
        self.viewModel!.isGameOver = true
        self.viewModel!.isPresentingView = .winView
        scene?.view?.isPaused = true
    }
}
