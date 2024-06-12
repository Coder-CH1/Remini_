//
//  SecondImageView.swift
//  Remini_
//
//  Created by Mac on 23/05/2024.
//

import SwiftUI

struct SecondImageView: View {
    @State var isPresentedView = false
    @State var offset: CGFloat = 0
    @State var dragging = false
    var body: some View {
        ZStack {
            GeometryReader { g in
                ZStack {
                    VStack(alignment: .center) {
                        Button {
                            dragging = true
                        } label: {
                            Image(systemName: "arrow.left.and.right")
                                .frame(width: 50, height: 50)
                                .background(.white)
                                .cornerRadius(25)
                                .tint(.black)
                        }
                    }
                    .padding(.leading, UIScreen.main.bounds.width/2)
                }
                .frame(width: g.size.width/2,height: g.size.height)
                .background(.white.opacity(0.2))
                .offset(x: offset, y: 0)
                .gesture(DragGesture() .onChanged { gesture in
                        offset = gesture.translation.width
                }
                    .onEnded { _ in
                        offset = 0
                    })
            }
            VStack {
                Spacer()
                HStack(spacing: 30) {
                        Text("Transform into \n a video game")
                            .font(.system(size: 34, weight: .black))
                            .foregroundColor(.white)
                        Button {
                            print("btn tapped")
                            isPresentedView.toggle()
                        } label: {
                            Image(systemName: "chevron.right")
                                .frame(width: 80, height: 70)
                                .background(.white)
                                .cornerRadius(40)
                                .tint(.black)
                        }
                    }
                    .fullScreenCover(isPresented: $isPresentedView) {
                        ThirdImageView()
                    }
                    .padding(.bottom, 80)
            }
        }
        .background(
        Image("img6")
            .resizable()
            .aspectRatio(contentMode: .fill)
        .ignoresSafeArea())
    }
}
struct SecondImageView_Previews: PreviewProvider {
    static var previews: some View {
        SecondImageView()
    }
}
