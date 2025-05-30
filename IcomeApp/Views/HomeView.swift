//
//  ContentView.swift
//  IcomeApp
//
//  Created by Abiodun Osagie on 14/04/2025.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    // MARK: - PROPERTIES
    @Query var transactions: [TransactionModel]
    
    @State private var showAddTransactionView: Bool = false
    @State private var transactionToEdit: TransactionModel?
    @State private var showSettings = false
    
    @AppStorage("orderDescending") var orderDescending = false
    @AppStorage("currency")  var currency: Currency = .ngn
    @AppStorage("filterMinimum") var filterMinimum: Double = 0.0
    
    @Environment(\.modelContext) private var context
    
    // MARK: - COMPUTED PROPERTIES
    private var displayTransactions: [TransactionModel] {
        let sortedTransactions = orderDescending ? transactions.sorted(
            by: { $0.date
                < $1.date}) : transactions.sorted(by: {$0.date > $1.date})
        let filteredTransactions = sortedTransactions.filter(
            { $0.amount > filterMinimum
            })
        return filteredTransactions
    }
    
    
    private var expenses: String {
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(
            0,
            { $0 + $1.amount
            })
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "#0.00"
    }
    
    private var incomes: String {
        let sumIncomes = transactions.filter({ $0.type == .income }).reduce(
            0,
            { $0 + $1.amount
            })
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumIncomes as NSNumber) ?? "#0.00"
    }
    
    var total: String {
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(
            0,
            { $0 + $1.amount
            })
        let sumIncomes = transactions.filter({ $0.type == .income }).reduce(
            0,
            { $0 + $1.amount
            })
        let total = sumIncomes - sumExpenses
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: total as NSNumber) ?? "#0.00"
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView()
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
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text("\(total)")
                            .font(.system(size: 42, weight: .light))
                            .foregroundStyle(.white)
                            .multilineTextAlignment(.leading)
                            .lineLimit(1)
                        
                    }//: VSTACK
                    Spacer()
                }//: HSTACK
                .padding(.top)
                
                HStack(spacing: 25) {
                    VStack(alignment: .leading) {
                        Text("Expense")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        Text("\(expenses)")
                            .font(.system(size: 15, weight: .regular))
                            .foregroundStyle(.white)
                    }//: EXPENSE VSTACK
                    VStack(alignment: .leading) {
                        Text("Income")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundStyle(.white)
                        Text("\(incomes)")
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
                        ForEach(displayTransactions) { transaction in
                            Button(action: {
                                transactionToEdit = transaction
                            }, label: {
                                
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            })
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }//: VSTACK
                
                FloatingButton()
            }//: ZSTACK
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transactionToEdit in
                AddTransactionView(transactionToEdit: transactionToEdit)
            })
            .navigationDestination(isPresented: $showAddTransactionView, destination: {
                AddTransactionView()
            })
            .sheet(isPresented: $showSettings, content: {
                SettingsView()
            })
            .toolbar{
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettings = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.black)
                    }
                    
                }
            }//: TOOLBAR
        }//: NAVIGATION STACK
        
    }
    
    private func delete(at offsets: IndexSet) {
        for index in offsets {
            let transactionToDelete = transactions[index]
            context.delete(transactionToDelete)
            try? context.save()
        }
    }
}
// MARK: - PREVIEW
#Preview {
    let previewContainer = PreviewHelper.previewContainer
    return HomeView()
        .modelContainer(previewContainer)
}


