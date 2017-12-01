//
//  Country.swift
//  Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let region: String
    let subregion: String
    let population: Int
    let currencies: [Currencies]
    let flag: String
    let alpha2Code: String
}

struct Currencies: Codable {
    let code: String?
    let name: String?
    let symbol: String?
}

