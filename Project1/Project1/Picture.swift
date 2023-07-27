//
//  Picture.swift
//  Project1
//
//  Created by Tareq Alhammoodi on 27.07.2023.
//

import UIKit

class Picture: NSObject, Codable {

    var name: String
    var views: Int
    
    init(name: String, views: Int) {
        self.name = name
        self.views = views
    }
    
}
