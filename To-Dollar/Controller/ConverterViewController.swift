//
//  ViewController.swift
//  To-Dollar
//
//  Created by Mohaned Yossry on 3/29/20.
//  Copyright © 2020 Mohaned Yossry. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
    
    @IBOutlet weak var dollarTextField: UITextField!
    
    @IBOutlet weak var currencyTextField: UITextField!
    
    @IBOutlet weak var currencyLabel: UILabel!
    
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    let converterManager = ConverterManager()
    var selectedCurrency = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        dollarTextField.delegate = self
        currencyTextField.delegate = self
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        converterManager.delegate = self
        converterManager.initData()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))

           view.addGestureRecognizer(tap)
        
    }
    
    @IBAction func onTextChange(_ textField: UITextField) {
        if textField === dollarTextField && textField.text != "" {
            converterManager.convertMoney(fromDollar: true, fromValue:textField.text!, currencyCode: selectedCurrency)
        }else if textField !== dollarTextField && textField.text != ""{
            converterManager.convertMoney(fromDollar: false, fromValue: textField.text!, currencyCode: selectedCurrency)
                   }
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    func updateUI() {
        DispatchQueue.main.async {

            self.currencyLabel.text = self.selectedCurrency
            self.currencyTextField.placeholder = "Value in \(self.selectedCurrency)"
            
            self.currencyTextField.text = ""
            self.dollarTextField.text = ""
        }
    }
}

//MARK: - UITextFieldsDelegate
extension ConverterViewController:UITextFieldDelegate{
  

    
}

//MARK: - UIPickerViewDelegate
extension ConverterViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return converterManager.getCurrencyArray().count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         selectedCurrency =  converterManager.getCurrencyArray()[row]
        updateUI()
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return converterManager.getCurrencyArray()[row]
    }
    
}

//MARK: - ConverterManagerDelegate

extension ConverterViewController:ConverterManagerDelegate{
    func didReceiveResult(_ manager: ConverterManager, value: String,fromDollar:Bool ) {
        if fromDollar {
            currencyTextField.text = value
        }else{
            dollarTextField.text = value
        }
    }
    
    func didInitData(_ manager: ConverterManager, data: CurrencyData) {
           selectedCurrency =  converterManager.getCurrencyArray()[0]
        updateUI()
    }
    
    
    
    func didFailWithError(_ manager: ConverterManager, error: Error) {
        print(error)
    }
    
    
}
