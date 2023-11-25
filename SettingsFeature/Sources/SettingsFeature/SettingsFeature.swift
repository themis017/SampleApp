
import Resolver
import ApplicationLayer

public struct SettingsFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("SettingsFeature") { container in

        }
    }
}
