//
//  ViewController.swift
//  Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import UIKit

class CountryViewController: UIViewController {

    @IBOutlet weak var countryTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    var countries = [Country]() {
        didSet {
            countriesFiltered = self.countries
            countryTableView.reloadData()
        }
    }
    
    var countriesFiltered = [Country]()
    
    var searchTerm = "" {
        didSet {
            if searchTerm.count > 0 {
                countriesFiltered = countries.filter{$0.name.lowercased().contains(searchTerm.lowercased())}
            } else {
                countriesFiltered = countries
            }
            countryTableView.reloadData()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.countryTableView.delegate = self
        self.countryTableView.dataSource = self
        self.searchBar.delegate = self
        loadData()
    }
    
    func loadData() {
        let url = "https://restcountries.eu/rest/v2/"
        let completion: ([Country]) -> Void = {(onlineCountry: [Country]) in
            self.countries = onlineCountry
        }
        CountryAPIClient.manager.getCountry(from: url, completionHandler: completion, errorHandler: {print($0)})
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let countryDet = countriesFiltered[countryTableView.indexPathForSelectedRow!.row]
        let detail = segue.destination as? CountryDetailViewController
        detail?.countryDetail = countryDet
    }
}



