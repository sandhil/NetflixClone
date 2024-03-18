
import Foundation
import RxSwift
import Alamofire

class BackendClient {
    
    private let apiClient: ApiClient
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
    }
    
    func load<T: Codable>(request: ApiRequest) -> Single<T> {
        return apiClient.loadRequest(apiRequest: request)
    }
    
    func loadYoutube<T: Codable>(request: ApiRequest) -> Single<T> {
        return apiClient.loadYoutubeRequest(apiRequest: request)
    }
    
}
