//
//  GameState.swift
//  XO-game
//
//  Created by Константин on 23.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

public protocol GameState {
    var isCompleted: Bool { get }
    
    func begin()
    func addMark(at position: GameboardPosition)
}
