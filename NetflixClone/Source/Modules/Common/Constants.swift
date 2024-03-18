import Foundation

struct Constants {
    static var baseURL: URL? {
        //        return (Bundle.main.object(forInfoDictionaryKey: "Base URL") as! String).toURL()
        return URL(string: "https://api.themoviedb.org/3/")
    }
    
    static var baseURLImage: URL? {
        return URL(string: "https://image.tmdb.org/t/p/w500/")
    }
    
    static var apiKey: String {
        "329720a353c6762a6a1145d3327e452f"
    }
    
    static var accessToken: String {
        "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIzMjk3MjBhMzUzYzY3NjJhNmExMTQ1ZDMzMjdlNDUyZiIsInN1YiI6IjY1ZTA2ZTYyYTgwNjczMDE0NWE3ZGE2OSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.SRT32YUDv_KiFAZYm1AsuFo6suLGX7vD2LVqUbvr3ks"
    }
    
    static var gcpApiKey: String {
        "AIzaSyCV6LJtqnXHPKrCn05VV0ViSWgeeNR8FHA"
    }
    
    static var youtubeBaseURL: URL? {
        return URL(string: "https://youtube.googleapis.com/youtube/v3/")
    }
    
}
