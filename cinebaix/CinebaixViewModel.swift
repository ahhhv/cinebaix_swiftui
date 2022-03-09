//
//  CinebaixViewModel.swift
//  cinebaix
//
//  Created by Alex on 30/10/21.
//

import SwiftUI

final class CinebaixViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var loading = false
    @Published var selectedMovie: Movie?

    func getMovies() {
        self.loading = true
        NetworkManager.shared.getMovies { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movies):
                    self.movies = movies
                    self.loading = false

                case .failure(let err):
                    print("MUEEEEEEC", err)
                    break
                }
            }
        }
    }
}
