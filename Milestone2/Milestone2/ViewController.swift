//
//  ViewController.swift
//  Milestone2
//
//  Created by Tareq Alhammoodi on 18.07.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var shoppingList = [String]()
    var addButton = UIBarButtonItem(); var shareButton = UIBarButtonItem();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        navigationItem.rightBarButtonItems = [addButton, shareButton]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearTapped))
        
        if shoppingList.isEmpty {
            shareButton.isEnabled = false
        } else {
            shareButton.isEnabled = true
        }
    }
    
    @objc func addTapped() {
        let alertController = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        alertController.addTextField()
        let submitAction = UIAlertAction(title: "Submit", style: .default) { [weak self, weak alertController] _ in
            guard let answer = alertController?.textFields?[0].text else { return }
            self?.shoppingList.insert(answer, at: 0)
            let indexPath = IndexPath(row: 0, section: 0)
            self?.tableView.insertRows(at: [indexPath], with: .automatic)
            self?.shareButton.isEnabled = true
        }
        alertController.addAction(submitAction)
        present(alertController, animated: true)
    }
    
    @objc func shareTapped() {
        let list = shoppingList.joined(separator: "\n")
        let vc = UIActivityViewController(activityItems: [list], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
    @objc func clearTapped() {
        shoppingList.removeAll()
        tableView.reloadData()
    }
}

extension ViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = shoppingList[indexPath.row]
        return cell
    }
}

