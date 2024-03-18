//
//  MovieItem.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieCarousalItem: View {
    var movie: Movie
    
    var body: some View {
        
        NavigationLink {
            MoviePreview(movie: movie)
        } label: {
            AnimatedImage(url: movie.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
                .listRowInsets(EdgeInsets())
        }
        
        
        
    }
}
