//
//  TransactionView.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 14/04/2025.
//

import SwiftUI

struct TransactionView: View {
    // MARK: - PROPERTIES
    let transaction: Transaction
    // MARK: - BODY
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(transaction.displayDate)
                    .font(.system(size: 14))
                Spacer()
            }//: HSTACK
            .padding(.vertical, 5)
            .background(Color.lightGrayShade.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            HStack {
                Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(transaction.type == .income ? Color.green : Color.red
                    )
                VStack(alignment: .leading, spacing: 5) {
                    HStack {
                        Text(transaction.title)
                            .font(.system(size: 15, weight: .bold))
                        Spacer()
                        Text(String(transaction.displayAmount))
                            .font(.system(size: 15, weight: .bold))
                    }//: HSTACK
                    Text("Completed")
                        .font(.system(size: 14))
                }//: VSTACK
            }//: HSTACK
            
        }//: VSTACK
        .listRowSeparator(.hidden)
    }
}

#Preview {
    TransactionView(
        transaction: Transaction(
            title: "Apple",
            type: .expense,
            amount: 5.0,
            date: Date()
        )
    )
}
