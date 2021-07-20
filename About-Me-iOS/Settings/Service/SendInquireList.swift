import Foundation

struct SendInquireList: Codable {
    var code: Int // 200
    var message: String // 메일 전송을 완료했습니다. 최대한 빠른 시일내에 답변부탁드립니다.
}
