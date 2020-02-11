import StoreKit

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
