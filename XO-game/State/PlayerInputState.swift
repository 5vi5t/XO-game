//
//  PlayerInputState.swift
//  XO-game
//
//  Created by Константин on 23.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

public class PlayerInputState: GameState {
    
    // MARK: - Properties
    
    public private(set) var isCompleted = false
    
    public let player: Player
    public let markViewPrototype: MarkView
    private(set) weak var gameViewController: GameViewController?
    private(set) weak var gameboard: Gameboard?
    private(set) weak var gameboardView: GameboardView?
    
    // MARK: - Construction
    
    init(player: Player,
         markViewPrototype: MarkView,
         gameViewController: GameViewController,
         gameboard: Gameboard,
         gameboardView: GameboardView) {
        self.player = player
        self.markViewPrototype = markViewPrototype
        self.gameViewController = gameViewController
        self.gameboard = gameboard
        self.gameboardView = gameboardView
    }
    
    // MARK: - Functions
    
    public func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        case .player:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
            gameViewController?.firstPlayerTurnLabel.text = "Player"
        default:
            break
        }
        gameViewController?.winnerLabel.isHidden = true
    }
    
    public func addMark(at position: GameboardPosition) {
        Log(.playerInput(player: player, position: position))
        guard let gameboardView,
              gameboardView.canPlaceMarkView(at: position)
        else { return }
        
        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(markViewPrototype.copy(), at: position)
        isCompleted = true
    }
}
