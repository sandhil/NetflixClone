//
//  Search.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI

struct Search: View {
    @StateObject var viewModel = SearchViewModel()
    
    @State var query: String = ""
    
    let names: [String] = []
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                LazyVStack(spacing: 8){
                    ForEach(viewModel.searchResults) { movie in
                        NavigationLink {
                            MoviePreview(movie: movie)
                        } label: {
                            VerticalMovieCollectionItem(movie: movie)
                                .padding(4)
                        }
                        Spacer(minLength: 4)
                    }
                }
                if viewModel.searchResults.isEmpty, !viewModel.query.isEmpty {
                    ContentUnavailableView {
                        Label("No Movies for \"\(viewModel.query)\"", systemImage: "movieclapper")
                    } description: {
                        Text("Try to search for another title.")
                    }
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationTitle("Search")
        }
        .foregroundColor(Color("ForegroundColor"))
        .searchable(text: $query)
        .onChange(of: query) {
            viewModel.query = query
            viewModel.searchMovies()
            
        }
        .onAppear {
            UISearchBar.appearance().tintColor = UIColor(named: "ForegroundColor")
        }
        
    }
    
}

#Preview {
    Search()
}
