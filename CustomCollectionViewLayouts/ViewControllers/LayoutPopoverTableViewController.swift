//
//  LayoutPopoverTableViewController.swift
//  CustomCollectionViewLayouts
//
//  Created by Brian Miller on 3/12/18.
//  Copyright © 2018 Brian Miller. All rights reserved.
//

import UIKit

protocol LayoutPopoverTableViewControllerDelegate: class {
    func didSelectLayoutType(_ layoutType: LayoutType)
}

class LayoutPopoverTableViewController: UITableViewController {
    var layoutTypes: [LayoutType] = [.flow, .flowLargeTop, .customOlympicRings, .customCircle]
    
    private weak var delegate: LayoutPopoverTableViewControllerDelegate?
    
    public func configureWithDelegate(_ delegate: LayoutPopoverTableViewControllerDelegate?) {
        self.delegate = delegate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LayoutTypeCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layoutTypes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LayoutTypeCell", for: indexPath)

        cell.textLabel?.text = layoutTypes[indexPath.row].description
        
        return cell
    }

    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        delegate?.didSelectLayoutType(layoutTypes[indexPath.row])
    }

}
