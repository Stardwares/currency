//
//  ConverterController.swift
//  CoursesVal
//
//  Created by Вадим Пустовойтов on 13.09.2018.
//  Copyright © 2018 Вадим Пустовойтов. All rights reserved.
//

import UIKit

class ConverterController: UIViewController {

    @IBOutlet weak var labelCoursesForDate: UILabel!
    
    @IBOutlet weak var buttonValOne: UIButton!
    @IBOutlet weak var buttonValTwo: UIButton!
    
    @IBOutlet weak var textValueValOne: UITextField!
    @IBOutlet weak var textValueValTwo: UITextField!
    
    @IBAction func pushActionValOne(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .oneCurrency
        present(nc, animated: true, completion: nil)
    }
    
    @IBAction func pushActionValTwo(_ sender: Any) {
        let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
        (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .twoCurrency
        present(nc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    
    @IBAction func pushButtonAction(_ sender: Any) {
        textValueValOne.resignFirstResponder()
        navigationItem.rightBarButtonItem = nil
    }
    
    @IBAction func textValTwoEditingChange(_ sender: Any) {
        let amount = Double(textValueValTwo.text!)
        textValueValOne.text = Model.shared.convert(amount: amount, flagFrom: false)
    }
    
    
    @IBAction func textValOneEditingChange(_ sender: Any) {
        let amount = Double(textValueValOne.text!)
          textValueValTwo.text = Model.shared.convert(amount: amount, flagFrom: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textValueValOne.delegate = self
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadingXML"), object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
                activityIndicator.startAnimating()
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator
            }
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) { (notification) in
            DispatchQueue.main.async {
              self.navigationItem.title = Model.shared.currentDate
            }
        }
        
        navigationItem.title = Model.shared.currentDate
        
        Model.shared.loadXMLFile()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refreshButtons()
        textValOneEditingChange(self)
        labelCoursesForDate.text = "Курсы за дату: \(Model.shared.currentDate)"
        navigationItem.rightBarButtonItem = nil
    }


    func refreshButtons(){
        buttonValOne.setTitle(Model.shared.oneCurrency.CharCode, for: UIControlState.normal)
        buttonValTwo.setTitle(Model.shared.twoCurrency.CharCode, for: UIControlState.normal)
    }


}

extension ConverterController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        navigationItem.rightBarButtonItem = buttonDone
        
        return true
    }
}
