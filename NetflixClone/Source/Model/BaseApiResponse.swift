import Foundation

struct BaseApiResponse<T: Codable>: Codable {
    let code: Int?
    let message: String?
    let results: T?
    let success: Bool?
}
