//
//  PokemonData.swift
//  Pursuit-Core-iOS-Images-Lab
//
//  Created by Lilia Yudina on 12/11/19.
//  Copyright © 2019 Lilia Yudina. All rights reserved.
//

import Foundation

struct Cards: Decodable {
    let cards: [Pokemon]
}

struct Pokemon: Decodable {
    let name: String
    let supertype: String
    let set: String
    let imageUrl: String
    let imageUrlHiRes: String
    let weaknesses: [Weakness]?
}
struct Weakness: Decodable {
    let type: String
}
