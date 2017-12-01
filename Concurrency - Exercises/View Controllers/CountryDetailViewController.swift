//
//  CountryDetailViewController.swift
//  Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class CountryDetailViewController: UIViewController {

    @IBOutlet weak var flagImageView: UIImageView!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var capitalNameLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    
    var countryDetail: Country! {
        didSet {
            loadCurrencyData()
        }
    }
    var currency: Double! {
        didSet {
            loadLabels()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadLabels()
    }
    
    func loadCurrencyData() {
        let url = "https://api.fixer.io/latest?base=USD"
        let completion: (Currency) -> Void = {(onlineCurrency: Currency) in
            if let codeCurrency = self.countryDetail.currencies.first!.code {
                print(codeCurrency)
                print(onlineCurrency.rates[codeCurrency]!)
                if let currencyDouble = onlineCurrency.rates[codeCurrency] {
                    self.currency = Double(currencyDouble)
                }
            }
            
        }
        CurrencyAPIClient.manager.getCurrency(from: url, completionHandler: completion, errorHandler: {print($0)})
    }
    
    func loadLabels() {
        self.countryNameLabel.text = "Country: \(countryDetail.name)"
        self.currencyLabel.text = "Equivalent: U$1 = \(countryDetail.currencies.first!.symbol!)\(self.currency!)"
        //Image
        let urlStr = "http://www.geognos.com/api/en/countries/flag/\(countryDetail.alpha2Code).png"
        if let url = URL(string: urlStr) {
            let completion: (Data) -> Void = {(data: Data) in
                guard let onlineImage = UIImage(data: data) else {
                    return
                }
                self.flagImageView.image = onlineImage
                self.flagImageView.setNeedsLayout()
            }
            NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: {print($0)})
        }
    }

}
