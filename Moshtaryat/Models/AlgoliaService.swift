//
//  AlgoliaService.swift
//  Moshtaryat
//
//  Created by Macbook on 29/04/2021.
//

import Foundation
import InstantSearchClient //Algolia

class AlgoliaService {
    
    static let shared = AlgoliaService()
    
    let client = Client(appID: kALGFOLIA_APP_ID, apiKey: kALGOLIA_ADMIN_KEY)
    let index = Client(appID: kALGFOLIA_APP_ID, apiKey: kALGOLIA_ADMIN_KEY).index(withName: "item_Name")
    
    private init() {}
}
