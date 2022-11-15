//
//  ContentView.swift
//  JumpingBall
//
//  Created by Marcelo Diefenbach on 08/11/22.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var viewModel: GameViewModel?
    var coordinator: Coordinator?

    // MARK: - Time
    private var lastCurrentTime: Double = -1
    
    // MARK: - Game
    private var outsidePipe: Bool = true
    private var pointsToChangeDifficultyOfHard: Int = 20
    private var controlCoinCreate: Bool = true
    
    // MARK: - Nodes
    private var background: SKSpriteNode = SKSpriteNode()
    private var ball: SKSpriteNode = SKSpriteNode()
    
    // MARK: - Animation
    
    private var birdFlyingFrames: [SKTexture] = []
    
    // MARK: - Collision
    
    let coinCategory: UInt32 = 1 << 4
    let ballCategory: UInt32 = 1 << 3
    let obstacleCategory: UInt32 = 1 << 2
    let floorCategory: UInt32 = 1 << 1
    
    // MARK: - Init
    
    override func didMove(to view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        createBackground()
        createBall()
        createFloor()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        self.view?.addGestureRecognizer(tapGesture)
        
        physicsWorld.contactDelegate = self
        
    }
    
    // MARK: - Handlers
    
    @objc func tap() {
        if self.viewModel!.didStartGame {
            jump()
        } else {
            setPhysics()
            self.viewModel!.didStartGame = true
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    func jump() {
        ball.physicsBody?.isDynamic = false
        ball.physicsBody?.isDynamic = true
        ball.physicsBody?.applyImpulse(CGVector(dx: 0.0, dy: 17.0))
    }
    
    // MARK: - Physics
    
    func setPhysics() {
        let birdPhysicsBody = SKPhysicsBody(rectangleOf: ball.frame.size)
        birdPhysicsBody.isDynamic = true
        birdPhysicsBody.affectedByGravity = true
        birdPhysicsBody.restitution = 0
        birdPhysicsBody.usesPreciseCollisionDetection = true
        birdPhysicsBody.categoryBitMask = ballCategory
        birdPhysicsBody.collisionBitMask = ballCategory | obstacleCategory | floorCategory | coinCategory
        birdPhysicsBody.contactTestBitMask = ballCategory | obstacleCategory | floorCategory | coinCategory
        ball.physicsBody = birdPhysicsBody
        
        let floor = SKSpriteNode(color: .clear, size: CGSize(width: (self.scene?.size.width)!, height: 1))
        floor.position = CGPoint(x: 0, y: -((self.scene?.size.height)! / 2))
        floor.zPosition = 0
        
        let floorPhysicsBody = SKPhysicsBody(rectangleOf: floor.frame.size)
        floorPhysicsBody.isDynamic = false
        floorPhysicsBody.affectedByGravity = false
        floorPhysicsBody.usesPreciseCollisionDetection = true
        floorPhysicsBody.categoryBitMask = floorCategory
        floor.physicsBody = floorPhysicsBody
        
        let ceiling = SKSpriteNode(color: .clear, size: CGSize(width: (self.scene?.size.width)!, height: (self.scene?.size.height)!*0.15))
        ceiling.position = CGPoint(x: 0, y: ((self.scene?.size.height)! / 2))
        ceiling.zPosition = 0
        
        let ceilingPhysicsBody = SKPhysicsBody(rectangleOf: ceiling.frame.size)
        ceilingPhysicsBody.isDynamic = false
        ceiling.physicsBody = ceilingPhysicsBody
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -4)
        
        addChild(floor)
        addChild(ceiling)
    }
    
    // MARK: - Collision
    
    func didBegin(_ contact: SKPhysicsContact) {
        if (contact.bodyA.categoryBitMask == ballCategory) &&
                    (contact.bodyB.categoryBitMask == coinCategory) {
            self.viewModel!.coinsCollected += 1
            print(self.viewModel!.coinsCollected)
            contact.bodyB.node?.removeFromParent()
        } else if (contact.bodyA.categoryBitMask == ballCategory) &&
            (contact.bodyB.categoryBitMask == obstacleCategory) {
            gameOver()
        } else if (contact.bodyA.categoryBitMask == ballCategory) &&
                    (contact.bodyB.categoryBitMask == floorCategory) {
            gameOver()
        }
    }
    
    // MARK: - Background and Floor
    
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
            
            let floorSize = CGSize(width: (self.scene?.size.width)!, height: 1)
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
    
    // MARK: - Bird
    
    func createBall() {
        let birdAnimatedAtlas = SKTextureAtlas(named: "Bird")
        var flyFrames: [SKTexture] = []
        
        let numImages = birdAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let birdTextureName = "Bird\(i)"
            flyFrames.append(birdAnimatedAtlas.textureNamed(birdTextureName))
        }
        
        birdFlyingFrames = flyFrames
        
        let firstFrameTexture = birdFlyingFrames[0]
        ball = SKSpriteNode(texture: firstFrameTexture)
        
        let birdSize = CGSize(width: 40, height: 40)
        ball.size = birdSize
        
        let birdPosition = CGPoint(x: -((self.scene?.size.width)! / 2) * 0.6, y: 0)
        ball.position = birdPosition
        ball.zPosition = 0.8
        
        addChild(ball)
    }
    
    // MARK: - Pipes
    
    
    func rotateObstacle(node: SKSpriteNode) {
        var rotateAction: SKAction
        
        rotateAction = SKAction.rotate(byAngle: CGFloat(180), duration: 1)
        
        let rotateSequence = SKAction.sequence([rotateAction])
        let rotateRepeat = SKAction.repeatForever(rotateSequence)
        
        node.run(rotateRepeat)
    }
    
    func createObstacle() {
        let obstacle = SKSpriteNode(imageNamed: "Pipe")
        obstacle.name = "Obstacle"
        
        let obstacleSize = CGSize(width: 30, height: 200)
        obstacle.size = obstacleSize
        
        obstacle.physicsBody = SKPhysicsBody(rectangleOf: obstacle.frame.size)
        obstacle.physicsBody!.affectedByGravity = false
        obstacle.physicsBody!.usesPreciseCollisionDetection = true
        obstacle.physicsBody!.isDynamic = false
        
        obstacle.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        obstacle.position.x = (self.scene?.size.width)!/2 + 180
        obstacle.position.y = CGFloat(getRandomPositionToObstacle())
        obstacle.zPosition = 0.8
        
        rotateObstacle(node: obstacle)
        
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
        coin.physicsBody!.categoryBitMask = coinCategory
        
        coin.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        
        let xPipe = (self.scene?.size.width)!/2 + 40
        coin.position.x = xPipe
        coin.position.y = CGFloat(getRandomPositionToObstacle())
        coin.zPosition = 0.8
        
        addChild(coin)
    }
    
    func movePipes() {
        
        var moveValue: CGFloat = 2
        
//        if viewModel?.difficulty == .hard && viewModel!.actualScore > pointsToChangeDifficultyOfHard {
//            moveValue = 3
//        }
        
        if viewModel!.level == 1 {
            moveValue = 3
        }
        if viewModel!.level == 2 {
            moveValue = 4
        }
        if viewModel!.level == 3 {
            moveValue = 5
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
            body.categoryBitMask = self.obstacleCategory
        }
        self.enumerateChildNodes(withName: "coin") { node, error in
            guard let body = node.physicsBody else { return }
            body.usesPreciseCollisionDetection = true
            body.categoryBitMask = self.coinCategory
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
    
    // MARK: - Score
    
    func collectCoins() {
        self.viewModel!.coinsCollected += 1
        print(self.viewModel!.coinsCollected)
    }
    
    func updateScore() {
        
        if self.viewModel!.actualScore == 10 {
            self.viewModel!.level = 2
        }
        if self.viewModel!.actualScore == 20 {
            self.viewModel!.level = 3
        }
        if self.viewModel!.actualScore == 30 {
            self.viewModel!.level = 4
        }
        if self.viewModel!.actualScore == 40 {
            self.viewModel!.level = 5
        }
    }
    
    // MARK: - Game Over
    
    func gameOver() {
        GameDataBase.standard.setHighScore(newHighScore: self.viewModel!.actualScore, difficulty: viewModel!.difficulty)
        GameDataBase.standard.setCoinsAmount(newValue: viewModel!.coinsCollected)
        
        self.viewModel!.isGameOver = true
        self.coordinator!.isPresentingView = .winView
        scene?.view?.isPaused = true
    }
    
    // MARK: - Update
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if ball.position.x != -((self.scene?.size.width)! / 2) * 0.6 {
            ball.position.x = -((self.scene?.size.width)! / 2) * 0.6
        }
        
        if self.viewModel!.isGameOver {
            let newScene = GameScene()
                newScene.size = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                newScene.scaleMode = .fill
                newScene.viewModel = self.viewModel
                newScene.coordinator = self.coordinator
                let animation = SKTransition.fade(withDuration: 0)
                self.view?.presentScene(newScene, transition: animation)
                self.view?.isPaused = false
            

            self.viewModel!.isGameOver = false
            self.viewModel!.didStartGame = false
        }
        
        if lastCurrentTime == -1 {
            lastCurrentTime = currentTime
        }
        
        let deltaTime = currentTime - lastCurrentTime
        
        moveGrounds()
        
        if ((self.viewModel?.didStartGame) != false) {
            
            var obstacleTime: Double = 3.0
            var cointTime: Double = 1.5
            
            if viewModel?.difficulty == .hard && viewModel!.actualScore > pointsToChangeDifficultyOfHard {
                obstacleTime = 1.3
                cointTime = 2.2
            }
            
            if deltaTime > obstacleTime {
                
                createObstacle()
                
                lastCurrentTime = currentTime
                controlCoinCreate = true
                self.viewModel!.actualScore += 1
            }
            
            if deltaTime > cointTime && controlCoinCreate == true {
                createCoin(sizeTop: 1)
                controlCoinCreate = false
            }
            movePipes()
        }
        setPipesPhysics()
        
        removePipes()
        
        updateScore()

    }
    
    //MARK: - logic functions
    
    func getRandomPositionToObstacle() -> Int {
        let random = Int.random(in: Int(-(self.scene?.size.height)!/2)..<Int((self.scene?.size.height)!/2))
        return random
    }
}

