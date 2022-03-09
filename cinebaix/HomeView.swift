//
//  ContentView.swift
//  cinebaix
//
//  Created by Alex on 30/10/21.
//

import SwiftUI


struct HomeView: View {
    @State var cardShown = false
    @State var cardDismissal = false
    @StateObject var viewModel = CinebaixViewModel()
    let columns = [ GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
        ZStack {
            if viewModel.loading {
                HStack(spacing: 15) {
                    ProgressView("Carregant dades...")
                }
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 0) {

                        ForEach(viewModel.movies, id: \.self) { movie in

                            CinebaixAsyncImage(image: movie.img)
                                .onTapGesture {
                                    cardShown.toggle()
                                    cardDismissal.toggle()

                                    viewModel.selectedMovie = movie
                                }
                        }
                    }
                }

                CinebaixBottomCardView(image: viewModel.selectedMovie?.img ?? "",
                                       height: UIScreen.main.bounds.height / 1.5,
                                       cardShown: $cardShown,
                                       cardDismissal: $cardDismissal) {

                    CardContentView(selectedMovie: viewModel.selectedMovie ?? nil).padding()

                }.animation(.default)
            }
        }.onAppear(perform: { viewModel.getMovies() })
    }
}
