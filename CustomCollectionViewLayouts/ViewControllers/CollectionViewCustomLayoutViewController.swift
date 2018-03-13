//
//  CollectionViewFlowLayoutViewController.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

class CollectionViewCustomLayoutViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            
            collectionView.register(UINib(nibName: BasicCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: BasicCollectionViewCell.reuseIdentifier)
            collectionView.register(UINib(nibName: OlympicRingCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: OlympicRingCollectionViewCell.reuseIdentifier)
        }
    }
    
    //Used for panning Circle Layout
    var currentOffset: CGFloat = 0
    
    private var layoutType: LayoutType!
    private var numberOfItems: Int = 100
    fileprivate var panGesture: UIPanGestureRecognizer?
    
    public func configureWithCustomFlowLayout(_ layoutType: LayoutType) {
        self.layoutType = layoutType
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = layoutType.description
        
        updateNumberOfItems()
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        if let flowLayoutInstance = NSClassFromString(layoutType.rawValue) as? UICollectionViewLayout.Type {
            collectionView.setCollectionViewLayout(flowLayoutInstance.init(), animated: true)
        }
        
        if layoutType == .customCircle {
            if panGesture == nil {
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panning(_:)))
                collectionView.addGestureRecognizer(panGesture)
                self.panGesture = panGesture
            }
            
            if let gestureRecognizers = collectionView.gestureRecognizers {
                for gesture in gestureRecognizers {
                    gesture.isEnabled = gesture == panGesture
                }
            }
        } else if let panGesture = panGesture {
            if let gestureRecognizers = collectionView.gestureRecognizers {
                for gesture in gestureRecognizers {
                    gesture.isEnabled = gesture != panGesture
                }
            }
        }
    }
    
    fileprivate func updateNumberOfItems() {
        switch layoutType {
        case .customCircle:
            numberOfItems = 12
        default:
            numberOfItems = 200
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        
        switch segueIdentifier {
        case "ShowLayoutTypePopover":
            if let destinationViewController = segue.destination as? LayoutPopoverTableViewController {
                destinationViewController.configureWithDelegate(self)
            }
        default:
            break
        }
    }
}

extension CollectionViewCustomLayoutViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch layoutType {
        case .customOlympicRings:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OlympicRingCollectionViewCell.reuseIdentifier, for: indexPath) as! OlympicRingCollectionViewCell
            
            
            cell.setMainColor(colorForIndexPath(indexPath))
            cell.titleLabel.text = "\(indexPath.row + 1)"
            
            return cell
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BasicCollectionViewCell.reuseIdentifier, for: indexPath) as! BasicCollectionViewCell
            
            cell.setMainColor(colorForIndexPath(indexPath))
            cell.layer.cornerRadius = layoutType == .customCircle ? 60 : 0
            cell.titleLabel.text = "\(indexPath.row + 1)"
            
            return cell
        }
    }
}

extension CollectionViewCustomLayoutViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch layoutType {
        case .flowLargeTop:
            return UIEdgeInsetsMake(60, 60, 60, 60)
        default:
            return UIEdgeInsetsMake(10, 10, 10, 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch layoutType {
        case .flowLargeTop:
            return 60
        default:
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        switch layoutType {
        case .flowLargeTop:
            return 110
        default:
            return 10
        }
    }
}

extension CollectionViewCustomLayoutViewController {
    fileprivate func colorForIndexPath(_ indexPath: IndexPath) -> UIColor {
        let alpha: CGFloat = 0.6
        switch indexPath.row % 5 {
        case 0:
            return UIColor(red: 25.0/255.0, green: 134.0/255.0, blue: 192.0/255.0, alpha: alpha)
        case 1:
            return UIColor(red: 249.0/255.0, green: 176.0/255.0, blue: 66.0/255.0, alpha: alpha)
        case 2:
            return UIColor(red: 0, green: 0, blue: 0, alpha: alpha)
        case 3:
            return UIColor(red: 36.0/255.0, green: 138.0/255.0, blue: 64.0/255.0, alpha: alpha)
        case 4:
            return UIColor(red: 232.0/255.0, green: 54.0/255.0, blue: 81.0/255.0, alpha: alpha)
        default:
            return .clear
        }
    }
    
    @objc fileprivate func panning(_ gestureRecognizer: UIPanGestureRecognizer) {
        switch gestureRecognizer.state {
        case .began:
            if let layout = collectionView?.collectionViewLayout as? CircleCollectionViewLayout {
                currentOffset = layout.offset
            }
        case .changed:
            let point = gestureRecognizer.translation(in: gestureRecognizer.view)
            if let layout = collectionView?.collectionViewLayout as? CircleCollectionViewLayout {
                layout.offset = currentOffset + (point.x / -200)
            }
        default:
            break
        }
    }
}

extension CollectionViewCustomLayoutViewController: LayoutPopoverTableViewControllerDelegate {
    func didSelectLayoutType(_ layoutType: LayoutType) {
        self.layoutType = layoutType
        title = layoutType.description
        dismiss(animated: true, completion: nil)
        
        setupLayout()
        collectionView.performBatchUpdates({ [weak self] in
            self?.updateNumberOfItems()
            self?.collectionView.reloadSections(IndexSet(integer: 0))
        }, completion: nil)
    }
}
