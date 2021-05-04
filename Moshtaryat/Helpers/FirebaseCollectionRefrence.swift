//
//  FirebaseCollectionRefrence.swift
//  Moshtaryat
//
//  Created by Macbook on 17/04/2021.
//

import Foundation
import FirebaseFirestore
enum FCollectionRefrence : String {
    case User
    case Category
    case Items
    case Basket
}
func FirebaseReference(_ collectionRefrence : FCollectionRefrence) -> CollectionReference {
    return Firestore.firestore().collection(collectionRefrence.rawValue)
}
