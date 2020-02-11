import SwiftyStoreKit
import StoreKit

enum ContentViewEvent: String {
    case viewPurchase = "view_purchase"
    case viewPurchaseTimer = "view_purchase_timer"
    case clickVKGroup = "click_to_vk_group"
    case userClickInviteFriend = "user_click_to_invite_friend"
    case inviteFriend = "invite_friend"
    case shareFromTheThemeAppStoreLink = "share_from_the_theme_app_store_link"
    case shareFromResult = "share_from_exam_result"
    
    //onboarding
    case viewOnboarding = "view_onboarding"
    case applyOnboarding = "apply_onboarding"
    case skipOnboarding = "skip_onboarding"
    
    //special offer
    case userViewSpeacialOffer = "user_view_speacial_offer"
    case userInitiatePurchaseFromSpecialOffer = "user_initiate_purchase_from_special_offer"
    case userPurchaseFromSpecialOffer = "user_purchase_from_special_offer"
}

extension ContentViewEvent: EventType {
    
    func name(for provider: ProviderType) -> String? {
        return self.rawValue
    }
    
    func parameters(for provider: ProviderType) -> [String : Any]? {
        return nil
    }
    
}

enum DefaultEvent {
    
    case initiatePurchase(product: SKProduct)
    case purchase(details: PurchaseDetails)

}

extension DefaultEvent: EventType {
    
    /// An event name to be logged
    func name(for provider: ProviderType) -> String? {
        switch self {
        case .initiatePurchase:
            return "initiatePurchase"
        case .purchase:
            return "purchase"
        }
    }
    
    /// Parameters to be logged
    func parameters(for provider: ProviderType) -> [String: Any]? {
        switch self {
        case .initiatePurchase, .purchase:
            return [:]
        }
    }
}

protocol AnalyticsType {
    associatedtype Event: EventType
    func register(provider: ProviderType) -> Self
    func log(_ event: Event)
}

public class AnalyticsService<Event: EventType>: AnalyticsType {
    
    private(set) var providers: [ProviderType] = []
    
    init() {
    }
    
    @discardableResult
    public func register(provider: ProviderType) -> Self {
        self.providers.append(provider)
        return self
    }
    
    public func log(_ event: Event) {
        for provider in self.providers {
            guard let eventName = event.name(for: provider) else { continue }
            let parameters = event.parameters(for: provider)
            provider.log(eventName, parameters: parameters)
        }
    }
}
