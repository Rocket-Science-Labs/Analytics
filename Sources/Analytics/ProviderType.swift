import Foundation

public protocol ProviderType {
    func log(_ eventName: String, parameters: [String: Any]?)
}
