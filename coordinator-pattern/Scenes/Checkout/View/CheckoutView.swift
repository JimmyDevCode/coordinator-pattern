//
//  CheckoutView.swift
//  coordinator-pattern
//
//  Created by Jimmy Ronaldo Macedo Pizango on 27/12/25.
//

import SwiftUI

struct CheckoutView: View {

    @State private var selectedPayment: PaymentMethod = .card
    @State private var isProcessing: Bool = false
    var onPurchaseButton: (() -> Void)?
    

    var body: some View {
        VStack(spacing: 24) {

            // Title
            Text("Checkout")
                .font(.title2)
                .fontWeight(.semibold)

            // Product summary
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text("Producto")
                    Spacer()
                    Text("Plan Premium")
                        .fontWeight(.medium)
                }

                HStack {
                    Text("Precio")
                    Spacer()
                    Text("S/ 29.90")
                        .fontWeight(.medium)
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            // Payment method
            VStack(alignment: .leading, spacing: 12) {
                Text("Método de pago")
                    .font(.subheadline)
                    .fontWeight(.medium)

                ForEach(PaymentMethod.allCases, id: \.self) { method in
                    HStack {
                        Text(method.title)
                        Spacer()
                        if selectedPayment == method {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        selectedPayment = method
                    }
                }
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(12)

            // Total
            HStack {
                Text("Total")
                    .font(.headline)
                Spacer()
                Text("S/ 29.90")
                    .font(.headline)
            }

            // Pay button
            Button(action: simulatePayment) {
                HStack {
                    if isProcessing {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Text("Pagar ahora")
                            .fontWeight(.semibold)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(isProcessing ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .cornerRadius(12)
            }
            .disabled(isProcessing)

            Spacer()
        }
        .padding()
    }

    private func simulatePayment() {
        isProcessing = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isProcessing = false
            onPurchaseButton?()
        }
    }
}

enum PaymentMethod: CaseIterable {
    case card
    case transfer
    case wallet

    var title: String {
        switch self {
        case .card: return "Tarjeta"
        case .transfer: return "Transferencia"
        case .wallet: return "Billetera digital"
        }
    }
}

#Preview {
    CheckoutView()
}
