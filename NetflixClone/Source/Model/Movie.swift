//
//  SwiftUIView.swift
//  NetflixClone
//
//  Created by sandhil eldhose on 2/29/24.
//

import SwiftUI

struct Movie: Identifiable, Codable {
    var id: Int
    var original_title: String?
    var poster_path: String?
    
    var image: URL? {
        let baseURLString = (Constants.baseURLImage?.absoluteString ?? "") + (poster_path ?? "")
        return URL(string: baseURLString)
    }
    
    
}
