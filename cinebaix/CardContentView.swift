//
//  CardContentView.swift
//  cinebaix
//
//  Created by Alex Hernandez Velasco on 9/3/22.
//

import SwiftUI

struct CardContentView: View {
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

    func getTime(minutes: Int) {

//        let components = Calendar.current.dateComponents([.hour, .minute], from: someDate)
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
    }
}
