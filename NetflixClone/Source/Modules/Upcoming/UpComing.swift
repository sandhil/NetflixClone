//
//  ComingSoon.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI

struct UpComing: View {
    @StateObject var viewModel = UpComingViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.upComingMovies) { movie in
                    NavigationLink {
                        MoviePreview(movie: movie)
                    } label: {
                        VerticalMovieCollectionItem(movie: movie)
                            .listRowInsets(EdgeInsets())
                            .padding(.bottom, 8)
                    }.buttonStyle(.plain)
                    
                }
            }.listStyle(.plain)
                .edgesIgnoringSafeArea(.bottom)
        }
    }
}

#Preview {
    UpComing()
}
