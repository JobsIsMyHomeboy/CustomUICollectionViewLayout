//
//  LayoutType.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import Foundation

enum LayoutType: String, CustomStringConvertible {
    case flow = "UICollectionViewFlowLayout"
    case flowLargeTop = "LargerTopRowFlowLayout"
    case customOlympicRings = "RingsCollectionViewLayout"
    case customCircle = "CircleCollectionViewLayout"
    
    var description: String {
        switch self {
        case .flow:
            return "Normal Flow Layout"
        case .flowLargeTop:
            return "Flow Layout with Larger Top Row"
        case .customOlympicRings:
            return "Custom Olympic Ring Layout"
        case .customCircle:
            return "Custom Circle Layout"
        }
    }
}
