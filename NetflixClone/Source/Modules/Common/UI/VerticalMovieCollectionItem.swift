//
//  VerticalMovieCollectionItem.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 3/5/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct VerticalMovieCollectionItem: View {
    var movie: Movie
    @ScaledMetric var maxHeight = 80
    @ScaledMetric var maxWidth = 70
    
    var body: some View {
        HStack(alignment: .center) {
            AnimatedImage(url: movie.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: maxWidth, maxHeight: maxHeight)
                .clipped()
            Text(movie.original_title ?? "")
                .foregroundStyle(.primary)
                .font(.caption)
            Spacer()
            Image(systemName: "play.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
                .foregroundColor(Color("ForegroundColor"))
                .padding(.trailing, 16)
            
        }
    }
}

#Preview {
    VerticalMovieCollectionItem(movie: Movie(id: 0, original_title: "Spaceman is the master of the universe", poster_path: "https://image.tmdb.org/t/p/w500//5hnFFOWEchErNVr0wMLWFEob3q1.jpg"))
}
