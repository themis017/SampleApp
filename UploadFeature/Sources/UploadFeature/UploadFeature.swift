import Resolver
import ApplicationLayer

public struct UploadFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("UploadFeature") { container in
            print("Registers - UploadFeature")
        }
    }
}
