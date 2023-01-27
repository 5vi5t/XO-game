//
//  ComputerState.swift
//  XO-game
//
//  Created by Константин on 26.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

public class ComputerState: GameState {
    
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
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = false
        gameViewController?.secondPlayerTurnLabel.text = "Computer"
        gameViewController?.winnerLabel.isHidden = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            if let position = self.calculatePosition() {
                self.addMark(at: position)
            }
        }
    }
    
    public func addMark(at position: GameboardPosition) {
        Log(.playerInput(player: player, position: position))
        guard let gameboardView,
              gameboardView.canPlaceMarkView(at: position)
        else { return }
        
        gameboard?.setPlayer(player, at: position)
        gameboardView.placeMarkView(markViewPrototype.copy(), at: position)
        isCompleted = true
        gameViewController?.next()
    }
    
    private func calculateRandomPosition() -> GameboardPosition? {
        var positions: [GameboardPosition] = []

        for column in 0 ..< GameboardSize.columns {
            for row in 0 ..< GameboardSize.rows {
                let position = GameboardPosition(column: column, row: row)
                if let gameboardView,
                   gameboardView.canPlaceMarkView(at: position) {
                    positions.append(position)
                }
            }
        }

        return positions.randomElement()
    }
    
    private func calculatePosition() -> GameboardPosition? {
        // check for winning move
        for column in 0 ..< GameboardSize.columns {
            for row in 0 ..< GameboardSize.rows {
                let position = GameboardPosition(column: column, row: row)
                if let gameboardView,
                   let gameboard,
                   gameboardView.canPlaceMarkView(at: position) {
                    let newGameboard = gameboard.copy()
                    newGameboard.setPlayer(.computer, at: position)
                    let referee = Referee(gameboard: newGameboard)
                    if referee.determineWinner() == .computer {
                        return position
                    }
                }
            }
        }
        
        // check for blocking move
        for column in 0 ..< GameboardSize.columns {
            for row in 0 ..< GameboardSize.rows {
                let position = GameboardPosition(column: column, row: row)
                if let gameboardView,
                   let gameboard,
                   gameboardView.canPlaceMarkView(at: position) {
                    let newGameboard = gameboard.copy()
                    newGameboard.setPlayer(.player, at: position)
                    let referee = Referee(gameboard: newGameboard)
                    if referee.determineWinner() == .player {
                        return position
                    }
                }
            }
        }
        return calculateRandomPosition()
    }
}
