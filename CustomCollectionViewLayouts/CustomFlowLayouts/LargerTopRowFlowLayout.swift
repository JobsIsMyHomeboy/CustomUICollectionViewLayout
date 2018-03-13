//
//  LargerTopRowFlowLayout.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

@objc(LargerTopRowFlowLayout)
class LargerTopRowFlowLayout: UICollectionViewFlowLayout {
    let zoomFactor: CGFloat = 1
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect)?.map({ $0.copy() as! UICollectionViewLayoutAttributes }),
            let collectionView = collectionView else {
            return nil
        }

        let visibleRect = CGRect(origin: collectionView.contentOffset, size: collectionView.bounds.size)
        let verticalThreshold = visibleRect.minY + minimumLineSpacing + (itemSize.height * 2)
        let activeDistance = itemSize.height * 2

        for attribute in attributes {
            if attribute.frame.intersects(rect) {
                let distance = verticalThreshold - attribute.center.y
                let normalizedDistance = distance / activeDistance
                if abs(distance) < activeDistance {
                    let zoom = 1 + zoomFactor * (1 - abs(normalizedDistance))
                    attribute.transform3D = CATransform3DMakeScale(zoom, zoom, 1)
                    attribute.zIndex = Int(zoom.rounded())
                }
            }
        }

        return attributes
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else {
            return CGPoint.zero
        }

        var offsetAdjustment = CGFloat.greatestFiniteMagnitude
        let verticalThreshold = proposedContentOffset.y + minimumLineSpacing + (itemSize.height * 2)

        let targetRect = CGRect(x: 0, y: proposedContentOffset.y, width: collectionView.bounds.width, height: collectionView.bounds.height)
        guard let attributes = super.layoutAttributesForElements(in: targetRect) else {
            return CGPoint.zero
        }

        for attribute in attributes {
            let itemVerticalCenter = attribute.center.y
            if abs(itemVerticalCenter - verticalThreshold) < offsetAdjustment {
                offsetAdjustment = itemVerticalCenter - verticalThreshold
            }
        }

        return CGPoint(x: proposedContentOffset.x, y: proposedContentOffset.y + offsetAdjustment)
    }
}
