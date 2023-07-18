//
//  DetailViewController.swift
//  Milestone1
//
//  Created by Tareq Alhammoodi on 9.07.2023.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    var selectedImage: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "\(selectedImage?.replacingOccurrences(of: "@2x.png", with: "").uppercased() ?? "Unknown")"
        imageView.backgroundColor = .systemGroupedBackground
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad.replacingOccurrences(of: "@2x", with: "@3x"))
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
    }
    
    @objc func shareTapped() {
        guard let image = imageView.image?.jpegData(compressionQuality: 1) else {
            print("No image found")
            return
        }
        let vc = UIActivityViewController(activityItems: [image], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }

}
