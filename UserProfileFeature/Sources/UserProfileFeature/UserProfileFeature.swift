
import Resolver
import ApplicationLayer

public struct UserProfileFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("UserProfileFeature") { container in
            print("Registers - UserProfileFeature")
        }
    }
}
