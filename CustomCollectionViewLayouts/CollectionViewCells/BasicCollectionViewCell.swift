//
//  BasicCollectionViewCell.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

class BasicCollectionViewCell: UICollectionViewCell {

    static let nibName = String(describing: BasicCollectionViewCell.self)
    static let reuseIdentifier = String(describing: BasicCollectionViewCell.self)
    
    @IBOutlet var titleLabel: UILabel!
    
    public func setMainColor(_ color: UIColor) {
        backgroundColor = color
        
        let updatedColor = backgroundColor?.withAlphaComponent(1)
        layer.borderColor = updatedColor?.cgColor
        titleLabel.textColor = updatedColor
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()

        layer.borderWidth = 2
    }
}
