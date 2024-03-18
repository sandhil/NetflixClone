//
//  MovieRow.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI

struct HorizontalMovieCollection: View {
    
    var categoryName: String
    var items: [Movie]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(categoryName)
                .font(.headline)
                .padding(.leading, 15)
                .padding(.top, 5)
            
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack(alignment: .top, spacing: 0) {
                    ForEach(items) { movie in
                        NavigationLink {
                            MoviePreview(movie: movie)
                        } label: {
                            HorizontalMovieCollectionItem(movie: movie)
                        }
                    }
                }
            }
            .frame(height: 185)
        }
    }
}

#Preview {
    HorizontalMovieCollection(categoryName: "String", items: [])
}
