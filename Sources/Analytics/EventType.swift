import Foundation

public protocol EventType {
    public func name(for provider: ProviderType) -> String?
    public func parameters(for provider: ProviderType) -> [String: Any]?
}
