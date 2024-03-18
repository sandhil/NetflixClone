//
//  Home.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct Home: View {
    @StateObject var viewModel = HomeViewModel()
    @ScaledMetric var bannerHeight = 300
    @State private var selection = 0
    @State private var timer: Timer?
    
    var categories = Category.all
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .bottom) {
                    TabView (selection: $selection) {
                        ForEach(viewModel.getMovies(for: .popularMovie)) { movie in
                            MovieCarousalItem(movie: movie)
                                .tag(getIndex(for: movie))
                        }
                    }
                    .tabViewStyle(PageTabViewStyle())
                    .onAppear {
                        timer = Timer.scheduledTimer(withTimeInterval: 4.0, repeats: true) { _ in
                            withAnimation {
                                selection = (selection + 1) % viewModel.getMovies(for: .popularMovie).count
                            }
                        }
                    }
                    .onDisappear {
                        timer?.invalidate()
                        timer = nil
                    }
                }.frame(height: bannerHeight)
                LazyVStack(alignment: .leading, spacing: 0) {
                    ForEach(categories, id: \.self) { category in
                        HorizontalMovieCollection(categoryName: category.rawValue, items: viewModel.getMovies(for: category))
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                    }) {
                        Image("netflix")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 30, height: 30)
                            .padding(4)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationButton(image: "play.rectangle") {
                        
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button("Logout", action: viewModel.logout)
                    } label: {
                        Image(systemName: "person")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(4)
                            .foregroundColor(Color("ForegroundColor"))
                    }
                }
            }
            
        }
    }
    
    func getIndex(for movie: Movie) -> Int {
        let index = viewModel.getMovies(for: .popularMovie).firstIndex {$0.id == movie.id}
        return index ?? 0
    }
}

enum Category: String {
    case trendingMovie = "Trending Movies"
    case trendingTv = "Trending TV"
    case popularMovie = "Popular movies"
    case upComingMovie = "Upcoming movies"
    case topRatedMovie = "Top Rated"
    case popularTv = "Popular TV"
    
    static var all: [Category] {
        return [.trendingMovie, .trendingTv, .popularMovie, .popularTv, .topRatedMovie]
    }
}


struct HomeButton: View {
    var title: String
    let action: () -> Void
    var body: some View {
        Button(title, action: action)
            .frame(minWidth: 80)
            .padding(8)
            .border(Color("ForegroundColor"))
            .fixedSize(horizontal: true, vertical: false)
            .foregroundColor(Color("ForegroundColor"))
    }
}

struct NavigationButton: View {
    var image: String
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(4)
                .foregroundColor(Color("ForegroundColor"))
        }
    }
}

#Preview {
    Home()
}

