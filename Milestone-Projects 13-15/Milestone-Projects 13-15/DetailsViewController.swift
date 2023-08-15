//
//  DetailsViewController.swift
//  Milestone-Projects 13-15
//
//  Created by Tareq Alhammoodi on 14.08.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var detailItem: Country?
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Nam liber te conscient to factor tum poen legum odioque civiuda."
        textView.font = UIFont(name:"Avenir-Light", size: 18.0)
        return textView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        textView.text = """
Country name: \(detailItem!.name.common) - (\(detailItem!.name.official))
Region: \(detailItem!.region)
Capital City: \(detailItem?.capital ?? ["UNKNOWN"])
Languages: \(detailItem!.languages ?? ["UNKNOWN": "UNKNOWN"])
Population: \(detailItem!.population)
Borders: \(detailItem!.borders ?? ["UNKNOWN"])
Flag: \(detailItem!.flag)
Timezone: \(detailItem!.timezones)
First day of the week: \(detailItem!.startOfWeek)
"""
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = view.bounds
    }

}
