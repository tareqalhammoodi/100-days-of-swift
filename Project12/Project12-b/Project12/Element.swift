//
//  Element.swift
//  Project12
//
//  Created by Tareq Alhammoodi on 27.07.2023.
//

import UIKit

class Element: NSObject, Codable {
    
    var name: String
    var image: String
    
    init(name: String, image: String) {
        self.name = name
        self.image = image
    }

}
