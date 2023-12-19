import Resolver
import ApplicationLayer

public struct HomeFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("HomeFeature") { container in
            print("Registers - HomeFeature")
        }
    }
}
