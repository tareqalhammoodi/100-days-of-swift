//
//  ViewController.swift
//  Milestone-Projects 10-12
//
//  Created by Tareq Alhammoodi on 1.08.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    var elements = [Element]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Photos"
        tableView.delegate = self
        tableView.dataSource = self
        // right button
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        // load saved data
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "elementsData") as? Data {
            let jsonDecoder = JSONDecoder()
            do {
                elements = try jsonDecoder.decode([Element].self, from: savedData)
            } catch {
                print("Failed to load data.")
            }
        }
    }

    @objc func addTapped() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        dismiss(animated: true)
        let alert = UIAlertController(title: "Add caption", message: nil, preferredStyle: .alert)
        alert.addTextField()
        let addButton = UIAlertAction(title: "Add", style: .default) { [weak alert, weak self] _ in
            let caption = alert?.textFields?[0].text ?? "Unknown"
            self?.add(caption: caption, path: imageName)
        }
        alert.addAction(addButton)
        present(alert, animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func add(caption: String, path imagePath: String) {
        let element = Element(caption: caption, image: imagePath)
        elements.append(element)
        saveData()
        tableView.reloadData()
    }
    
    func saveData() {
        let jsonEncoder = JSONEncoder()
        if let savedData = try? jsonEncoder.encode(elements) {
            let defaults = UserDefaults.standard
            defaults.set(savedData, forKey: "elementsData")
        } else {
            print("Failed to save data.")
        }
    }

}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = elements[indexPath.row].caption
        cell.imageView?.image = UIImage(systemName: "photo")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let element = elements[indexPath.item]
        saveData()
        tableView.reloadData()
        if let vc = storyboard?.instantiateViewController(withIdentifier: "detail") as? DetailViewController {
            let path = getDocumentsDirectory().appendingPathComponent(element.image)
            vc.selectedImage = path
            vc.X = indexPath.row
            vc.Y = elements.count
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}

