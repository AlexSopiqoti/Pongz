//
//  ViewController.swift
//  Pongz
//
//  Created by Aleksander Sopiqoti on 24/08/2018.
//  Copyright © 2018 Aleksander Sopiqoti. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties

    var xMax: CGFloat = 0
    var yMax:CGFloat = 0

    //MARK: - Settings
   
    private let playerSpeed: CGFloat = 20
    private let gameUpdateSpeed: TimeInterval = 1 / 120
    private var ballSpeedX: CGFloat = 1
    private var ballSpeedY: CGFloat = 1
    
    // MARK: Properties
    
    private var timer: Timer!
    
    // MARK: - Outlets

    @IBOutlet weak var skynetView: UIView!
    @IBOutlet weak var ballView: UIView!
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var leftButton: UIButton!
    @IBOutlet weak var rightButton: UIButton!
    
    // MARK: - Action Buttons

    @IBAction func leftButtonPressed(_ sender: UIButton) {
        if playerView.frame.origin.x <= 0 {
        
        } else {
            playerView.frame.origin.x -= playerSpeed
        }
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
       if playerView.frame.origin.x + playerView.bounds.width >= xMax {
            playerView.frame.origin.x = xMax - playerView.bounds.width
        
       } else {
            playerView.frame.origin.x += playerSpeed
        }
    }
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


//MARK: - Ball Collision Detection

fileprivate extension ViewController {
    
    func ballCollision(){
        //Left Bound
        if ballView.frame.origin.x <= 0 {
            ballSpeedX = -ballSpeedX
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY )
            AudioServicesPlaySystemSound(1519)
            
            //Upper Bound
        } else if ballView.frame.origin.y <= 0 {
            ballSpeedY = -ballSpeedY
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY )
            AudioServicesPlaySystemSound(1519)
            
            //Right Bound
        } else if ballView.frame.origin.x + ballView.bounds.width >= xMax {
            ballSpeedX = -ballSpeedX
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
            AudioServicesPlaySystemSound(1519)
            
            //Lower Bound - Reset Ball Position
        } else if gameIsEnded() {
            centerBall()
            resetBallSpeed()
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
            AudioServicesPlaySystemSound(1520)
            
            //Left-Up Corner
        } else if ballView.frame.origin.x <= 0 && ballView.frame.origin.y <= 0 {
            ballSpeedX = -ballSpeedX
            ballSpeedY = -ballSpeedY
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
            AudioServicesPlaySystemSound(1519)
            
            //Right-Up Corner
        } else if ballView.frame.origin.y <= 0 && ballView.frame.origin.x + ballView.bounds.width >= xMax {
            ballSpeedX = -ballSpeedX
            ballSpeedY = -ballSpeedY
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
            AudioServicesPlaySystemSound(1519)
            
            //Right-Down Corner
        } else if ballView.frame.origin.x + ballView.bounds.width >= xMax && ballView.frame.origin.y + ballView.bounds.height >= yMax {
            ballSpeedX = -ballSpeedX
            ballSpeedY = -ballSpeedY
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
            AudioServicesPlaySystemSound(1519)
            
            //Left-Down Corner
        } else if ballView.frame.origin.x <= 0 && ballView.frame.origin.y + ballView.bounds.height >= yMax {
            ballSpeedX = -ballSpeedX
            ballSpeedY = -ballSpeedY
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
            AudioServicesPlaySystemSound(1519)
            
        } else {
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
        }
    }
    
    func ballCollisionWithPlayer() {
        
        if ballView.frame.origin.y + ballView.bounds.height == playerView.frame.origin.y && ( ballView.frame.origin.x >= playerView.frame.origin.x && ballView.frame.origin.x <= playerView.frame.origin.x + playerView.bounds.width ) {
            ballSpeedX = -ballSpeedX
            ballSpeedY = -ballSpeedY
            updateBallPosition(speedX: ballSpeedX, speedY: ballSpeedY)
        }
    }
    
    func updateBallPosition(speedX: CGFloat , speedY: CGFloat) {
        ballView.frame.origin.x -= speedX
        ballView.frame.origin.y -= speedY
    }
    
    func resetBallSpeed() {
        ballSpeedX = 1
        ballSpeedY = 1
    }
}

