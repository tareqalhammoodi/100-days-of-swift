//
//  DetailViewController.swift
//  Milestone-Projects 10-12
//
//  Created by Tareq Alhammoodi on 1.08.2023.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var selectedImage: URL?
    var X: Int?; var Y: Int?;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Picture \(X! + 1) of \(Y!)"
        navigationItem.largeTitleDisplayMode = .never
        
        if let imageToLoad = selectedImage {
            imageView.image = UIImage(named: imageToLoad.path)
        }
    }
    
}
