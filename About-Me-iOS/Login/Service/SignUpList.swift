import Foundation

struct SignUpList: Encodable {
    var type: String
}
struct SignUpListForApple: Encodable {
    var code: String
    var id_token: String
}

struct SignInList: Encodable {
    var type: String
    var fcmToken: String
}

struct SignUpResponse: Decodable {
    var userId: Int
}

struct SignInResponse: Decodable {
    var userId: Int
    var nickName: String
}
