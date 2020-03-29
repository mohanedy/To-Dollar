//
//  ConverterManager.swift
//  To-Dollar
//
//  Created by Mohaned Yossry on 3/29/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import Foundation

class ConverterManager {
    let url = "https://api.exchangerate-api.com/v5/latest"
    var currencyData:CurrencyData?
    var delegate : ConverterManagerDelegate?
    
    func initData(){
        let urlStr = url
        performRequest(with: urlStr)
    }
    func performRequest(with urlStr:String){
        //1.Create Url
        if let url = URL(string: urlStr){
            //2.Create URLSession
            let session = URLSession(configuration: .default)
            //3.Give the session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(self,error: error!)
                    return
                }
                if let safeData = data{
                    if let safeCurrencyData = self.parseJson(data: safeData){
                        self.currencyData = safeCurrencyData
                        self.delegate?.didInitData(self,  data: safeCurrencyData)
                    }
                }
            }
            //4.Start the task
            task.resume()
            
        }
    }
    func parseJson(data: Data) -> CurrencyData?{
        let decoder = JSONDecoder()
        do {
            let decodedData =  try  decoder.decode(CurrencyData.self, from: data)
            return decodedData
        } catch  {
            delegate?.didFailWithError(self,error: error)
            return nil
        }
        
    }
    
    func getCurrencyArray()->[String]{
        if let safeData = currencyData{
            return Array(safeData.rates.keys)
        }else{
            return []
        }
    }
    
    func convertMoney( fromDollar:Bool, fromValue: String ,currencyCode:String){
        
        if let safeData = currencyData{
            var result = 0.0
            
            if fromDollar{
                
                let rate = safeData.rates[currencyCode]
                 result = Double(fromValue)! * rate!
                
            }else{
                let rate = safeData.rates[currencyCode]
                 result = Double(fromValue)! / rate!
            }
            delegate?.didReceiveResult(self, value:String(format: "%.2f", result),fromDollar:fromDollar )
            
        }
        
    }
}
