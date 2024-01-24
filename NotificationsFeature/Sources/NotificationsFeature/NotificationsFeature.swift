import Resolver
import ApplicationLayer

public struct NotificationsFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("NotificationsFeature") { container in
            print("Registers - NotificationsFeature")
        }
    }
}
