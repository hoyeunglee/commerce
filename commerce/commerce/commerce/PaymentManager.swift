import Foundation
import PassKit
import StoreKit

enum PaymentError: LocalizedError {
    case applePayUnavailable
    case iapUnavailable
    case productNotFound
    case userCancelled
    case unknown

    var errorDescription: String? {
        switch self {
        case .applePayUnavailable:
            return "Apple Pay is not available on this device or is not configured."
        case .iapUnavailable:
            return "In‑App Purchases are not available."
        case .productNotFound:
            return "The requested product could not be found."
        case .userCancelled:
            return "The operation was cancelled."
        case .unknown:
            return "An unknown error occurred."
        }
    }
}

@MainActor
final class PaymentManager: NSObject {
    static let shared = PaymentManager()

    // Replace with your real merchant identifier configured in the Apple Developer portal
    private let merchantIdentifier = "merchant.com.example.commerce"

    // Replace with your real StoreKit product identifier configured in App Store Connect
    static let checkoutProductID = "com.example.commerce.checkout"

    private var applePayCompletion: ((Result<Void, Error>) -> Void)?
}

// MARK: - Apple Pay
extension PaymentManager: PKPaymentAuthorizationControllerDelegate {
    func startApplePay(total: Double, currencyCode: String = "USD", countryCode: String = "US", completion: @escaping (Result<Void, Error>) -> Void) {
        guard PKPaymentAuthorizationController.canMakePayments() else {
            completion(.failure(PaymentError.applePayUnavailable))
            return
        }

        let request = PKPaymentRequest()
        request.merchantIdentifier = merchantIdentifier
        request.countryCode = countryCode
        request.currencyCode = currencyCode
        request.supportedNetworks = [.visa, .masterCard, .amex, .discover]
        request.merchantCapabilities = [.threeDSecure]

        let totalAmount = NSDecimalNumber(value: total)
        request.paymentSummaryItems = [
            PKPaymentSummaryItem(label: "Total", amount: totalAmount)
        ]

        let controller = PKPaymentAuthorizationController(paymentRequest: request)
        applePayCompletion = completion
        controller.delegate = self
        controller.present { presented in
            if !presented {
                completion(.failure(PaymentError.applePayUnavailable))
            }
        }
    }

    func paymentAuthorizationControllerDidFinish(_ controller: PKPaymentAuthorizationController) {
        controller.dismiss { [weak self] in
            Task { @MainActor [weak self] in
                guard let self else { return }
                if let completion = self.applePayCompletion {
                    // If we reach here without didAuthorize calling completion, treat as cancelled
                    completion(.failure(PaymentError.userCancelled))
                    self.applePayCompletion = nil
                }
            }
        }
    }

    func paymentAuthorizationController(_ controller: PKPaymentAuthorizationController, didAuthorizePayment payment: PKPayment, handler completion: @escaping (PKPaymentAuthorizationResult) -> Void) {
        // In a real app, send `payment.token` to your server for processing.
        // For demo, immediately succeed.
        completion(PKPaymentAuthorizationResult(status: .success, errors: nil))
        applePayCompletion?(.success(()))
        applePayCompletion = nil
    }
}

// MARK: - StoreKit 2
extension PaymentManager {
    func purchaseCheckoutProduct() async -> Result<Void, Error> {
        do {
            let products = try await StoreKit.Product.products(for: [Self.checkoutProductID])
            guard let product = products.first else {
                return .failure(PaymentError.productNotFound)
            }
            let result = try await product.purchase()
            switch result {
            case .success(let verification):
                switch verification {
                case .verified:
                    // In a real app, deliver content and optionally validate receipt on server.
                    return .success(())
                case .unverified(_, let error):
                    return .failure(error)
                }
            case .userCancelled:
                return .failure(PaymentError.userCancelled)
            case .pending:
                // Pending requires additional action (e.g., Ask to Buy). Treat as unknown here.
                return .failure(PaymentError.unknown)
            @unknown default:
                return .failure(PaymentError.unknown)
            }
        } catch {
            return .failure(error)
        }
    }
}
