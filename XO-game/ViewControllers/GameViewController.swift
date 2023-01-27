//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Outlets

    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    // MARK: - Properties
    
    var gameType: GameType = .pvp
    private let gameboard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    private lazy var referee = Referee(gameboard: gameboard)
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goToFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self else { return }
            if self.currentState is PlayerInputState {
                self.currentState.addMark(at: position)
                if self.currentState.isCompleted {
                    self.goToNextState()
                }
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        Log(.restartGame)
    }
    
    // MARK: - Functions
    
    public func next() {
        if currentState is ComputerState {
            goToNextState()
        }
    }
    
    private func goToFirstState() {
        let player: Player
        switch gameType {
        case .pvp:
            player = Player.first
        case .pve:
            player = Player.player
        }
        currentState = PlayerInputState(player: player,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
    }
    
    private func goToNextState() {
        if let winner = referee.determineWinner() {
            currentState = GameEndedState(winner: winner, gameViewController: self)
            return
        }
        
        if let playerInputState = currentState as? PlayerInputState {
            let player = playerInputState.player.next
            switch gameType {
            case .pvp:
                currentState = PlayerInputState(player: player,
                                                markViewPrototype: player.markViewPrototype,
                                                gameViewController: self,
                                                gameboard: gameboard,
                                                gameboardView: gameboardView)
            case .pve:
                currentState = ComputerState(player: player,
                                             markViewPrototype: player.markViewPrototype,
                                             gameViewController: self,
                                             gameboard: gameboard,
                                             gameboardView: gameboardView)
            }
            return
        }
        
        if let computerState = currentState as? ComputerState {
            let player = computerState.player.next
            currentState = PlayerInputState(player: player,
                                            markViewPrototype: player.markViewPrototype,
                                            gameViewController: self,
                                            gameboard: gameboard,
                                            gameboardView: gameboardView)
        }
    }
}

