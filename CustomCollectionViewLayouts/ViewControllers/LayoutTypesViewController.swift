//
//  LayoutTypesViewController.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

class LayoutTypesViewController: UIViewController {
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
            tableView.dataSource = self
            tableView.delegate = self
        }
    }
    
    fileprivate let kCellIdentifier = "LayoutTypeCell"
    fileprivate let data: [LayoutType] = [.flow, .flowLargeTop, .customOlympicRings, .customCircle]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "UICollectionView Layouts"
    }
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let segueIdentifier = segue.identifier else { return }
        
        switch segueIdentifier {
        case "ToFlowLayout":
            if let layoutType = sender as? LayoutType,
                let destinationViewController = segue.destination as? CollectionViewCustomLayoutViewController {
                destinationViewController.configureWithCustomFlowLayout(layoutType)
            }
        default:
            break
        }
    }
}

// MARK: - UITableViewDataSource
extension LayoutTypesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kCellIdentifier, for: indexPath)
        
        cell.textLabel?.text = data[indexPath.row].description
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LayoutTypesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "ToFlowLayout", sender: data[indexPath.row])
    }
}
