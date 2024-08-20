//
//  Astronaut.swift
//  Moonshot
//
//  Created by Martí Espinosa Farran on 17/6/24.
//

import Foundation

struct Astronaut: Codable, Identifiable, Hashable {
    let id: String
    let name: String
    let description: String
}
