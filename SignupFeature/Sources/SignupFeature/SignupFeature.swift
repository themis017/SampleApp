import Resolver
import ApplicationLayer

public struct SignupFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("SignupFeature") { container in
            print("Registers - SignupFeature")
        }
    }
}
