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

class SearchViewModel: ObservableObject {
    @Published var searchResults:[Movie] = []
    var query: String = "" {
        didSet {
            searchMovies()
        }
    }
    
    let backendClient: BackendClient!
    let disposeBag = DisposeBag()
    
    init() {
        backendClient = Container.sharedContainer.resolve(BackendClient.self)
    }
    
    func searchMovies() {
        searchMoviesInBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.searchResults = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    private func searchMoviesInBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .search, parameters: ["api_key": Constants.apiKey, "query": query], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
}
