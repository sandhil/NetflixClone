//
//  MoviePreview.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 3/6/24.
//

import SwiftUI
import AVKit
import WebKit

struct MoviePreview: View {
    @StateObject var viewModel = MoviePreviewViewModel()
    var movie: Movie?
    
    init(movie: Movie? = nil) {
        self.movie = movie
//
    }
    
    var body: some View {
        VStack {
            if viewModel.youtubeItem?.videoId != nil {
                Text(movie?.original_title ?? "")
                    .font(.title)
                    .foregroundStyle(.primary)
                    .padding()
                YouTubeVideoView(videoID: viewModel.youtubeItem?.videoId ?? "")
                    .frame(height: 400)
                if viewModel.showDownload {
                    HomeButton(title: "Download") {
                        viewModel.downloadMovie()
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            viewModel.movie = movie
            viewModel.getMovie()
            viewModel.checkDownloadStatus()
        }
    }
}

struct YouTubeVideoView: UIViewRepresentable {
    var videoID: String
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        let path = "https://www.youtube.com/embed/\(videoID)"
        guard let url = URL(string: path) else { return webView }
        webView.load(.init(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Handle potential updates to the video ID here
    }
}

#Preview {
    MoviePreview(movie:  Movie(id: 0, original_title: "Spaceman is the master of the universe", poster_path: "https://image.tmdb.org/t/p/w500//5hnFFOWEchErNVr0wMLWFEob3q1.jpg"))
}
