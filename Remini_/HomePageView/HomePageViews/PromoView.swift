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
                HomePageView(selectedCellImage: UIImage(), uiImage: UIImage(), image: [PHAsset()], selectedImage: UIImage(), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
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
