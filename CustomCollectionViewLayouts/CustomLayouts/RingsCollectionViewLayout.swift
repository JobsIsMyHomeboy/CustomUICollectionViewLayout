//
//  RingsCollectionViewLayout.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

@objc(RingsCollectionViewLayout)
class RingsCollectionViewLayout: UICollectionViewLayout {
    var itemSize = CGSize(width: 325, height: 325)
    
    var verticalSpacingBetweenItems: CGFloat = -25
    var horizontalSpacingBetweenItems: CGFloat = 4
    var horizontalPadding: CGFloat = 40
    
    var layoutAttributes = [UICollectionViewLayoutAttributes]()
    
    private var numberOfItems = 0
    private var numberOfRows = 2
    private var numberOfColumns = 0
    
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepare() {
        guard let collectionView = collectionView else { return }
        
        verticalSpacingBetweenItems = -(itemSize.height / 2)
        horizontalSpacingBetweenItems = itemSize.height * 0.08
        
        numberOfItems = collectionView.numberOfItems(inSection: 0)
        numberOfColumns = Int(ceil(CGFloat(numberOfItems) / CGFloat(numberOfRows)))
        layoutAttributes.removeAll()
        
        for itemIndex in 0..<numberOfItems {
            let row = itemIndex % numberOfRows
            let column = itemIndex / numberOfRows
            
            var xPosition = column * Int(itemSize.width + horizontalSpacingBetweenItems)
            if row % 2 == 1 {
                xPosition += Int(itemSize.width / 2) + Int(horizontalSpacingBetweenItems / 2)
            }
            xPosition += Int(horizontalPadding)
            
            //get 2 column frame height
            let frameHeight = (itemSize.height * CGFloat(numberOfRows)) + ((CGFloat(numberOfRows) - 1) * verticalSpacingBetweenItems)
            //210
            let collectionViewHeight = collectionView.bounds.height - 40
            let yOffset = (collectionViewHeight - frameHeight) / 2
            //384
            let yPosition = (row * Int(itemSize.height + verticalSpacingBetweenItems)) + Int(yOffset)
            
            let index = IndexPath(row: itemIndex, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: index)
            attributes.frame = CGRect(x: CGFloat(xPosition), y: CGFloat(yPosition), width: itemSize.width, height: itemSize.height)
            
            layoutAttributes.append(attributes)
        }
    }
    
    override var collectionViewContentSize: CGSize {
        let width = (CGFloat(numberOfColumns) * itemSize.width) + (CGFloat(numberOfColumns - 1) * horizontalSpacingBetweenItems) + (horizontalPadding * 2) + (numberOfItems % 2 == 0 ? itemSize.width / 2 : 0)
        let height = (CGFloat(numberOfRows) * itemSize.height) + (CGFloat(numberOfRows - 1) * verticalSpacingBetweenItems)
        
        return CGSize(width: width, height: height)
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes.filter({ (attributes) -> Bool in
            attributes.frame.intersects(rect)
        })
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return layoutAttributes[indexPath.row]
    }
}
