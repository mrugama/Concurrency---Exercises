//
//  Currency.swift
//  Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation

struct Currency: Codable {
    let base: String
    let date: String
    let rates: [String:Double]
}
/*
struct Rate: Codable {
    let AUD: Double
    let BGN: Double
    let BRL: Double
    let CAD: Double
    let CHF: Double
    let CNY: Double
    let CZK: Double
    let DKK: Double
    let GBP: Double
    let HKD: Double
    let HRK: Double
    let HUF: Double
    let IDR: Double
    let ILS: Double
    let INR: Double
    let JPY: Double
    let KRW: Double
    let MXN: Double
    let MYR: Double
    let NOK: Double
    let NZD: Double
    let PHP: Double
    let PLN: Double
    let RON: Double
    let RUB: Double
    let SEK: Double
    let SGD: Double
    let THB: Double
    let TRY: Double
    let ZAR: Double
    let EUR: Double
}
*/

