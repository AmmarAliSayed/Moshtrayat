//
//  PurchasedHistoryTableViewController.swift
//  Moshtaryat
//
//  Created by Macbook on 26/04/2021.
//

import UIKit
import EmptyDataSet_Swift
class PurchasedHistoryTableViewController: UITableViewController {
    //MARK: - Vars
    var itemArray : [Item] = []

    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        //remove empty cells
        tableView.tableFooterView = UIView()
        
        
        tableView.emptyDataSetDelegate = self
        tableView.emptyDataSetSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadItems()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PurchasedItemsCell", for: indexPath) as! ItemTableViewCell

        // Configure the cell...
        cell.generateCell(itemArray[indexPath.row])
        return cell
    }
    
    //MARK: - Load items
    
    private func loadItems() {
        
        downloadItems(User.currentUser()!.purchasedItemIds) { (allItems) in
            
            self.itemArray = allItems
            print("we have \(allItems.count) purchased items")
            self.tableView.reloadData()
        }
    }

}
//MARK: - EmptyDataSetSource,EmptyDataSetDelegate
extension PurchasedHistoryTableViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    
    func title(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        
        return NSAttributedString(string: "No itmes to display!")
    }
    
    func image(forEmptyDataSet scrollView: UIScrollView) -> UIImage? {
        return UIImage(named: "emptyData")
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView) -> NSAttributedString? {
        return NSAttributedString(string: "Please check back later")
    }
    
}
