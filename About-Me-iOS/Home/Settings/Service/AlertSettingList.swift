import Foundation

struct AlertSettingList: Codable {
    var userId: Int
}

struct AlertSettingResponse: Codable {
    var code: Int
    var body: String
}

