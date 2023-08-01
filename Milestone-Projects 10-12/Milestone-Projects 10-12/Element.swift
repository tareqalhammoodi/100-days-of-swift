//
//  Element.swift
//  Milestone-Projects 10-12
//
//  Created by Tareq Alhammoodi on 1.08.2023.
//

import UIKit

class Element: NSObject, Codable {

    var caption: String
    var image: String
    
    init(caption: String, image: String) {
        self.caption = caption
        self.image = image
    }
    
}
