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

class UpComingViewModel: ObservableObject {
    @Published var upComingMovies:[Movie] = []
    
    let backendClient: BackendClient!
    let disposeBag = DisposeBag()
    
    init() {
        backendClient = Container.sharedContainer.resolve(BackendClient.self)
        getUpComingMovies()
    }
    
    
    private func getUpComingMovies() {
        getUpComingMoviesFromBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.upComingMovies = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    
    
    private func getUpComingMoviesFromBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .upComingMovies, parameters: ["api_key": Constants.apiKey], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
}
