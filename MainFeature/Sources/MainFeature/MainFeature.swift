import Resolver
import ApplicationLayer

public struct MainFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("MainFeature") { container in
            print("Registers - MainFeature")
        }
    }
}
