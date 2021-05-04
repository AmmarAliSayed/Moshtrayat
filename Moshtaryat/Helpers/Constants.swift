//
//  Constants.swift
//  Moshtaryat
//
//  Created by Macbook on 17/04/2021.
//

import Foundation
//stripe
enum Constats {
    static let publishableKey = "pk_test_51IljbZHicWMh493bPR3fMpMcPl6UpRPfCUXnsjpozMk89ahKqIwXYxAJewuxZWWifnNnbu85DL964W8I83hYv8Rw00j8plnfAR"
    static let baseURLString = "https://moshtrayat.herokuapp.com" //"http://localhost:3000/"
    static let defaultCurrency = "usd"
    static let defaultDescription = "Purchase from Market"
}
//Firebase Headers
public let KUSER_PATH = "User"
public let KCATEGORY_PATH = "Category"
public let KITEMS_PATH = "Items"
public let KBASKET_PATH = "Basket"

//Category
public let KNAME = "name"
public let KIMAGENAME = "imageName"
public let  KOBJECTID = "objectId"

//Item
public let kCATEGORYID = "categoryId"
public let kDESCRIPTION = "description"
public let kPRICE = "price"
public let kIMAGELINKS = "imageLinks"


//Basket
public let kOWNERID = "ownerId"
public let kITEMIDS = "itemIds"
//User
public let kEMAIL = "email"
public let kFIRSTNAME  = "firstName"
public let kLASTNAME  = "lastName"
public let kFULLNAME  = "fullName"
public let kCURRENTUSER  = "currentUser"
public let kFULLADDRESS  = "fullAddress"
public let kONBOARD  = "onBoard"
public let kPURCHASEDITEMIDS  = "purchasedItemIds"
//IDS and Keys
public let kFILEREFERENCE = "gs://moshtaryat-faecc.appspot.com"
public let kALGFOLIA_APP_ID = "NK916NGGC7"
public let kALGOLIA_SEARCH_KEY = "4701cfef139389d8d33c239e8bb04efe"
public let kALGOLIA_ADMIN_KEY = "11c88451c6b7779b13adcb32f9bc88f5"
