//
//  ViewController.swift
//  Milestone-Projects 13-15
//
//  Created by Tareq Alhammoodi on 13.08.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var countries = [Country]()
    var filteredCountries = [Country]()
    var originalCountries = [Country]()
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for petitions..."
        return searchBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "FAC"
        // set search bar
        searchBar.delegate = self
        navigationController?.navigationBar.topItem?.titleView = searchBar
        // get countries
        let url = URL(string: "https://restcountries.com/v3.1/all")
        let URL = URLRequest(url: url!)
        URLSession.shared.dataTask(with: URL) { data, response, error in
            do {
                self.countries = try JSONDecoder().decode([Country].self, from: data!)
                self.countries = self.countries.sorted(by: { $0.name.common < $1.name.common })
                self.originalCountries = self.countries
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let country = countries[indexPath.row]
        cell.textLabel?.text = "\(country.flag) \(country.name.common)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.detailItem = countries[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!
        for currentIndex in countries.indices {
            if countries[currentIndex].name.common.lowercased().contains(text.lowercased()){
                filteredCountries.append(countries[currentIndex])
            }
        }
        countries.removeAll()
        countries = filteredCountries
        filteredCountries.removeAll()
        tableView.reloadData()
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        // remove focus from the search bar.
        searchBar.endEditing(true)
        countries.removeAll()
        filteredCountries.removeAll()
        countries = originalCountries
        tableView.reloadData()
    }
}
