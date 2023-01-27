//
//  MainViewController.swift
//  XO-game
//
//  Created by Константин on 26.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gameVC = segue.destination as? GameViewController
        switch segue.identifier {
        case "seguePvE":
            gameVC?.gameType = .pve
        case "seguePvP":
            gameVC?.gameType = .pvp
        default:
            break
        }
    }
}
