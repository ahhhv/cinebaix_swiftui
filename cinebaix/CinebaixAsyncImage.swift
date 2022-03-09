//
//  CinebaixAsyncImage.swift
//  cinebaix
//
//  Created by Alex Hernandez Velasco on 9/3/22.
//

import SwiftUI

struct CinebaixAsyncImage: View {
    let image: String

    var body: some View {

        AsyncImage(url: URL(string: image)) { img in
            switch img {
            case .empty:
                VStack {
                    ProgressView()
                    Image(systemName: "photo")
                        .renderingMode(.original)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.white)
                        .clipShape(Circle())
                    Text("Carregant...")
                }
            case .success(let image):
                image.resizable()
                    .aspectRatio(contentMode: .fill)
                    .edgesIgnoringSafeArea(.all)
            case .failure:
                VStack {
                    CinebaixAsyncImage(image: image)
                }.foregroundColor(Color(UIColor.systemPink))
            @unknown default:
                EmptyView()
            }
        }
    }
}
