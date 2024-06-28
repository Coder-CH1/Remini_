//
//  TransformedImageView.swift
//  Remini_
//
//  Created by Mac on 17/06/2024.
//

import SwiftUI
import CoreImage
import UIKit

struct TransformedImageView: View {
    @Binding var selectedImages: [UIImage]
    @State var filteredImages: [UIImage] = []
    func processImages() -> [UIImage] {
        var processedImages: [UIImage] = []
        for image in selectedImages {
            if let processedImage = OpenCVWrapper.processImage(image) {
                processedImages.append(processedImage)
            }
        }
        return processedImages
    }
    var body: some View {
        VStack {
            HStack {
                Text("AI Transformed images")
                    .font(.system(size: 30, weight: .black))
                    .foregroundColor(.white)
            }
            Spacer()
                .frame(height: 300)
            HStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 30) {
                        ForEach(selectedImages, id: \.self) { index in
                            Image(uiImage: index)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width/2, height: 400)
                                .background(.white)
                                .cornerRadius(10)
                        }
                    }
                }
                .onAppear() {
                    self.filteredImages = processImages()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.black).ignoresSafeArea()
    }
}

struct TransformedImageView_Previews: PreviewProvider {
    static var previews: some View {
        TransformedImageView(selectedImages: .constant([UIImage()]))
    }
}
