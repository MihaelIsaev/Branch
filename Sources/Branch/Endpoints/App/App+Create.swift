import Vapor

extension App {
    public struct CreatePayload: Content {
        var userId: String
        var appName: String
        var devName: String
        var devEmail: String
        
        var alwaysOpenApp: String
        
        var androidApp: String
        var androidURL: String
        var androidURLScheme: String
        var androidPackageName: String
        var androidAppLinksEnabled: String
        
        var iosApp: String
        var iosURL: String
        var iosURLScheme: String
        var iosStoreCountry: String
        var universalLinkingEnabled: String
        var iosBundleId: String
        var iosTeamId: String
        
        var fireURL: String
        var windowsPhoneURL: String
        var blackberryURL: String
        var webURL: String
        var defaultDesktopURL: String
        
        var textMessage: String
        
        var ogAppId: String
        var ogTitle: String
        var ogDescription: String
        var ogImageURL: String
        
        var deepviewDesktop: String
        var deepviewiOS: String
        var deepviewAndroid: String
        
        private enum CodingKeys: String, CodingKey {
            case userId = "user_id"
            case appName = "app_name"
            case devName = "dev_name"
            case devEmail = "dev_email"
            
            case alwaysOpenApp = "always_open_app"
            
            case androidApp = "android_app"
            case androidURL = "android_url"
            case androidURLScheme = "android_uri_scheme"
            case androidPackageName = "android_package_name"
            case androidAppLinksEnabled = "android_app_links_enabled"
            
            case iosApp = "ios_app"
            case iosURL = "ios_url"
            case iosURLScheme = "ios_uri_scheme"
            case iosStoreCountry = "ios_store_country"
            case universalLinkingEnabled = "universal_linking_enabled"
            case iosBundleId = "ios_bundle_id"
            case iosTeamId = "ios_team_id"
            
            case fireURL = "fire_url"
            case windowsPhoneURL = "windows_phone_url"
            case blackberryURL = "blackberry_url"
            case webURL = "web_url"
            case defaultDesktopURL = "default_desktop_url"
            
            case textMessage = "text_message"
            
            case ogAppId = "og_app_id"
            case ogTitle = "og_title"
            case ogDescription = "og_description"
            case ogImageURL = "og_image_url"
            
            case deepviewDesktop = "deepview_desktop"
            case deepviewiOS = "deepview_ios"
            case deepviewAndroid = "deepview_android"
        }
    }
    
    public func create(on container: Container, payload: CreatePayload) throws -> Future<AppReadModel> {
        return try branch.request(on: container, to: .app, method: .POST) { req in
            try req.content.encode(payload)
        }.flatMap { response in
            return try response.content.decode(AppReadModel.self)
        }
    }
}
