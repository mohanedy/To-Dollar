//
//  CurrencyData.swift
//  To-Dollar
//
//  Created by Mohaned Yossry on 3/29/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//
import Foundation

struct CurrencyData: Codable {
    
    let base: String
    let rates: [String: Double]
    
}
