import Foundation

struct BaseYoutubeApiResponse<T: Codable>: Codable {
    let code: Int?
    let message: String?
    let items: T?
    let success: Bool?
}

struct YoutubeResponse: Codable {
    let id: YoutubeVideoId
}

struct YoutubeVideoId: Codable {
    let videoId: String?
}
