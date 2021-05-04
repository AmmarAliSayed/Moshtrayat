//
//  ItemsTableViewController.swift
//  Moshtaryat
//
//  Created by Macbook on 18/04/2021.
//

import UIKit
import EmptyDataSet_Swift

class ItemsTableViewController: UITableViewController {

    //MARK: - vars
    var category : Category?
    var itemArray :[Item] = []
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
       // print(category?.name)
        //remove the lines between the empty cells
        tableView.tableFooterView = UIView()
        self.title = category?.name
        
        tableView.emptyDataSetSource = self
        tableView.emptyDataSetDelegate = self
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if category != nil {
            loadItems()
        }
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return itemArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as! ItemTableViewCell

        // Configure the cell...
        cell.generateCell(itemArray[indexPath.row])
        return cell
    }
    
    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        showItemView(itemArray[indexPath.row])
    }
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "itemToAddItemSeg" {
            
            let vc = segue.destination as! AddItemViewController
            vc.category = category!
        }
    }
    
    private func showItemView(_ item: Item) {
        
        let itemVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "ItemDetailsViewController") as! ItemDetailsViewController
        
        itemVC.item = item
        
        self.navigationController?.pushViewController(itemVC, animated: true)
    }
    
    //MARK: - Load Items from firebase
    
    private func loadItems() {
        downloadItemsFromFirebase(category!.id) { (allItems) in
          //  print(allItems.count)
            self.itemArray = allItems
            self.tableView.reloadData()
        }
    }
}
//MARK: - EmptyDataSetSource,EmptyDataSetDelegate
extension ItemsTableViewController: EmptyDataSetSource, EmptyDataSetDelegate {
    
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
