//
//  FirstImageView.swift
//  Remini_
//
//  Created by Mac on 23/05/2024.
//

import SwiftUI

struct FirstImageView: View {
    @State var isPresentedView = false
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Text("Move the slider!")
                .frame(width: 200, height: 60)
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(.black)
                .background(.white)
                .cornerRadius(30)
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
                Text("Restore your \n old photos")
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
                SecondImageView()
            }
            .padding(.bottom, 80)
        }
        .background(
        Image("img1")
            .resizable()
            .aspectRatio(contentMode: .fill)
        .ignoresSafeArea())
    }
}

struct FirstImageView_Previews: PreviewProvider {
    static var previews: some View {
        FirstImageView()
    }
}
