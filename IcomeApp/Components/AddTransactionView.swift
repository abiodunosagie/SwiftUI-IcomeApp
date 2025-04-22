//
//  AddTransactionView.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 14/04/2025.
//

import SwiftUI

struct AddTransactionView: View {
   
    @State private var amount = 0.00
    @State private var selectedTransactionType: TransactionType = .expense
    @State private var transactiontitle: String = ""
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    @Binding var transactions: [Transaction]
    var transactionToEdit: Transaction?
    @Environment(\.dismiss) var dismiss
    @AppStorage("currency") var currency: Currency = .ngn
    
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter
    }
    var body: some View {
        VStack {
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Divider()
                .padding(.horizontal, 30)
            
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) {transactionType in
                    Text(transactionType.title)
                        .tag("transactionType")
                }
            }
            
            TextField("Title", text: $transactiontitle)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 30)
                .padding(.top)
            
            Button {
                guard transactiontitle.count >= 3 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be three or more characters long."
                    showAlert = true
                    return
                }
              let transaction =  Transaction(
                    title: transactiontitle,
                    type: selectedTransactionType,
                    amount: amount,
                    date: Date())
                if let transactionToEdit = transactionToEdit {
                    guard let indexOfTransaction = transactions.firstIndex(
                        of: transactionToEdit
                    ) else {
                        alertTitle = "Soemthing went wrong!"
                        alertMessage = "Cannot update this transaction right now."
                        showAlert = true
                        return
                    }
                    transactions[indexOfTransaction] = transaction
                } else {
                    
                    transactions.append(transaction)
                    amount = 0.00
                    transactiontitle = ""
                    selectedTransactionType = .expense
                }
                dismiss()

               
            } label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            }
            .padding(.horizontal, 30)

            
            Spacer()
        }//: VSTACK
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                selectedTransactionType = transactionToEdit.type
                transactiontitle = transactionToEdit.title
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("Okay")
            }

        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
