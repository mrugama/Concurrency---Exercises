//
//  CountryViewController+Extension.swift
//  Concurrency - Exercises
//
//  Created by C4Q on 11/30/17.
//  Copyright © 2017 C4Q. All rights reserved.
//

import Foundation
import UIKit

extension CountryViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesFiltered.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countriesFiltered[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Country Cell", for: indexPath) as? CountryTableViewCell {
            //Image
            cell.spiner.isHidden = false
            cell.spiner.startAnimating()
            let urlStr = "http://www.geognos.com/api/en/countries/flag/\(country.alpha2Code).png"
            DispatchQueue.global().async {
                if let url = URL(string: urlStr) {
                    let completion: (Data) -> Void = {(data: Data) in
                        guard let onlineImage = UIImage(data: data) else {
                            return
                        }
                        cell.flagImageView.image = onlineImage
                        cell.setNeedsLayout()
                        cell.spiner.stopAnimating()
                        cell.spiner.isHidden = true
                    }
                    NetworkHelper.manager.performDataTask(with: url, completionHandler: completion, errorHandler: {print($0)})
                }
            }
            cell.countryNameLabel.text = (country.name.capitalized)
            cell.countryCapitalLabel.text = "Capital: \n \(country.capital.capitalized)"
            cell.countryPopulationLabel.text = "Population: \n \(country.population)"
            return cell
        }
        return UITableViewCell()
    }
    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard let searchWord = searchBar.text else {return}
//        self.searchTerm = searchWord
//    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if let searchWord = searchBar.text {
            self.searchTerm = searchWord
        }
//        self.searchTerm = text
        return true
    }
    
}
