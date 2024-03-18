//
//  HomeViewModel.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 3/1/24.
//

import Foundation
import Swinject
import Alamofire
import RxSwift
import SwiftUI
import FirebaseFirestore

class DownloadsViewModel: ObservableObject {
    @Published var movies:[Movie] = []
    
    let backendClient: BackendClient!
    let disposeBag = DisposeBag()
    
    init() {
        backendClient = Container.sharedContainer.resolve(BackendClient.self)
        //        getDownloadedMovies()
    }
    
    
    private func getUpComingMovies() {
        getUpComingMoviesFromBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.movies = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    private func getUpComingMoviesFromBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .upComingMovies, parameters: ["api_key": Constants.apiKey], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
    func getDownloadedMovies() {
        let db = Firestore.firestore()
        let docRef = db.collection("downloads").document("sandhiltmdb")
        
        docRef.getDocument { documentSnapshot, error in
            let data = documentSnapshot?.data()
            
            let movies = data?["movies"] ?? []
            
            if let jsonData = try? JSONSerialization.data(withJSONObject: movies) {
                let movies = try? JSONDecoder().decode([Movie].self, from: jsonData)
                self.movies = movies ?? []
            }
        }
    }
    
    func delete(movie: Movie) {
        let db = Firestore.firestore()
        let userRef = db.collection("downloads").document("sandhiltmdb")
        
        userRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user document: \(error)")
                return
            }
            
            guard let document = document, document.exists else {
                print("User document does not exist")
                return
            }
            
            // Proceed with removing the movie from the retrieved data (if needed)
            self?.removeMovieFromDocument(document: document, movieId: movie.id)
        }
    }
    
    private func removeMovieFromDocument(document: DocumentSnapshot, movieId: Int) {
        guard var movieData = document.data() else { return }
        guard var movieArray = movieData["movies"] as? [[String: Any]] else { return }
        movieArray.removeAll { movieDict in
            return movieDict["id"] as? Int == movieId
        }
        
        movieData["movies"] = movieArray
        let db = Firestore.firestore()
        let userRef = db.collection("downloads").document("sandhiltmdb")
        userRef.updateData(movieData) { _ in
        }
    }
}
