//
//  CategoryCollectionViewController.swift
//  Moshtaryat
//
//  Created by Macbook on 17/04/2021.
//

import UIKit



class CategoryCollectionViewController: UICollectionViewController {

    //MARK: - vars
    var categoryArray :[Category] = []
    //set margins of the cell
    private let sectionInsets = UIEdgeInsets(top: 20.0, left: 10.0, bottom: 20.0, right: 10.0)
    private let itemsPerRow: CGFloat = 3
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //call it once
        //createCategorySet()
//        downloadCategoriesFromFirebase { (allCategories) in
//            print(allCategories)
//        }

        // Register cell classes
       // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadCategories()
    }
    
    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return categoryArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CategoryCollectionViewCell
    
        // Configure the cell
        cell.generateCell(categoryArray[indexPath.row])
        self.drawCardBorder(view: cell.contentView)
        return cell
    }
    
    //MARK: UICollectionView Delegate
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "categoryToItemsSeg", sender: categoryArray[indexPath.row])
    }
    
    
    //MARK: Navigation
    //called before segue operation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "categoryToItemsSeg" {
            
            let vc = segue.destination as! ItemsTableViewController
            vc.category = sender as! Category//sender is the category you are clicked
        }
    }
    
//MARK: - Download categories
    private func loadCategories(){
        downloadCategoriesFromFirebase { (allCategories) in
            print(allCategories.count)
            self.categoryArray = allCategories
            self.collectionView.reloadData()
        }
    }
    //MARK: - draw cell border
    func drawCardBorder(view : UIView){
        view.layer.cornerRadius = 15.0
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.systemGray.cgColor
        view.layer.masksToBounds = true
    }

}

extension CategoryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let withPerItem = availableWidth / itemsPerRow

        return CGSize(width: withPerItem, height: withPerItem)
        
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
        
    }
}
