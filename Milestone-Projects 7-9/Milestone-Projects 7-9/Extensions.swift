//
//  Extensions.swift
//  Milestone-Projects 7-9
//
//  Created by Tareq Alhammoodi on 25.07.2023.
//

import Foundation
import UIKit

// determine the coordinates of the elements
extension UIView {

    public var width: CGFloat {
        return frame.size.width
    }

    public var height: CGFloat {
        return frame.size.height
    }

    public var top: CGFloat {
        return frame.origin.y
    }

    public var bottom: CGFloat {
        return frame.size.height + frame.origin.y
    }

    public var left: CGFloat {
        return frame.origin.x
    }

    public var right: CGFloat {
        return frame.size.width + frame.origin.x
    }

}
