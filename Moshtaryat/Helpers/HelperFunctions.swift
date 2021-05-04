//
//  HelperFunctions.swift
//  Moshtaryat
//
//  Created by Macbook on 20/04/2021.
//

import Foundation

func convertToCurrency(_ number: Double) -> String {
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = .currency
   // currencyFormatter.numberStyle = .scientific
    currencyFormatter.locale = Locale.current
    //currencyFormatter.locale = NSLocale.current
    return currencyFormatter.string(from: NSNumber(value: number))!
}
