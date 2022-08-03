//
//  Logger.swift
//  pokemonCardApp
//
//  Created by 鈴木綜太 on 2022/07/10.
//

import Foundation
import os

extension OSLog {
    static let normal = Logger(subsystem: "com.eses.pokemonCardApp", category: "ui")
}
