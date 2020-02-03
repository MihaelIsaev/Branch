import Vapor

extension App {
    public struct AppReadModel: Codable {
        var devName: String
        var devEmail: String
        var origin: String
        var androidURL: String?
        var androidTabletURL: String?
        var iosURL: String?
        var ipadURL: String?
        var wechatURL: String?
        var androidURIScheme: String?
        var iosURIScheme: String?
        var desktopURIScheme: String?
        var webURL: String?
        var fireURL: String?
        var windowsPhoneURL: String?
        var blackberryURL: String?
        var shortURLDomain: String
        var defaultShortURLDomain: String
        var alternateShortURLDomain: String
        var textMessage: String
        var ogAppId: String
        var ogTitle: String
        var ogImageURL: String
        var ogDescription: String
        var alwaysOpenApp: Bool
        var uriRedirectMode: Int
//        var auto_fetch: Bool?
        var defaultDesktopURL: String?
        var iosApp: Int
        var androidApp: Int
        var androidPackageName: String?
        var iosBundleId: String?
//        var ios_additional_bundle_ids: String?
        var iosTeamId: String?
        var iosAppStoreId: String?
        var deepviewDesktop: String?
        var deepviewiOS: String?
        var deepviewAndroid: String?
        var passiveDeepviewiOS: String?
        var passiveDeepviewAndroid: String?
        var universalLinkingEnabled: String?
        var androidAppLinksEnabled: String?
//        var sha256_cert_fingerprints": null,
//        var sitemap_enabled": null,
//        var esp_config": null,
//        var map_utm_params": null,
//        var reserved_analytics_to_utm": null,
//        var android_cd_enabled": null,
//        var android_cd_hashed": null,
//        var ios_cd_enabled": null,
//        var ios_cd_hashed": null,
//        var redirect_domains_whitelist": null,
        var timezone: String
//        var journeys_open_app": null,
//        var mac_uri_scheme": null,
//        var mac_store_url": null,
//        var windows_uri_scheme": null,
//        var windows_store_url": null,
//        var windows_package_family_name": null,
//        var organization_id": null,
        var id: String?
        var appKey: String?
        var createdAt: String //"2017-08-07T19:31:47.958Z",
        var appName: String
        var iosStoreCountry: String
        var branchKey: String
        var branchSecret: String
//        var zuora_account_id": null
        
        private enum CodingKeys: String, CodingKey {
            case devName = "dev_name"
            case devEmail = "dev_email"
            case origin
            case androidURL = "android_url"
            case androidTabletURL = "android_tablet_url"
            case iosURL = "ios_url"
            case ipadURL = "ipad_url"
            case wechatURL = "wechat_url"
            case androidURIScheme = "android_uri_scheme"
            case iosURIScheme = "ios_uri_scheme"
            case desktopURIScheme = "desktop_uri_scheme"
            case webURL = "web_url"
            case fireURL = "fire_url"
            case windowsPhoneURL = "windows_phone_url"
            case blackberryURL = "blackberry_url"
            case shortURLDomain = "short_url_domain"
            case defaultShortURLDomain = "default_short_url_domain"
            case alternateShortURLDomain = "alternate_short_url_domain"
            case textMessage = "text_message"
            case ogAppId = "og_app_id"
            case ogTitle = "og_title"
            case ogImageURL = "og_image_url"
            case ogDescription = "og_description"
            case alwaysOpenApp = "always_open_app"
            case uriRedirectMode = "uri_redirect_mode"
            //        case auto_fetch = "auto_fetch"
            case defaultDesktopURL = "default_desktop_url"
            case iosApp = "ios_app"
            case androidApp = "android_app"
            case androidPackageName = "android_package_name"
            case iosBundleId = "ios_bundle_id"
            //        case ios_additional_bundle_ids = "ios_additional_bundle_ids"
            case iosTeamId = "ios_team_id"
            case iosAppStoreId = "ios_app_store_id"
            case deepviewDesktop = "deepview_desktop"
            case deepviewiOS = "deepview_ios"
            case deepviewAndroid = "deepview_android"
            case passiveDeepviewiOS = "passive_deepview_ios"
            case passiveDeepviewAndroid = "passive_deepview_android"
            case universalLinkingEnabled = "universal_linking_enabled"
            case androidAppLinksEnabled = "android_app_links_enabled"
            //        case sha256_cert_fingerprints = "sha256_cert_fingerprints"
            //        case sitemap_enabled = "sitemap_enabled"
            //        case esp_config = "esp_config"
            //        case map_utm_params = "map_utm_params"
            //        case reserved_analytics_to_utm = "reserved_analytics_to_utm"
            //        case android_cd_enabled = "android_cd_enabled"
            //        case android_cd_hashed = "android_cd_hashed"
            //        case ios_cd_enabled = "ios_cd_enabled"
            //        case ios_cd_hashed = "ios_cd_hashed"
            //        case redirect_domains_whitelist = "redirect_domains_whitelist"
            case timezone
            //        case journeys_open_app = "journeys_open_app"
            //        case mac_uri_scheme = "mac_uri_scheme"
            //        case mac_store_url = "mac_store_url"
            //        case windows_uri_scheme = "windows_uri_scheme"
            //        case windows_store_url = "windows_store_url"
            //        case windows_package_family_name = "windows_package_family_name"
            //        case organization_id = "organization_id"
            case id
            case appKey = "app_key"
            case createdAt = "creation_date"
            case appName = "app_name"
            case iosStoreCountry = "ios_store_country"
            case branchKey = "branch_key"
            case branchSecret = "branch_secret"
            //        case zuora_account_id = "zuora_account_id"
        }
    }
    
    public func read(on eventLoop: EventLoop) -> EventLoopFuture<AppReadModel> {
        branch.request(on: eventLoop, to: .app, parameters: branch.configuration.key, query: ["branch_secret": branch.configuration.secret], method: .GET).flatMapThrowing { response in
            try response.content.decode(AppReadModel.self)
        }
    }
}
