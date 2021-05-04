//
//  ItemDetailsViewController.swift
//  Moshtaryat
//
//  Created by Macbook on 20/04/2021.
//

import UIKit
import JGProgressHUD
class ItemDetailsViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var imageCollectionView: UICollectionView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK: - Vars
    //donot make item optional because must be an item to show this screen
    var item: Item!
    var itemImages: [UIImage] = []
    let hud = JGProgressHUD(style: .dark)
    //cell margins
    private let sectionInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
    private let cellHeight : CGFloat = 196.0
    private let itemsPerRow: CGFloat = 1
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //print("item name is \(item.name)")
        setupUI()
        downloadPictures()
        //change the regular back btn to custom back btn
        self.navigationItem.leftBarButtonItems = [UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action: #selector(self.backAction))]
        //add basket btn
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(named: "addToBasket"), style: .plain, target: self, action: #selector(self.addToBasketButtonPressed))]

    }
    
    //MARK: - IBActions
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func addToBasketButtonPressed() {
       // print("add to pasket \(item.name)")
        //createNewBasket()
       
            
//            downloadBasketFromFirestore("1234") { (basket) in
//                    
//                if basket == nil {
//                    self.createNewBasket()
//                } else {
//                    basket!.itemIds.append(self.item.id)
//                    self.updateBasket(basket: basket!, withValues: [kITEMIDS : basket!.itemIds])
//                }
//            }
        //showLoginView()
        if User.currentUser() != nil {
            
            downloadBasketFromFirestore(User.currentId()) { (basket) in

                if basket == nil {
                    self.createNewBasket()
                } else {
                    basket!.itemIds.append(self.item.id)
                    self.updateBasket(basket: basket!, withValues: [kITEMIDS : basket!.itemIds])
                }
            }

        } else {
            showLoginView()
        }
    }
    
    //MARK: - Show login view
    
    private func showLoginView() {
        
        let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
        
        self.present(loginView, animated: true, completion: nil)
    }
    
    //MARK: - Add to basket
    //if user has no basket ,create basket for him
    private func createNewBasket() {
        
        let newBasket = Basket()
        newBasket.id = UUID().uuidString
       // newBasket.ownerId = "1234"
        newBasket.ownerId = User.currentId()
        newBasket.itemIds = [self.item.id]
        saveBasketToFirestore(newBasket)
        
        self.hud.textLabel.text = "Added to basket!"
        self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
        self.hud.show(in: self.view)
        self.hud.dismiss(afterDelay: 2.0)
    }
    //if user has allready a basket ,update basket for him
    private func updateBasket(basket: Basket, withValues: [String : Any]) {
        
        updateBasketInFirestore(basket, withValues: withValues) { (error) in
            //if  an error happend
            if error != nil {
                
                self.hud.textLabel.text = "Error: \(error!.localizedDescription)"
                self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)

                print("error updating basket", error!.localizedDescription)
            } else {
                
                self.hud.textLabel.text = "Added to basket!"
                self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                self.hud.show(in: self.view)
                self.hud.dismiss(afterDelay: 2.0)
            }
        }
    }
    
    //MARK: - Setup UI
    private func setupUI() {
        
        if item != nil {
            self.title = item.name
            nameLabel.text = item.name
            priceLabel.text = convertToCurrency(item.price)
            descriptionTextView.text = item.description
        }
        
    }
    
    
    //MARK: - Download Pictures
    
    private func downloadPictures() {
        
        if item != nil && item.imageLinks != nil {
            downloadImagesFromFirebase(imageUrls: item.imageLinks) { (allImages) in
                if allImages.count > 0 {
                    self.itemImages = allImages as! [UIImage]
                    self.imageCollectionView.reloadData()
                }
            }
        }
    }

}

extension ItemDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemImages.count == 0 ? 1 : itemImages.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemDetailsImageCollectionViewCell", for: indexPath) as! ItemDetailsImageCollectionViewCell

        //without this condtion the app will crash because the downloadPictures() method will take some time to download pictures from background so itemImages.count = 0 in frist time
        if itemImages.count > 0 {
            cell.setupImageWith(itemImage: itemImages[indexPath.row])
        }
        
        return cell

    }
}

extension ItemDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let availableWidth = collectionView.frame.width - sectionInsets.left

        return CGSize(width: availableWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return sectionInsets.left
    }
}
