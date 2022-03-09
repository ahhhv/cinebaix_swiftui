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

                CinebaixBottomCardView(height: UIScreen.main.bounds.height / 2,
                                       cardShown: $cardShown,
                                       cardDismissal: $cardDismissal) {

                    CardContent(selectedMovie: viewModel.selectedMovie ?? nil).padding()

                }.animation(.default)
            }
        }.onAppear(perform: { viewModel.getMovies() })
    }
}

    struct CardContent: View {
        var selectedMovie: Movie?
        var Classification: [String: String] = [
            "DOC":"Doblada en català",
            "DOE":"Doblada en espanyol",
            "VOC":"Versió original en català",
            "VOE":"Versió original en espanyol",
            "VOSC":"Versió original subtitulada en català",
            "VOSE":"Versió original subtitulada en espanyol",
            "VOSA":"Versió original subtitulada en anglès"
        ]

        var body: some View {
            ZStack {
                ScrollView {
                    VStack {

                        Text("\(selectedMovie?.title ?? "")")
                            .bold()
                            .font(.title)
                            .lineLimit(.none)


                        Text("\(Classification[selectedMovie?.classification ?? ""] ?? "N/A")")
                            .font(.title3)
                            .italic()
                        Text("Durada: \(selectedMovie?.duration ?? "") minuts")
                        Text("Classificació: \(selectedMovie?.rating ?? "N/A")")
                            .padding(.bottom, 10)

                        Spacer()

                        ForEach(selectedMovie?.schedule ?? [], id: \.day) { day in
                            Text(day.day)
                                .bold()
                            let rooms = day.rooms.sorted(by: {$0.room < $1.room})
                            ForEach(rooms, id: \.time) { room in
                                HStack { Text("\(room.room) - \(room.time)") }
                            }

                            Spacer()
                        }

                        Spacer()
                    }
                }
            }
        }
    }

    struct CloseButton: View {
        var body: some View {
            Image(systemName: "xmark")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.white)
                .padding(.all, 5)
                .background(Color.black.opacity(0.6))
                .clipShape(Circle())
                .padding()
        }
    }

    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            HomeView()
        }
    }


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
