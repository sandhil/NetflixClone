import Foundation
import Alamofire
import RxSwift
import RxAlamofire

struct ApiRequest {
    
    let method: HTTPMethod
    let endPoint: EndPoint
    var parameters: [String: Any]? = nil
    var encoding: ParameterEncoding = JSONEncoding.default
    
}

class ApiClient {
    let baseURL: URL?
    var headers: HTTPHeaders?
    
    
    init(baseURL: URL? = nil) {
        self.baseURL = baseURL
//        headers?.add(name: "Authorization", value: "Bearer \(Constants.apiKey)")
        
        var header = HTTPHeaders()
//        header.add(name: "accept", value: "application/json")
//        header.add(name: "Authorization", value: "Bearer \(Constants.apiKey)")
        headers = header
    }
    
    func loadRequest<T: Codable>(apiRequest: ApiRequest) -> Single<T> {
        return request(apiRequest.method, path(apiRequest.endPoint.description), parameters: apiRequest.parameters, encoding: apiRequest.encoding, headers: headers)
            .validate { request, response, data in
                let statusCode  = response.statusCode
                if (statusCode <= 299 && statusCode >= 200){
                    return .success(())
                } else {
                    let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.statusCode))
                    return .failure(error)
                }
            }
            .responseString()
            .map { response, dataString in
                let jsonData = dataString.data(using: String.Encoding.utf8)!
                let baseApiResponse = try JSONDecoder().decode(BaseApiResponse<T>.self, from: jsonData)
                guard let data = baseApiResponse.results else { throw APIError.apiError("Something went wrong") }
                return data
            }
            .asSingle()
    }
    
    func loadYoutubeRequest<T: Codable>(apiRequest: ApiRequest) -> Single<T> {
        return request(apiRequest.method, youtubePath(apiRequest.endPoint.description), parameters: apiRequest.parameters, encoding: apiRequest.encoding, headers: headers)
            .validate { request, response, data in
                let statusCode  = response.statusCode
                if (statusCode <= 299 && statusCode >= 200){
                    return .success(())
                } else {
                    let error = AFError.responseValidationFailed(reason: .unacceptableStatusCode(code: response.statusCode))
                    return .failure(error)
                }
            }
            .responseString()
            .map { response, dataString in
                let jsonData = dataString.data(using: String.Encoding.utf8)!
                let baseApiResponse = try JSONDecoder().decode(BaseYoutubeApiResponse<T>.self, from: jsonData)
                guard let data = baseApiResponse.items else { throw APIError.apiError("Something went wrong") }
                return data
            }
            .asSingle()
    }
    
    private func path(_ path: String) -> String {
        return (baseURL != nil) ? "\(baseURL!.absoluteString)\(path)" : path
    }
    
    private func youtubePath(_ path: String) -> String {
        return (Constants.youtubeBaseURL != nil) ? "\(Constants.youtubeBaseURL!.absoluteString)\(path)" : path
    }
    
}

enum EndPoint: CustomStringConvertible {
    
    case requestToken
    case login
    case trendingMovies
    case trendingTv
    case popularMovies
    case upComingMovies
    case topRatedMovies
    case popularTv
    case search
    case youtubeSearch
    
    var description: String {
        switch self {
        case .requestToken: return "authentication/token/new"
        case .login: return "authentication/token/validate_with_login"
        case .trendingMovies: return "trending/movie/day"
        case .trendingTv: return "trending/tv/day"
        case .popularMovies: return "movie/popular"
        case .upComingMovies: return "movie/upcoming"
        case .topRatedMovies: return "movie/top_rated"
        case .popularTv: return "tv/popular"
        case .search: return "search/movie"
        case .youtubeSearch: return "search"
        }
    }
}

enum DecodableError: Error {
    case illegalInput
}

extension Decodable {
    
    static func fromJSON(_ string: String?) throws -> Self {
        guard string != nil else { throw DecodableError.illegalInput }
        let data = string!.data(using: .utf8)!
        return try JSONDecoder().decode(self, from: data)
    }
    
}

enum APIError: Error {
    case apiError(String)
}

enum RefreshTokenError: Error {
    case refreshTokenExpired(String)
}
