//
//  AddItemViewController.swift
//  Moshtaryat
//
//  Created by Macbook on 18/04/2021.
//

import UIKit
import Gallery
import JGProgressHUD
import NVActivityIndicatorView

class AddItemViewController: UIViewController {
    
    //MARK: - Vars
    var category : Category!
    var gallery: GalleryController!
    let hud = JGProgressHUD(style: .dark)
    var activityIndicator: NVActivityIndicatorView?
    var itemImages: [UIImage?] = []
    //MARK: - IBOutlets
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        //print(category.name)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //put the activityIndicator in center of the screen
        activityIndicator = NVActivityIndicatorView(frame: CGRect(x: self.view.frame.width / 2 - 30, y: self.view.frame.height / 2 - 30, width: 60, height: 60), type: .ballPulse, color: #colorLiteral(red: 0.9998469949, green: 0.4941213727, blue: 0.4734867811, alpha: 1), padding: nil)
    }
    
    
    
    
//MARK: - IBActions
    @IBAction func doneButtonPressed(_ sender: Any) {
        
        dismissKeayboard()
        
        if fieldsAreCompleted() {
         //   print("saving operation done")
            saveToFirebase()
        } else {
            //print("enter all data to fileds")
            self.hud.textLabel.text = "All fields are required!"
            self.hud.indicatorView = JGProgressHUDErrorIndicatorView()
            self.hud.show(in: self.view)
            self.hud.dismiss(afterDelay: 2.0)
        }
    }
    
    @IBAction func backgroundTapped(_ sender: Any) {
        dismissKeayboard()
    }
    @IBAction func cameraButtonPressed(_ sender: Any) {
        //reset itemImages array before add new images for new item
        itemImages = []
        showImageGallery()
        
    }
    
    //MARK: Helper functions
    
    private func dismissKeayboard() {
        self.view.endEditing(false)
    }
    //check from all fields not empty
    private func fieldsAreCompleted() -> Bool {
        
        return (titleTextField.text != "" && priceTextField.text != "" && descriptionTextView.text != "")
    }
    private func popTheView() {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: Save Item
    private func saveToFirebase() {
        showLoadingIndicator()
        let item = Item()
        item.id = UUID().uuidString
        item.name = titleTextField.text!
        item.categoryId = category.id
        item.description = descriptionTextView.text
        item.price = Double(priceTextField.text!)
        
        if itemImages.count > 0 {//then user add images
            uploadImages(images: itemImages, itemId: item.id) { (imageLikArray) in
                
                item.imageLinks = imageLikArray
                
                saveItemToFirestore(item)
                //after save item in firestore we save it in Algolia too
                saveItemToAlgolia(item: item)
                self.hideLoadingIndicator()
                //go back after add the item
                self.popTheView()
            }
          
            
        } else {
            saveItemToFirestore(item) //then user don't add images so save item without images
            saveItemToAlgolia(item: item)
            //go back after add the item
            popTheView()
        }
        
    }
    
    //MARK: Activity Indicator
    
    private func showLoadingIndicator() {
        
        if activityIndicator != nil {
            self.view.addSubview(activityIndicator!)
            activityIndicator!.startAnimating()
        }
    }

    private func hideLoadingIndicator() {
        
        if activityIndicator != nil {
            activityIndicator!.removeFromSuperview()
            activityIndicator!.stopAnimating()
        }
    }
        //MARK: Show Gallery
    private func showImageGallery() {
        
        self.gallery = GalleryController()
        self.gallery.delegate = self
        
        Config.tabsToShow = [.imageTab, .cameraTab]
        Config.Camera.imageLimit = 6
        
        self.present(self.gallery, animated: true, completion: nil)
    }
}
//MARK: - GalleryControllerDelegate

extension AddItemViewController: GalleryControllerDelegate {
    
    func galleryController(_ controller: GalleryController, didSelectImages images: [Image]) {
        
        if images.count > 0 {
            //convert the user selected images [resolvedImages] to uiImage type and then stored in itemImages array
            Image.resolve(images: images) { (resolvedImages) in
                
                self.itemImages = resolvedImages
            }
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, didSelectVideo video: Video) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryController(_ controller: GalleryController, requestLightbox images: [Image]) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func galleryControllerDidCancel(_ controller: GalleryController) {
        controller.dismiss(animated: true, completion: nil)
    }

    
}
