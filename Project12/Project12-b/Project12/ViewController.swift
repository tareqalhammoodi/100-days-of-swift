//
//  ViewController.swift
//  Project12
//
//  Created by Tareq Alhammoodi on 27.07.2023.
//

import UIKit

class ViewController: UICollectionViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var elements = [Element]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNewElement))
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

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return elements.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CollectionViewCell else {
            fatalError("Unable to dequeue cell.")
        }
        let element = elements[indexPath.item]
        cell.label.text = element.name
        let path = getDocumentsDirectory().appendingPathComponent(element.image)
        cell.imageView.image = UIImage(contentsOfFile: path.path)
        cell.imageView.layer.borderColor = UIColor(white: 0, alpha: 0.3).cgColor
        cell.imageView.layer.borderWidth = 2
        cell.imageView.layer.cornerRadius = 3
        cell.layer.cornerRadius = 7
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = elements[indexPath.item]
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        // rename element
        let renameAction = UIAlertAction(title: "rename element", style: .default) { [weak self] _ in
            let alert = UIAlertController(title: "Rename element", message: nil, preferredStyle: .alert)
            alert.addTextField()
            alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] _ in
                guard let newName = alert?.textFields?[0].text else { return }
                element.name = newName
                self?.saveData()
                self?.collectionView.reloadData()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
        }
        renameAction.setValue(UIImage(systemName: "character.cursor.ibeam"), forKey: "image")
        actionSheet.addAction(renameAction)
        // delete element
        let deleteAction = UIAlertAction(title: "delete element", style: .default) { [weak self] _ in
            let alert = UIAlertController(title: "Delete element", message: "Are you sure you wanna delete this elemetn?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.elements.remove(at: indexPath.item)
                self?.collectionView.deleteItems(at: [indexPath])
                collectionView.reloadData()
            })
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self?.present(alert, animated: true)
        }
        deleteAction.setValue(UIImage(systemName: "trash"), forKey: "image")
        actionSheet.addAction(deleteAction)
        // cancel
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
    }
    
    @objc func addNewElement() {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        let element = Element(name: "Unknown", image: imageName)
        elements.append(element)
        saveData()
        collectionView?.reloadData()
        dismiss(animated: true)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
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

