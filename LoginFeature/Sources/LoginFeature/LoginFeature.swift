import Resolver
import ApplicationLayer

public struct LoginFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("LoginFeature") { container in
            print("Registers - LoginFeature")
        }
    }
}
