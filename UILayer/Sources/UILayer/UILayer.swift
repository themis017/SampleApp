
import Resolver
import ApplicationLayer

public struct UILayer: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("UILayer") { container in

        }
    }
}
