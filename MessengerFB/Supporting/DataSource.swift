//
//  DataSource.swift
//  MessengerFB
//
//  Created by MacBook Pro on 23/09/2025.
//

import Foundation
import CoreLocation

struct DataCountrySource {
    static let allCountries: [(code: String, name: String)] = {
        if #available(iOS 16, *) {
            // iOS 16+ dùng Locale.Region.isoRegions
            return Locale.Region.isoRegions.compactMap { region in
                let code = region.identifier
                let name = Locale.current.localizedString(forRegionCode: code) ?? code
                let flag = code.unicodeScalars
                    .map { 127397 + $0.value }
                    .compactMap(UnicodeScalar.init)
                    .map(String.init)
                    .joined()
                return (code.lowercased(), "\(flag) \(name)")
            }.sorted { $0.name < $1.name }
        } else {
            // iOS <16 dùng Locale.isoRegionCodes
            return Locale.isoRegionCodes.compactMap { code in
                let identifier = Locale.identifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                let name = Locale.current.localizedString(forIdentifier: identifier) ?? code
                let flag = code.unicodeScalars
                    .map { 127397 + $0.value }
                    .compactMap(UnicodeScalar.init)
                    .map(String.init)
                    .joined()
                return (code.lowercased(), "\(flag) \(name)")
            }.sorted { $0.name < $1.name }
        }
    }()
}

struct DataLanguageSource {
    /// Danh sách ngôn ngữ thông dụng (code + tên hiển thị)
    static let commonLanguages: [(code: String, name: String)] = [
        ("vi", "🇻🇳 Tiếng Việt"),
        ("en", "🇺🇸 English"),
        ("zh", "🇨🇳 中文 (Chinese)"),
        ("ja", "🇯🇵 日本語 (Japanese)"),
        ("ko", "🇰🇷 한국어 (Korean)"),
        ("fr", "🇫🇷 Français (French)"),
        ("de", "🇩🇪 Deutsch (German)"),
        ("es", "🇪🇸 Español (Spanish)"),
        ("ru", "🇷🇺 Русский (Russian)"),
        ("ar", "🇸🇦 العربية (Arabic)")
    ]
}

struct WardItem: Codable {
    let Ward: String
}

// ProvinceFlat mới
struct ProvinceFlat: Codable {
    let name: String
    let wards: [String]
}

struct DataVnSource {
    static func loadProvinces() -> [ProvinceFlat] {
        guard let url = Bundle.main.url(forResource: "vn_locations", withExtension: "json") else {
            print("Không tìm thấy file JSON")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let rawDict = try JSONDecoder().decode([String: [WardItem]].self, from: data)
            
            // Chuyển sang ProvinceFlat
            let provinces: [ProvinceFlat] = rawDict.map { (key, wards) in
                ProvinceFlat(name: key, wards: wards.map { $0.Ward })
            }.sorted { $0.name < $1.name }
            
            return provinces
        } catch {
            print("Lỗi load JSON: \(error)")
            return []
        }
    }
}

