import Resolver
import ApplicationLayer

public struct FavouritesFeature: AppFeatureModule {
    public static let version = "0.1"
    
    public init() {}
    
    public var feature: AppFeature {
        AppFeature("FavouritesFeature") { container in
            print("Registers - FavouritesFeature")
        }
    }
}
