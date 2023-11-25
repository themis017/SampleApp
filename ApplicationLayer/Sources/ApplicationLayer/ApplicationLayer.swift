
import Resolver

public struct ApplicationLayer: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("ApplicationCore") { container in
            print("Registers - ApplicationLayer")
        }
    }
}
