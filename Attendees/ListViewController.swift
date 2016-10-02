//
//  TableViewController.swift
//  Attendees
//
//  Created by Manuel Reinhard on 01.10.16.
//  Copyright © 2016 Manuel Reinhard. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController {

    var counts = CountPersister.loadAll()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Listen to right swipe
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeRight))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)

        // Add some space on top of the table
        self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        cell.dateLabel.text  = timeAgoSince(date: counts[indexPath.row].date!)
        cell.titleLabel.text = counts[indexPath.row].title
        cell.countLabel.text = String(counts[indexPath.row].count)
        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            CountPersister.delete(count: counts[indexPath.row])
            counts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    // MARK: Functions
    func respondToSwipeRight(gesture: UIGestureRecognizer) {
        if gesture is UISwipeGestureRecognizer {
            _ = navigationController?.popViewController(animated: true)
        }
    }
}
