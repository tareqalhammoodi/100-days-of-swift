//
//  TableViewController.swift
//  Project4
//
//  Created by Tareq Alhammoodi on 9.07.2023.
//

import UIKit

class TableViewController: UITableViewController {
    
    var websites = ["apple.com", "googlecom", "github.com"]

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "URLs"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}


extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "browser") as? ViewController {
            vc.selectedURL = websites[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
