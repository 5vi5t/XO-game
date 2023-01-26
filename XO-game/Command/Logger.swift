//
//  Logger.swift
//  XO-game
//
//  Created by Константин on 26.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

// MARK: - Receiver

final class Logger {
    func writeMessageToLog(_ message: String) {
        /// Здесь должна быть реализация записи сообщения в лог.
        /// Для простоты примера паттерна не вдаемся в эту реализацию,
        /// а просто печатаем текст в консоль.
        print(message)
    }
}
