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

class HomeViewModel: ObservableObject {
    @Published var trendingMovies:[Movie] = []
    @Published var trendingTv:[Movie] = []
    @Published var popularMovies:[Movie] = []
    @Published var topRatedMovies:[Movie] = []
    @Published var upComingMovies:[Movie] = []
    @Published var popularTV:[Movie] = []
    @AppStorage("isLoggedIn") var isLoggedIn = false
    
    let backendClient: BackendClient!
    let disposeBag = DisposeBag()
    
    init() {
        backendClient = Container.sharedContainer.resolve(BackendClient.self)
        getTrendingMovies()
        getTrendingTv()
        getPopularTV()
        getPopularMovies()
        getTopRatedMovies()
    }
    
    
    private func getTrendingMovies() {
        getTrendingMoviesFromBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.trendingMovies = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func getTrendingTv() {
        getTrendingTvFromBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.trendingTv = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func getPopularTV() {
        getPopularTvFromBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.popularTV = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func getPopularMovies() {
        getPopularMoviesFromBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.popularMovies = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    private func getTopRatedMovies() {
        getTopRatedMoviesFromBackend()
            .subscribe(onSuccess: { [weak self] dataList in
                self?.topRatedMovies = dataList
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: disposeBag)
    }
    
    
    private func getTrendingMoviesFromBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .trendingMovies, parameters: ["api_key": Constants.apiKey], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
    private func getTrendingTvFromBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .trendingTv, parameters: ["api_key": Constants.apiKey], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
    private func getPopularMoviesFromBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .popularMovies, parameters: ["api_key": Constants.apiKey], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
    private func getPopularTvFromBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .popularTv, parameters: ["api_key": Constants.apiKey], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
    private func getTopRatedMoviesFromBackend() -> Single<[Movie]> {
        let apiRequest: ApiRequest = ApiRequest(method: .get, endPoint: .topRatedMovies, parameters: ["api_key": Constants.apiKey], encoding: URLEncoding.queryString)
        return backendClient.load(request: apiRequest)
    }
    
    func getMovies(for category: Category) -> [Movie] {
        switch category {
        case .trendingMovie : return trendingMovies
        case .trendingTv: return trendingTv
        case .popularMovie:  return popularMovies
        case .popularTv: return popularTV
        case .topRatedMovie: return topRatedMovies
        case .upComingMovie: return upComingMovies
        }
    }
    
    
    func logout () {
        isLoggedIn = false
    }
    
    
    
}
