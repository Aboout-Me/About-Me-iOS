import Foundation

struct SignUpList: Encodable {
    var type: String
    // var auth_yn: Int
}

struct SignUpResponse: Decodable {
    var userId: Int
}
