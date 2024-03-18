//
//  Downloads.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI

struct Downloads: View {
    @StateObject var viewModel = DownloadsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.movies) { movie in
                    NavigationLink {
                        MoviePreview(movie: movie)
                    } label: {
                        VerticalMovieCollectionItem(movie: movie)
                    }
                }.onDelete(perform: delete(at:))
            }
            .listStyle(.plain)
            .edgesIgnoringSafeArea(.bottom)
        }.onAppear {
            viewModel.getDownloadedMovies()
        }
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let movie = viewModel.movies[index]
            viewModel.delete(movie: movie)
            viewModel.movies.remove(at: index)
        }
        
    }
}

#Preview {
    Downloads()
}
