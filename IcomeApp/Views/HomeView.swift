//
//  ContentView.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 14/04/2025.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @State private var transactions: [Transaction] = [
        Transaction(title: "Apple", type: .expense, amount: 5.00, date: Date()),
        Transaction(title: "Banana", type: .expense, amount: 2.00, date: Date())
    ]
    @State private var showAddTransactionView: Bool = false
    @State private var transactionToEdit: Transaction?
    
    
    // MARK: - FUNCTIONS
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70, height: 70)
                    .foregroundStyle(.white)
                    .padding(.bottom, 5)
            }
            .background(Color.primaryLightGreen)
            .clipShape(Circle())
          
        }//: VSTACK
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.primaryLightGreen)
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    VStack {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text("$2")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(.white)
                    }//: VSTACK
                    Spacer()
                }//: HSTACK
                .padding(.top)
               
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        Text("$22")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }//: EXPENSE VSTACK
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        Text("$82")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    } //: INCOME VSTACK
                }//: HSTACK
                Spacer()
            }//: VSTACK
            .padding(.leading)
        }//: ZSTACK
        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 5)
        .frame(height: 150)
        .padding(.horizontal)
        
        
    }
    // MARK: - BODY
    var body: some View {
        NavigationStack {
            ZStack {
                    VStack {
                        BalanceView()
                        List {
                            ForEach(transactions) { transaction in
                                Button(action: {
                                    transactionToEdit = transaction
                                }, label: {
                                    
                                    TransactionView(transaction: transaction)
                                        .foregroundStyle(.black)
                                })
                            }
                        }
                        .scrollContentBackground(.hidden)
                    }//: VSTACK
                   
                
                
                FloatingButton()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactions: $transactions,
                                   transactionToEdit: transactionToEdit
                )
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView(transactions: $transactions)
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }

                }
            }
        }//: ZSTACK
        
    }
}
// MARK: - PREVIEW
#Preview {
    HomeView()
}


