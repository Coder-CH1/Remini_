//
//  AIPhotosView.swift
//  Remini_
//
//  Created by Mac on 25/05/2024.
//

import SwiftUI

struct AIPhotosView: View {
    var body: some View {
        VStack(alignment: .leading) {
            
        }
    }
    
    struct AIPhotosView_Previews: PreviewProvider {
        static var previews: some View {
            AIPhotosView()
        }
    }
    
    struct AIPhotosLoadingView: View {
        @State var showImagePickerView = false
        @State var selectedImage: UIImage? = nil
        @State var showNewView = false
        @State var isLoading = false
        @State var rotatingAngle: Double = 0.0
        @State var trimAmount: Double = 0.1
        @Environment(\.presentationMode) var presentationMode
        var body: some View {
            ZStack(alignment: .top) {
                Rectangle()
                    .fill(Color.black)
                    .frame(height: UIScreen.main.bounds.height)
                    .blur(radius: 10)
                Image("backimage")
                //.resizable()
                    .scaledToFit()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: UIScreen.main.bounds.height/2)
                
                Button {
                    print("btn tapped")
                    showNewView.toggle()
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .frame(width: 20, height: 20)
                        .tint(.white)
                }
                .fullScreenCover(isPresented: $showNewView) {
                    HomePageView()
                }
                .foregroundColor(.white)
                .offset(x: UIScreen.main.bounds.width / -2.5, y: UIScreen.main.bounds.height / -2.4)
                VStack(alignment: .center, spacing: 30) {
                    Spacer()
                        .frame(height: 530)
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
                            print("btn tapped")
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
                            AIPhotosImagePicker(selectedImage: $selectedImage)
                        }
                        .frame(width: UIScreen.main.bounds.width - 100, height: 60)
                        .background(.white)
                        .cornerRadius(30)
                    }
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
                startLoading()
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
}
    struct AIPhotosImagePicker: UIViewControllerRepresentable {
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            @Binding var selectedImage: UIImage?
            init(selectedImage: Binding<UIImage?>) {
                self._selectedImage = selectedImage
            }
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                guard let image = info[.originalImage] as? UIImage else {return}
                selectedImage = image
                picker.dismiss(animated: true)
            }
        }
        @Binding var selectedImage: UIImage?
        
        func makeCoordinator() -> Coordinator {
            Coordinator(selectedImage: $selectedImage)
        }
         
        func makeUIViewController(context: Context) ->  UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
            
        }
    }
