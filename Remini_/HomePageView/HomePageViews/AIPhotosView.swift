//
//  AIPhotosView.swift
//  Remini_
//
//  Created by Mac on 25/05/2024.
//

import SwiftUI
import UIKit
import Photos
import PhotosUI

struct AIPhotosLoadingView: View {
    @State var showLoadingView = false
    @State var selectedImages: [Image]
    @State var showNextScreen = false
    @State var selectedCount: Int
    @State var showImagePickerView = false
    @State var selectedImage: UIImage? = nil
    @State var showNewView = false
    @State var isLoading = false
    @State var rotatingAngle: Double = 0.0
    @State var trimAmount: Double = 0.1
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        VStack {
            if showLoadingView && selectedImages.count > 0 {
                AITransformationLoadingView(    isActive: true)
                    .opacity(0.3)
            } else {
                ZStack(alignment: .top) {
                    Rectangle()
                        .fill(Color.black)
                        .frame(height: UIScreen.main.bounds.height)
                        .blur(radius: 10)
                    Image("backimage")
                        .scaledToFit()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: UIScreen.main.bounds.height/2)
                    VStack(alignment: .center) {
                        Button {
                            showNewView.toggle()
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "xmark")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .fullScreenCover(isPresented: $showNewView) {
HomePageView(imageData: Data(), selectedCellImage: UIImage(), uiImage: UIImage(), images: [PHAsset](), selectedImage: UIImage(), selectedCellData: AppDataModel(image: "", text1: "", text2: "", buttonImage1: "", buttonImage2: "", buttonAction: {}), selected1: UIImage(), selected2: UIImage(), cellsImage: UIImage())
                        }
                    }
                    .padding(.top, 400)
                    .foregroundColor(.white)
                    .offset(x: UIScreen.main.bounds.width / -2.5, y: UIScreen.main.bounds.height / -2.4)
                    VStack(alignment: .center, spacing: 30) {
                        Spacer()
                        Text("Revamp reality with\n AI Filters")
                            .font(.system(size: 35, weight: .bold))
                            .foregroundColor(.white)
                        HStack {
                            Text("Transform your selfies through the magic of AI")
                                .font(.system(size: 15, weight: .regular))
                                .foregroundColor(.white)
                            Image(systemName: "carrot.fill")
                                .font(.system(size: 15))
                                .foregroundColor(.yellow)
                        }
                        HStack {
                            Button {
                                showImagePickerView.toggle()
                            } label: {
                                HStack(spacing: 30) {
                                    Text("Upload Photo")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                    Image(systemName: "camera")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }
                            }
                            .fullScreenCover(isPresented: $showImagePickerView) {
            AIPhotosImagePicker(selectedImage: $selectedImage, selectedImages: $selectedImages, showNextScreen: $showNextScreen)
                            }
                            .frame(width: UIScreen.main.bounds.width - 100, height: 60)
                            .background(.white)
                            .cornerRadius(30)
                        }
                        .padding(.bottom, 50)
                    }
                    if isLoading {
                        ZStack {
                            Color.black
                                .ignoresSafeArea()
                            Circle()
                                .trim(from: trimAmount, to: 1)
                                .stroke(
                                    Color.white,
                                    style:
                                        StrokeStyle(lineWidth: 5, lineCap:
                                                .round, lineJoin:
                                                .round, miterLimit:
                                                .infinity, dashPhase: 0))
                                .frame(width: 20, height: 20)
                                .rotationEffect(.degrees(rotatingAngle))
                                .animation(.linear(duration: 1.5).repeatForever(), value: rotatingAngle)
                        }
                    } else {
                        
                    }
                }
                .onAppear() {
                    if selectedImages.count > 0 {
                        startLoading()
                    }
                }
                .onChange(of: showNextScreen) { newValue in
                    print("hi")
                    if newValue {
                        showNextScreen = true
                    }
                }
                .onDisappear {
                    
                }
            }
        }
    }
        func startLoading() {
            isLoading = true
            withAnimation(.linear(duration: 1.5).repeatForever()) {
                self.rotatingAngle = 360.0
            }
            rotatingAngle = 360.0
            trimAmount = 0.4
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    isLoading = false
                }
            }
        }
    }
struct AIPhotosLoadingView_Previews: PreviewProvider {
        static var previews: some View {
            AIPhotosLoadingView(selectedImages: [Image(systemName: "")], selectedCount: Int())
        }
    }
struct AIPhotosImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Binding var selectedImages: [Image]
    @Binding var showNextScreen: Bool
    
    func makeUIViewController(context: Context) ->  PHPickerViewController {
        var config = PHPickerConfiguration()
        config.selectionLimit = 0
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selectedImage: $selectedImage, selectedImages: $selectedImages, showNextScreen: $showNextScreen)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        @Binding var selectedImage: UIImage?
        @Binding var selectedImages: [Image]
        @Binding var showNextScreen: Bool
        
        init(selectedImage: Binding<UIImage?>, selectedImages: Binding<[Image]>, showNextScreen: Binding<Bool>) {
            self._selectedImage = selectedImage
            self._selectedImages = selectedImages
            self._showNextScreen = showNextScreen
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            for result in results {
                if result.itemProvider.canLoadObject(ofClass: UIImage.self) {
                    result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                        if let error = error {
                            print("Error loading image: \(error.localizedDescription)")
                        } else if let image = image as? UIImage {
                            self?.selectedImage = image
                            self?.selectedImages.append(Image(uiImage: image))
                            if self?.selectedImages.count ?? 1 > 0 {
                                self?.showNextScreen = false
                            }
                        }
                    }
                }
            }
        }
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
    }
}

struct AITransformationLoadingView: View {
    @State var isPresentedView = false
    @State var isActive: Bool
    @State var rotatingAngle: Double = 0.0
    @State var trimAmount: Double = 0.1
    var body: some View {
        VStack {
            Circle()
                .trim(from: trimAmount, to: 1)
                .stroke(
                    Color.white,
                    style:
                        StrokeStyle(lineWidth: 5, lineCap:
                                .round, lineJoin:
                                .round, miterLimit:
                                .infinity, dashPhase: 0))
                .frame(width: 20, height: 20)
                .rotationEffect(.degrees(rotatingAngle))
                .animation(.linear(duration: 1.5).repeatForever(), value: rotatingAngle)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        .ignoresSafeArea()
        .onAppear{
            self.rotatingAngle = 360.0
            self.trimAmount = 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                withAnimation {
                    self.isActive = true
                    isPresentedView.toggle()
                }
            }
        }
        .background(.white)
        .ignoresSafeArea()
    }
}
