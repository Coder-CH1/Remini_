//
//  ExploreView.swift
//  Remini_
//
//  Created by Mac on 25/05/2024.
//

import SwiftUI
import Photos

struct ExploreView: View {
    @State var showNewView = false
    let columns = [GridItem(.flexible(), spacing: 10)]
    var body: some View {
        VStack {
            HStack() {
                HStack {
                    Button(action: {
                        print("btn tapped")
                        showNewView.toggle()
                    }) {
                        Image(systemName: "chevron.down")
                            .font(.system(size: 30, weight: .semibold))
                            .foregroundColor(.white)
                        
                    }
                }
                .padding(.horizontal, -80)
                .fullScreenCover(isPresented: $showNewView) {
                    HomePageView(uiImage: UIImage(), image: [PHAsset](), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
                }
                Text("Explore All Features")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(.white)
            }
            ScrollView {
                LazyVGrid(columns: columns, alignment: .leading, spacing: 20) {
                    ForEach(0..<10) { _ in
                        ExploreCellView()
                    }
                }
                .padding(.top, 30)
                .background(Color(red: 0.2, green: 0.1, blue: 0.1))
                .cornerRadius(30)
            }
            .scrollIndicators(.hidden)
            .padding(.vertical, 10)
        }
        .background(.black)
    }
}

struct ExploreView_Previews: PreviewProvider {
    static var previews: some View {
        ExploreView()
    }
}

struct ExploreCellView: View {
    @State var showImagePickerView = false
    @State var selectedImage: UIImage? = nil
    @State var isTapped: Bool = false
    let screenSize = UIScreen.main.bounds.size
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 90, height: 90)
                    .background(.red)
                    .cornerRadius(45)
                Text("Random text")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                Button(action: {
                    print("btn tapped")
                    showImagePickerView.toggle()
                }) {
                    Image(systemName: "chevron.right")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
            }
            .padding(.trailing, 20)
            .fullScreenCover(isPresented: $showImagePickerView) {
                ExploreImagePicker(selectedImage: $selectedImage)
            }
            .frame(width: screenSize.width, height: UIScreen.main.bounds.height/8)
            .background(.secondary)
            .cornerRadius(30)
        }
    }
}

struct ExploreImagePicker: UIViewControllerRepresentable {
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
