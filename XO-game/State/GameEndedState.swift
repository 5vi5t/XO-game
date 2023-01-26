//
//  GameEndedState.swift
//  XO-game
//
//  Created by Константин on 23.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

public class GameEndedState: GameState {
    
    // MARK: - Properties
    
    public let isCompleted = false
    
    public let winner: Player?
    private(set) weak var gameViewController: GameViewController?
    
    // MARK: - Construction
    
    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }
    
    // MARK: - Functions
    
    public func begin() {
        Log(.gameFinished(winner: winner))
        gameViewController?.winnerLabel.isHidden = false
        if let winner {
            gameViewController?.winnerLabel.text = winnerName(from: winner) + " win"
        }
    }
    
    public func addMark(at position: GameboardPosition) { }
    
    private func winnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1st player"
        case .second:
            return "2nd player"
        }
    }
    
}
