//
//  SecondImageView.swift
//  Remini_
//
//  Created by Mac on 23/05/2024.
//

import SwiftUI

struct SecondImageView: View {
    @State var isPresentedView = false
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Button {
                print("btn tapped")
            } label: {
                Image(systemName: "arrow.left.and.right")
                    .frame(width: 50, height: 50)
                    .background(.white)
                    .cornerRadius(25)
                    .tint(.black)
            }
            .padding(.bottom, 40)
            HStack(spacing: 30) {
                Text("Transform into \n a video game")
                //.scaledFont(name: "", size: 24)
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
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
        .ignoresSafeArea()
    }
}

struct SecondImageView_Previews: PreviewProvider {
    static var previews: some View {
        SecondImageView()
    }
}
