//
//  PromoView.swift
//  Remini_
//
//  Created by Mac on 28/05/2024.
//

import SwiftUI
import Photos

struct PromoView: View {
    @State var showNewView = false
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack(alignment: .leading) {
            Button {
                print("btn tapped")
                presentationMode.wrappedValue.dismiss()
                showNewView.toggle()
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 20, height: 20)
                    .tint(.black)
            }
            .fullScreenCover(isPresented: $showNewView) {
HomePageView(imageData: Data(), selectedCellImage: UIImage(), uiImage: UIImage(), images: [PHAsset](), selectedImage: UIImage(), selectedCellData: AppDataModel(image: "", text1: "", text2: "", buttonImage1: "", buttonImage2: "", buttonAction: {}), selected1: UIImage(), selected2: UIImage(), cellsImage: UIImage())
            }
            Spacer()
                .frame(width: UIScreen.main.bounds.width/1.1)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.white)
    }
}

struct PromoView_Previews: PreviewProvider {
    static var previews: some View {
        PromoView()
    }
}
