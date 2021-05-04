//
//  ProfileTableViewController.swift
//  Moshtaryat
//
//  Created by Macbook on 25/04/2021.
//

import UIKit

class ProfileTableViewController: UITableViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var finishRegistrationButtonOutlet: UIButton!
    @IBOutlet weak var purchaseHistoryButtonOutlet: UIButton!
    
    //MARK: - Vars
    var editBarButtonOutlet: UIBarButtonItem!

    
    //MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        //remove empty cells
        tableView.tableFooterView = UIView()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("yoo")
        //check login status
       checkLoginStatus()
        checkOnboardingStatus()
    }
   

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 3
    }

    //MARK: - TableView Delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK: - Helpers
    private func checkLoginStatus() {
        
        if User.currentUser() == nil {
            createRightBarButton(title: "Login")
        } else {
            createRightBarButton(title: "Edit")
        }
    }

    
    private func createRightBarButton(title: String) {
        
        editBarButtonOutlet = UIBarButtonItem(title: title, style: .plain, target: self, action: #selector(rightBarButtonItemPressed))
        
        self.navigationItem.rightBarButtonItem = editBarButtonOutlet
    }
    
    private func checkOnboardingStatus() {
        
        print("....\(User.currentUser())")
        //if user logged in
        if User.currentUser() != nil {
            //if user finshes Registration
            if User.currentUser()!.onBoard {
                finishRegistrationButtonOutlet.setTitle("Account is Active", for: .normal)
                finishRegistrationButtonOutlet.isEnabled = false
            } else {
                
                finishRegistrationButtonOutlet.setTitle("Finish registration", for: .normal)
                finishRegistrationButtonOutlet.isEnabled = true
                finishRegistrationButtonOutlet.tintColor = .red
            }
            
            purchaseHistoryButtonOutlet.isEnabled = true
            
        } else {
            finishRegistrationButtonOutlet.setTitle("Logged out", for: .normal)
            finishRegistrationButtonOutlet.isEnabled = false
            purchaseHistoryButtonOutlet.isEnabled = false
        }
    }
    
    //MARK: - IBActions
    
    @objc func rightBarButtonItemPressed() {
        
        if editBarButtonOutlet.title == "Login" {
            //go to login view
           showLoginView()
        } else {
        //go to profile
           goToEditProfile()
        }
    }

    private func showLoginView() {

        let loginView = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(identifier: "loginView")
        
        loginView.modalPresentationStyle = .fullScreen //<------
        self.present(loginView, animated: true, completion: nil)
    }
    
    private func goToEditProfile() {
        performSegue(withIdentifier: "profileToEditSeg", sender: self)
    }
}
