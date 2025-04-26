//
//  TransactionType.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 14/04/2025.
//

import Foundation


enum TransactionType: String, CaseIterable, Identifiable, Codable {
    case income, expense
    var id: Self { self }
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
