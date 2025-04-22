//
//  SettingsView.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 22/04/2025.
//

import SwiftUI

struct SettingsView: View {
    // MARK: - PROPERTIES
    
    @AppStorage("orderDescending") private var orderDescending = false
    @AppStorage("currency")  var currency: Currency = .ngn
    @AppStorage("filterMinimum") var filterMinimum: Double = 0.0
    
    // MARK: - COMPUTED PROPERTIES
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    
    
    var body: some View {
        NavigationStack {
            List {
                HStack {
                    Toggle(isOn: $orderDescending) {
                        Text("Order \(orderDescending ? "(Earliest)" : "(Latest)")")
                    }
                }
                HStack{
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases, id: \.self) { currency in
                            Text(currency.title)
                            
                        }
                    }
                }
                HStack {
                    Text("Filter Minimum")
                    TextField("", value: $filterMinimum, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                    
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
