//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol  CurrrensyManagerDelegate {
    func didUpdateCurrrensy( currrensy:String,cost :Double)
}
struct CoinManager {
    var delegate  : CurrrensyManagerDelegate?
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "A0E1127F-C960-40CA-9D18-2137A1DC531C"
    let currencyArray = ["AUD","USD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","ZAR"]
    
    func getCoinPrice (for currency: String ){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
       
        if let url = URL(string: urlString){
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                if let safeData = data {
                    if let bitcoinPrice = parseJSON(data: safeData){
                        self.delegate?.didUpdateCurrrensy(currrensy: currency, cost: bitcoinPrice)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(data : Data)-> Double?{
        let decoder = JSONDecoder()
        do{
            let decodeData = try decoder.decode(CoinData.self, from: data)
        
            let lastPrice = decodeData.rate
            return lastPrice
        }
        catch{
           
            return nil
           
        }
    }
}
