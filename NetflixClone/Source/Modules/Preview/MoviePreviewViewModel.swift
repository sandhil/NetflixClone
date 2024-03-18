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

class MoviePreviewViewModel: ObservableObject {
    var movie: Movie!
    @Published var youtubeItem: YoutubeVideoId?
    @Published var showDownload = false
    
    let backendClient: BackendClient!
    let disposeBag = DisposeBag()
    
    init() {
        backendClient = Container.sharedContainer.resolve(BackendClient.self)
    }
    
    
    func getMovie() {
        getMovieFromBackend()
            .subscribe(onSuccess: { [weak self] response in
                self?.youtubeItem = response.first?.id
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    private func getMovieFromBackend() -> Single<[YoutubeResponse]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .youtubeSearch, parameters: ["key": Constants.gcpApiKey, "q": "\(movie.original_title ?? "") trailer"], encoding: URLEncoding.queryString)
        return backendClient.loadYoutube(request: apiRequest)
    }
    
    func checkDownloadStatus() {
        let db = Firestore.firestore()
        let docRef = db.collection("downloads").document("sandhiltmdb")
        docRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching user document: \(error)")
                return
            }

            guard let document = document, document.exists else {
                print("User document does not exist")
                return
            }

            guard let movieData = document.data(),
                  let movieArray = movieData["movies"] as? [[String: Any]] else {
                print("Could not get movies array from user document")
                return
            }

            let movieExists = movieArray.contains { movieDict in
                return movieDict["id"] as? Int == self?.movie.id
            }

            self?.showDownload = !movieExists
        }
    }
    
    func downloadMovie() {
        let db = Firestore.firestore()
        let docRef = db.collection("downloads").document("sandhiltmdb")
        docRef.updateData(["movies": FieldValue.arrayUnion([movie.toDictionary()])]) { error in
            self.showDownload = error != nil
        }
    }
    
}

extension Encodable {
    
    func toDictionary() -> [String:Any] {
        let jsonData = try! JSONEncoder().encode(self)
        return try! JSONSerialization.jsonObject(with: jsonData, options: []) as! [String: Any]
    }
    
}
