//
//  SettingsView.swift
//  Remini_
//
//  Created by Mac on 24/05/2024.
//

import SwiftUI
import Photos

struct SettingsView: View {
    @State var showNewView = false
    @Environment(\.presentationMode) var presentationMode
    let columns = [
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Button {
                    print("btn tapped")
                    presentationMode.wrappedValue.dismiss()
                    showNewView.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 20, height: 20)
                        .tint(.white)
                }
                .fullScreenCover(isPresented: $showNewView) {
HomePageView(imageData: Data(), selectedCellImage: UIImage(), uiImage: UIImage(), images: [PHAsset](), selectedImage: UIImage(), selectedCellData: AppDataModel(image: "", text1: "", text2: "", buttonImage1: "", buttonImage2: "", buttonAction: {}), selected1: UIImage(), selected2: UIImage(), cellsImage: UIImage())
                }
            }
            .padding(.leading)
            Section(header: HStack {  Text("Settings").font(.system(size: 24, weight: .bold)).foregroundColor(.white)}.padding(.leading)) {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<12) { index in
                            SettingsCellView()
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top)
    }
    .padding(.bottom)
    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
    
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

struct SettingsCellView: View{
    var body: some View {
        VStack {
            Image(systemName: "")
                .frame(width: UIScreen.main.bounds.width/1.1, height: 150)
                .background(.red)
                .cornerRadius(20)
        }
    }
}
