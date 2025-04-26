//
//  TransactionModel.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 14/04/2025.
//

import Foundation
import SwiftUI
import SwiftData

@Model class TransactionModel {
    
    var id = UUID()
    var title: String
    var type: TransactionType
    var amount: Double
    var date: Date
    
    init(
        id: UUID,
        title: String,
        type: TransactionType,
        amount: Double,
        date: Date
        
    ) {
        
        self.id = id
        self.title = title
        self.type = type
        self.amount = amount
        self.date = date
        
    }
    
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    
    func displayAmount(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00"
    }
}

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let type: TransactionType
    let amount: Double
    let date: Date
    
    
    // MARK: - COMPUTED PROPERTIES
    var displayDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    
    func displayAmount(currency: Currency) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: amount as NSNumber) ?? "$0.00"
    }
}
