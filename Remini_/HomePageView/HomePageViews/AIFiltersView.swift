//
//  AIFiltersView.swift
//  Remini_
//
//  Created by Mac on 25/05/2024.
//

import SwiftUI
import Photos

struct AIFiltersView: View {
    var body: some View {
        ZStack {
            ZStack {
                AIFiltersLoadingView()
                
            }
        }
    }
}

struct AIFiltersView_Previews: PreviewProvider {
    static var previews: some View {
        AIFiltersView()
    }
}

struct AIFiltersLoadingView: View {
    @State var showImagePickerView = false
    @State var selectedImage: UIImage? = nil
    @State var showNewView = false
    @State var isLoading = false
    @State var rotatingAngle: Double = 0.0
    @State var trimAmount: Double = 0.1
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ZStack(alignment: .top) {
            Color.black
                .ignoresSafeArea()
            VStack(alignment: .center) {
            Button {
                print("btn tapped")
                showNewView.toggle()
                presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "xmark")
                    .font(.system(size: 20))
                    .tint(.red)
            }
            .fullScreenCover(isPresented: $showNewView) {
                HomePageView(selectedCellImage: UIImage(), uiImage: UIImage(), image: [PHAsset](), selectedImage: UIImage(), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
            }
        }
            .padding(.top, -350)
            .foregroundColor(.white)
            .offset(x: UIScreen.main.bounds.width / 2.5, y: UIScreen.main.bounds.height / 2.4)
            VStack {
                HStack {
                    Text("Generate\nYour Photos\n with AI")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(.white)
                        .lineSpacing(15)
                }
                .padding(.leading, -140)
                Spacer()
                    .frame(height: 40)
                VStack(spacing: 25) {
                    Image(systemName: "person.fill")
                        .frame(width: 120, height: 120)
                        .overlay(
                            RoundedRectangle(cornerRadius: 60)
                                .stroke(.white, lineWidth: 6)
                        )
                    Text("This is you")
                        .font(.system(size: 15, weight: .regular))
                        .foregroundColor(.white)
                }
                .padding(.leading, 250)
                Spacer()
                    .frame(height: 20)
                VStack {
                    Text("Your photos,\ngenerated with AI:")
                        .font(.system(size: 22, weight: .regular))
                        .foregroundColor(.gray)
                        .lineLimit(10)
                }
                .padding(.trailing, 250)
                Spacer()
                    .frame(height: 20)
                HStack {
                    Image(systemName: "person.fill")
                        .frame(width: UIScreen.main.bounds.width/2, height: 150)
                        .background(.red)
                        .cornerRadius(20)
                    Image(systemName: "person.fill")
                        .frame(width: UIScreen.main.bounds.width/2, height: 150)
                        .background(.red)
                        .cornerRadius(20)
                }
                Spacer()
                    .frame(height: 40)
                HStack {
                    Button {
                        print("btn tapped")
                        showImagePickerView.toggle()
                    } label: {
                        HStack(spacing: 30) {
                            Text("Upload Photo")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .fullScreenCover(isPresented: $showImagePickerView) {
                        AIFiltersImagePicker(selectedImage: $selectedImage)
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

struct AIFiltersImagePicker: UIViewControllerRepresentable {
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
