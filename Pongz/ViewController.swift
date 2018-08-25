//
//  ViewController.swift
//  Pongz
//
//  Created by Aleksander Sopiqoti on 24/08/2018.
//  Copyright © 2018 Aleksander Sopiqoti. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties

    var xMax: CGFloat = 0
    var yMax:CGFloat = 0

    //MARK: - Settings
   
    private let playerSpeed: CGFloat = 20

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
    }
    
    func setUpPlayerView() {
        let origin = CGPoint(x: xMax / 2 - playerView.bounds.width / 2, y: yMax - playerView.bounds.height)
        let size = CGSize(width: 100, height: 30)
        playerView.frame = CGRect(origin: origin , size: size)
    }
    
    func setUpballView() {
        let origin = CGPoint(x: xMax / 2 - ballView.bounds.width / 2, y: yMax / 2 - ballView.bounds.height / 2)
        let size = CGSize(width: 60, height: 60)
        ballView.frame = CGRect(origin: origin, size: size)
    }
    
    func setUpSkynet() {
        let origin = CGPoint(x: xMax / 2 - skynetView.bounds.width / 2 , y: 0)
        let size = CGSize(width: 100, height: 30)
        skynetView.frame = CGRect(origin: origin, size: size)
    }
    
    func setUpLeftButton() {
        let origin = CGPoint(x: 0 , y: yMax / 2 + ballView.bounds.height )
        let size = CGSize(width: 50, height: 50)
        leftButton.frame = CGRect(origin: origin, size: size)
    }
    
    func setUpRightButton() {
        let origin = CGPoint(x: xMax - rightButton.bounds.width , y: yMax/2 + ballView.bounds.height )
        let size = CGSize(width: 60, height: 60)
        rightButton.frame = CGRect(origin: origin, size: size)
    }
}
