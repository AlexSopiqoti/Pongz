//
//  MenuViewController.swift
//  Pongz
//
//  Created by Aleksander Sopiqoti on 25/08/2018.
//  Copyright © 2018 Aleksander Sopiqoti. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBAction func startPlayButton(_ sender: UIButton) {
        let gameViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}


