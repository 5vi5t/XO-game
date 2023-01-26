//
//  LoggerInvoker.swift
//  XO-game
//
//  Created by Константин on 26.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

// MARK: - Invoker

internal final class LoggerInvoker {
    
    // MARK: - Singleton
    
    internal static let shared = LoggerInvoker()
    
    // MARK: - Private properties
    
    private let logger = Logger()
    private let batchSize = 10
    private var commands: [LogCommand] = []
    
    // MARK: - Construction
    
    private init() { }
    
    // MARK: - Internal
    
    internal func addLogCommand(_ command: LogCommand) {
        commands.append(command)
        executeCommandIfNeeded()
    }
    
    // MARK: - Private
    
    private func executeCommandIfNeeded() {
        guard commands.count >= batchSize else {
            return
        }
        commands.forEach { logger.writeMessageToLog($0.logMessage) }
        commands = []
    }
}
