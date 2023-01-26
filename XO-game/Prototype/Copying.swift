//
//  Copying.swift
//  XO-game
//
//  Created by Константин on 25.01.2023.
//  Copyright © 2023 plasmon. All rights reserved.
//

import Foundation

protocol Copying {
    init(_ prototype: Self)
}

extension Copying {
    func copy() -> Self {
        return type(of: self).init(self)
    }
}