// MARK: - Player

fileprivate extension ViewController {
    
    func setPlayerViewPosition(withPositionX positionX: CGFloat, withPositionY positionY: CGFloat?) {
        playerView.frame.origin.x = positionX - playerView.ofsetedWidth()
    }
}

// MARK: - Controller Setup

fileprivate extension ViewController {
    
    func setupController() {
        // Set screen size
        xMax = self.view.frame.maxX
        yMax = self.view.frame.maxY
        
        // Make ball round
        ballView.layer.cornerRadius = ballView.frame.width / 2
        
        setUpPlayerView()
        setUpballView()
        setUpSkynet()
        setUpLeftButton()
        setUpRightButton()
        
        setupGameLifeCycle()
    }
    
    func setupGameLifeCycle() {
        timer = Timer.scheduledTimer(withTimeInterval: gameUpdateSpeed, repeats: true, block: { timer in
            self.updateGame()
        })
        timer.fire()
    }
    
    func setUpPlayerView() {
        let origin = CGPoint(x: xMax / 2 - playerView.ofsetedWidth(), y: yMax - playerView.bounds.height)
        let size = CGSize(width: 150, height: 30)
        playerView.frame = CGRect(origin: origin , size: size)
    }
    
    func setUpballView() {
        let origin = CGPoint(x: xMax / 2 - ballView.ofsetedWidth(), y: yMax / 2 - ballView.bounds.height / 2)
        let size = CGSize(width: 30, height: 30)
        ballView.frame = CGRect(origin: origin, size: size)
    }
    
    func setUpSkynet() {
        let origin = CGPoint(x: xMax / 2 - skynetView.ofsetedWidth() , y: 0)
        let size = CGSize(width: 100, height: 30)
        skynetView.frame = CGRect(origin: origin, size: size)
    }
    
    func setUpLeftButton() {
        let origin = CGPoint(x: 0 , y: yMax / 2 + ballView.bounds.height )
        let size = CGSize(width: 50, height: 200)
        leftButton.frame = CGRect(origin: origin, size: size)
    }
    
    func setUpRightButton() {
        let origin = CGPoint(x: xMax - rightButton.bounds.width , y: yMax/2 + ballView.bounds.height )
        let size = CGSize(width: 60, height: 200)
        rightButton.frame = CGRect(origin: origin, size: size)
    }
}


extension ViewController {
    
    func centerBall() {
        ballView.frame.origin.x = xMax / 2 - ballView.ofsetedWidth()
        ballView.frame.origin.y = yMax / 2 - ballView.ofsetedHeight()
    }
}

// MARK TouchDelegate

extension ViewController {
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchCoordinateX = touches.first?.location(in: self.view).x else {
            return
        }
        
        setPlayerViewPosition(withPositionX: touchCoordinateX, withPositionY: nil)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchCoordinateX = touches.first?.location(in: self.view).x else {
            return
        }
        
        setPlayerViewPosition(withPositionX: touchCoordinateX, withPositionY: nil)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touchCoordinateX = touches.first?.location(in: self.view).x else {
            return
        }
        
        setPlayerViewPosition(withPositionX: touchCoordinateX, withPositionY: nil)
    }
}

// MARK: - Game States

fileprivate extension ViewController{
    
    func updateGame() {
        ballCollision()
        ballCollisionWithPlayer()
    }
    
    func gameIsEnded() -> Bool {
        return ballView.frame.origin.y + ballView.bounds.height >= yMax
    }
}

// MARK: - UIView Extension

extension UIView {
    
    func ofsetedHeight() -> CGFloat {
        return self.bounds.height / 2
    }
    
    func ofsetedWidth() -> CGFloat {
        return self.bounds.width / 2
    }
}
