//
//  MovieItem.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct HorizontalMovieCollectionItem: View {
    var movie: Movie
    @ScaledMetric var maxWidth = 155
    
    var body: some View {
        VStack(alignment: .leading) {
            AnimatedImage(url: movie.image)
                .frame(width: maxWidth, height: 155)
                .cornerRadius(5)
            Text(movie.original_title ?? "")
                .foregroundStyle(.primary)
                .font(.caption)
                .frame(maxWidth: maxWidth)
        }
        .padding(.leading, 15)
    }
}
