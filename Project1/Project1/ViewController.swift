//
//  ViewController.swift
//  Project1
//
//  Created by Tareq Alhammoodi on 1.07.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var pictures = [Picture]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Storm Viewer"
        navigationController?.navigationBar.prefersLargeTitles = true
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "data") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                pictures = try jsonDecoder.decode([Picture].self, from: savedData)
            } catch {
                print("Failed to load data.")
            }
        } else {
            performSelector(inBackground: #selector(loadData), with: nil)
        }
        pictures = pictures.sorted(by: { $0.name < $1.name })
    }
    
    @objc func loadData() {
        let views = 0
        let fileManager = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fileManager.contentsOfDirectory(atPath: path)
        for item in items {
            if item.hasPrefix("nssl") {
                pictures.append(Picture(name: item, views: views))
            }
        }
        saveData()
        DispatchQueue.main.async { [weak self] in
            self?.tableView.performSelector(onMainThread: #selector(UITableView.reloadData), with: nil, waitUntilDone: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Picture", for: indexPath)
        cell.textLabel?.text = pictures[indexPath.row].name
        cell.detailTextLabel?.text = "Views: \(pictures[indexPath.row].views)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pictures[indexPath.row].views += 1
        saveData()
        tableView.reloadData()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailViewController {
            vc.selectedImage = pictures[indexPath.row].name
            vc.X = indexPath.row
            vc.Y = pictures.count
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func saveData() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(pictures) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "data")
        } else {
            print("Failed to save data.")
        }
    }
    
}

