import Resolver
import ApplicationLayer

public struct SearchFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("SearchFeature") { container in
            print("Registers - SearchFeature")
        }
    }
}
