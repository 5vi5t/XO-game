//
//  LogCommand.swift
//  XO-game
//
//  Created by Константин on 26.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

// MARK: - Command

final class LogCommand {
    
    // MARK: - Properties
    
    let action: LogAction
    var logMessage: String {
        switch action {
        case .playerInput(let player, let position):
            return "\(player) placed mark at \(position)"
        case .gameFinished(let winner):
            if let winner {
                return "\(winner) win game"
            } else {
                return "game finished with no winner"
            }
        case .restartGame:
            return "game restarted"
        }
    }
    
    // MARK: - Construction
    
    init(action: LogAction) {
        self.action = action
    }
    
    
}
