//
//  TransformedImageView.swift
//  Remini_
//
//  Created by Mac on 17/06/2024.
//

import SwiftUI
import CoreImage

struct TransformedImageView: View {
    @State var selectedImages: [UIImage] = []
    @State var filteredImages: [UIImage] = []
    func applyFilter(to image: UIImage) -> UIImage {
        let ciImage = CIImage(image: image)!
        let filter = CIFilter(name: "CIPhotoEffect")
        filter?.setValue(ciImage, forKey: kCIInputImageKey)
        let outputImage = filter?.outputImage ?? UIImage()
        let uiImage = UIImage(ciImage: outputImage as! CIImage)
        return uiImage
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
                        ForEach(0..<10) { index in
                            Image(systemName: "person.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: UIScreen.main.bounds.width/2, height: 400)
                                .background(.white)
                                .cornerRadius(10)
                        }
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(.black).ignoresSafeArea()
    }
}

struct TransformedImageView_Previews: PreviewProvider {
    static var previews: some View {
        TransformedImageView()
    }
}
