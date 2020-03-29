//
//  ConverterManagerDelegate.swift
//  To-Dollar
//
//  Created by Mohaned Yossry on 3/29/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation
protocol ConverterManagerDelegate {
    func didInitData(_ manager:ConverterManager, data:CurrencyData)
    func didReceiveResult(_ manager:ConverterManager, value:String,fromDollar:Bool)
    func didFailWithError(_ manager:ConverterManager, error:Error)
}
