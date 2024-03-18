import Foundation

struct BaseResponse: Codable {
    let code: Int?
    let success: Bool?
    let message: String?
}
