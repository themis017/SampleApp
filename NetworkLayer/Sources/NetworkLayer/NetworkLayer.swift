
import Resolver
import ApplicationLayer

public struct NetworkLayer: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("NetworkLayer") { container in
            print("Registers - NetworkLayer")
        }
    }
}
