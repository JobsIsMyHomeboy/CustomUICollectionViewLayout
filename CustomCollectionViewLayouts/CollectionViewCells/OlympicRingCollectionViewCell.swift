//
//  OlympicRingCollectionViewCell.swift
//  OlympicCollectionViewLayouts
//
//  Created by Brian Miller on 2/27/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

class OlympicRingCollectionViewCell: UICollectionViewCell {

    static let nibName = String(describing: OlympicRingCollectionViewCell.self)
    static let reuseIdentifier = String(describing: OlympicRingCollectionViewCell.self)
    
    @IBOutlet var titleLabel: UILabel!
    
    public func setMainColor(_ color: UIColor) {
        let updatedColor = color.withAlphaComponent(0.8)
        layer.borderColor = updatedColor.cgColor
        titleLabel.textColor = updatedColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.borderWidth = (bounds.height / 100) * 8
        layer.cornerRadius = bounds.height / 2
    }
}
