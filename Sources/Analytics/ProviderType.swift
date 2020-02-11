import Foundation

public protocol ProviderType {
    public func log(_ eventName: String, parameters: [String: Any]?)
}
