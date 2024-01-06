//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController{
    
   var coinManager = CoinManager()

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currenncyPicker: UIPickerView!
    @IBOutlet weak var currencyLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currenncyPicker.dataSource = self
        currenncyPicker.delegate = self
        coinManager.delegate = self
    }
    
}
// MARK: - pickerViewMark
extension ViewController: UIPickerViewDataSource,UIPickerViewDelegate  {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currensy = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: currensy)
    }
    
}
// MARK: - updateMark
extension ViewController: CurrrensyManagerDelegate {
    func didUpdateCurrrensy(currrensy: String, cost: Double) {
        DispatchQueue.main.async {//you need this thing to call this in his order
            self.bitcoinLabel.text =  String(format :"%.1f",cost)
            self.currencyLabel.text = currrensy
        }
    }
    
    
}
    

