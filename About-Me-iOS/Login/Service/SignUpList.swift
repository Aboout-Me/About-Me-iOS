import Foundation

struct SignUpList: Encodable {
    var type: String
    var fcmToken: String
}
struct SignUpListForApple: Encodable {
    var code: String
    var id_token: String
    var fcmToken: String
}
struct SignInListForApple: Encodable {
    var code: String
    var id_token: String
    var fcmToken: String
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

struct SignInResponseForApple: Decodable {
    var userId: Int
    // var nickName: String
}
