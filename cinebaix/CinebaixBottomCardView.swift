//
//  CinebaixBottomCardView.swift
//  cinebaix
//
//  Created by Alex Hernandez Velasco on 20/11/21.
//

import SwiftUI

struct CinebaixBottomCardView<Content: View>: View {
    @Binding var cardShown: Bool
    @Binding var cardDismissal: Bool
    let content: Content
    let height: CGFloat
    let image: String
    
    init(image: String,
         height: CGFloat,
         cardShown: Binding<Bool>,
         cardDismissal: Binding<Bool>,
         @ViewBuilder content: () -> Content) {

        self.image = image
        self.height = height
        _cardShown = cardShown
        _cardDismissal = cardDismissal
        self.content = content()

    }

    func dismiss() {
        cardDismissal.toggle()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            cardShown.toggle()
        }
    }

    var body: some View {
        ZStack {
            GeometryReader { _ in
                EmptyView()
            }
            .background(Color.gray.opacity(0.5))
            .opacity(cardShown ? 1 : 0)
            .onTapGesture {
                dismiss()
            }

            VStack {

                Spacer()

                VStack {
                    HStack {
                        Spacer()
                        Button {
                            dismiss()
                        } label: {
                            CloseButton()
                        }

                    }

                    Spacer()

                    content

                    Spacer()
                }
                .frame(height: height)
                .background(.white.opacity(0.8))
                .offset(y: cardDismissal && cardShown ? 0 : height)
                .animation(.default)

            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}
