//
//  CircleCollectionViewLayout.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

@objc(CircleCollectionViewLayout)
class CircleCollectionViewLayout: UICollectionViewLayout {
    public var itemSize: CGFloat = 120
    
    public var center: CGPoint = .zero
    public var radius: CGFloat = 0
    public var cellCount: Int = 0
    public var offset: CGFloat = 0 {
        didSet {
            invalidateLayout()
        }
    }
    
    override func prepare() {
        super.prepare()
        
        if let collectionView = collectionView {
            let size = collectionView.frame.size
            cellCount = collectionView.numberOfItems(inSection: 0)
            center = CGPoint(x: size.width / 2, y: size.height / 2)
            radius = CGFloat.minimum(size.width, size.height) / 2.5
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override var collectionViewContentSize: CGSize {
        return collectionView?.frame.size ?? CGSize(width: 0, height: 0)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var attributes = [UICollectionViewLayoutAttributes]()
        for index in 0..<cellCount {
            let indexPath = IndexPath(row: index, section: 0)
            if let layoutAttributes = layoutAttributesForItem(at: indexPath) {
                attributes.append(layoutAttributes)
            }
        }
        
        return attributes
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        attributes.size = CGSize(width: itemSize, height: itemSize)
        attributes.center = CGPoint(x: center.x + radius * cos((CGFloat(2 * indexPath.row) * CGFloat.pi + ((CGFloat.pi * 4) * offset)) / CGFloat(cellCount)), y: center.y + radius * sin((CGFloat(2 * indexPath.row) * CGFloat.pi + ((CGFloat.pi * 4) * offset)) / CGFloat(cellCount)))
        
        return attributes
    }
}
