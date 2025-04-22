//
//  Currency.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 22/04/2025.
//

import Foundation

enum Currency:Int, CaseIterable {
    case usd, gbp, ngn

    var title: String {
        switch self {
        case .usd:
            return "USD"
        case .gbp:
            return "GBP"
        case .ngn:
            return "NGN"
        }
    }

    var fullName: String {
        switch self {
        case .usd:
            return "US Dollar"
        case .gbp:
            return "British Pound Sterling"
        case .ngn:
            return "Nigerian Naira"
        }
    }

    var symbol: String {
        switch self {
        case .usd:
            return "$"
        case .gbp:
            return "£"
        case .ngn:
            return "₦"
        }
    }
    
    var locale: Locale {
            switch self {
            case .usd:
                return Locale(identifier: "en_US")
            case .gbp:
                return Locale(identifier: "en_GB")
            case .ngn:
                return Locale(identifier: "en_NG")
            }
        }
}


