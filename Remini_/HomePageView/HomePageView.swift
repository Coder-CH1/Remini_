//
//  HomePageView.swift
//  Remini_
//
//  Created by Mac on 24/05/2024.
//

import SwiftUI
import BottomSheetSwiftUI
import Photos
import CoreImage

struct HomePageView: View {
    @State var selectedCellImage: UIImage
    @State var uiImage: UIImage
    @State var showYellowToon = false
    @State var showDetailsView = false
    @State var showAIPhotosView = false
    @State var showingModal = false
    @State var image: [PHAsset]
    @State var selectedImage: UIImage
    @State var bottomSheetPosition: BottomSheetPosition = .hidden
    @State var showGenderSelector = false
    @State var selectedCellData: SeeAllCellData
    
    func fetchPhotos() {
        DispatchQueue.main.async {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    let assets = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                    assets.enumerateObjects { (object,_, _) in
                        image.append(object)
                    }
                        //image.reversed()
                } else if status == .denied {
                    
                }
            }
        }
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                TopNavHomePageView()
                MiddleHomePageView(selectedCellImage: $selectedCellImage, image: $uiImage, showDetailsView: $showDetailsView, showingModal: $showingModal, showAIPhotosView: $showAIPhotosView, showYellowToolView: $showYellowToon, selectedPhotos: $image)
                BottomTabHomePageView()
            }
            .bottomSheet(bottomSheetPosition: $bottomSheetPosition, switchablePositions: [.absolute(UIScreen.main.bounds.height/2)]) {
                ChooseYourGenderBottomSheetView(dismissBottomSheet: {
                    bottomSheetPosition = .hidden
                } )
            }
            .enableBackgroundBlur(true)
            .customBackground(Color.white.cornerRadius(30))
            .showDragIndicator(false)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    bottomSheetPosition = .absolute(UIScreen.main.bounds.height/1.5)
                }
            }
            .onAppear {
                DispatchQueue.main.async {
                    fetchPhotos()
                }
            }
            .fullScreenCover(isPresented: $showDetailsView) {
                DetailsView(selection1: $selectedCellData)
            }
            .fullScreenCover(isPresented: $showAIPhotosView) {
                AIPhotosView()
            }
            .fullScreenCover(isPresented: $showYellowToon) {
                YellowToonView()
            }
            if $showingModal.wrappedValue {
                if let selectedImage = selectedCellImage {
                    ModalView(selectedImage: selectedImage, showingModal: $showingModal, dismissModal: {
                        showingModal = false
                    })
                }
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(selectedCellImage: UIImage(), uiImage: UIImage(), image: [PHAsset](), selectedImage: UIImage(), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
    }
}

struct TopNavHomePageView: View {
    @State var showPromoView = false
    @State var showSettingView = false
    @State var bottomSheetShown: Bool = false
    var body: some View {
        VStack {
            HStack {
                Text("Remini")
                    .font(.system(size: 30, weight: .semibold))
                    .foregroundColor(.white)
                    .padding(.leading)
                Spacer()
                HStack(spacing: 15) {
                    Button {
                        print("btn tapped")
                        showPromoView.toggle()
                    } label: {
                        Text("PRO")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.white)
                    }.fullScreenCover(isPresented: $showPromoView) {
                        PromoView()
                    }
                    .frame(width: 50, height: 40)
                    .background(.red)
                    .cornerRadius(35)
                    
                    Button {
                        print("btn tapped")
                        showSettingView.toggle()
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                    .fullScreenCover(isPresented: $showSettingView) {
                        SettingsView()
                    }
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
        .background(.black)
    }
}

struct MiddleHomePageView: View {
    @Binding var selectedCellImage: UIImage
    @Binding var image: UIImage
    @Binding var showDetailsView: Bool
    @Binding var showingModal: Bool
    @Binding var showAIPhotosView: Bool
    @Binding var showYellowToolView: Bool
    @Binding var selectedPhotos: [PHAsset]
    @State var showSeeAllSectionOneView = false
    @State var showSeeAllSectionThreeView = false
    @State var showYellowToon = false
    @State var showPhotoLibrary: Bool = false
    @State var permissionGranted: Bool = false
    
    let columns = [GridItem(.flexible(), spacing: 80, alignment: .center)]
    let rows = [
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    let sectionZeroRows = [
        GridItem(.flexible(), spacing: 0, alignment: .center),
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    
    let sectionImages: [AssetImageArray] =
    [
    AssetImageArray(id: UUID(), image: Image("img1")),
    AssetImageArray(id: UUID(), image: Image("img2")),
    AssetImageArray(id: UUID(), image: Image("img3")),
    AssetImageArray(id: UUID(), image: Image("img4")),
    AssetImageArray(id: UUID(), image: Image("img5")),
    AssetImageArray(id: UUID(), image: Image("img6")),
    ]
   
    var body: some View {
        VStack {
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    
                    //MARK: - Section Zero -
                    Section(header:  VStack(alignment: .leading, spacing: 20){ HStack(alignment: .center, spacing: 20) {
                        Text("Enhance")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)  + Text(
                                Image(systemName: "sparkles"))
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.yellow)
                    }
                    .padding(.leading, 10)
                        HStack(spacing: 20) {
                            Text("Photos").background(Rectangle().fill(.white))
                                .frame(width: UIScreen.main.bounds.width/4, height: 50)
                                .font(.system(size: 20, weight: .semibold))
                                .foregroundColor(.black)
                                .background(.white)
                                .cornerRadius(25)
                            Button {
                                print("btn tapped")
                            } label: {
                                Text("Videos")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width/4, height: 50)
                                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    .cornerRadius(25)
                            }
                            Spacer()
                            Button {
                                print("btn tapped")
                            } label: {
                                Image(systemName: "photo")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width/6, height: 50)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 25)
                                            .stroke(.gray, lineWidth: 2)
                                    )
                            }
                            
                        }}) {
                            ScrollView(.horizontal) {
                                LazyHGrid(rows: sectionZeroRows, spacing: 5) {
                                    ForEach(selectedPhotos, id: \.self) { index in
                    SectionZeroCell(showingModal: $showingModal, selectedCellImage: $selectedCellImage, cellImage: image,  photo: index)
                                    }
                                }
                                .frame(height: 250)
                            }
                            .scrollIndicators(.hidden)
                        }
                    //MARK: - Section One -
                    Section(header:   HStack{
                        Text("Couple photos")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                        Button {
                            showSeeAllSectionOneView.toggle()
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        .fullScreenCover(isPresented: $showSeeAllSectionOneView) {
                            SeeAllView(selectedData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
                        }
                    }){
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHGrid(rows: rows, spacing: 8) {
ForEach(sectionImages) { index in
    SectionOneCell(showDetailsView: $showDetailsView, image: index.image)
                                }
.flipsForRightToLeftLayoutDirection(true)
.environment(\.layoutDirection, .rightToLeft)
                            }
                        } 
                    }
                    
                    //MARK: - Section Three -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("Discover new styles")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "paintpalette.fill"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.yellow)
                        }
                        Spacer()
                        Button {
                            showSeeAllSectionThreeView.toggle()
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        .fullScreenCover(isPresented: $showSeeAllSectionThreeView) {
                            AIPhotosView()
                        }
                        
                    }) {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows) {
                                ForEach(sectionImages) { index in
                                    SectionThreeCell(showAIPhotosView: $showAIPhotosView, image: index.image)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    //MARK: - Section Four -
                    // NavigationView {
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("Yellow Toon")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "sun.max"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.orange)
                        }
                        Spacer()
                        Button {
                            showYellowToon.toggle()
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        .fullScreenCover(isPresented: $showYellowToon) {
                            YellowToonView()
                        }
                        
                    }) {
                        LazyHGrid(rows: rows) {
                            ForEach(0..<1) { index in
                                SectionFourCell(showYellowToolView: $showYellowToolView)
                                //}
                            }
                        }
                    }
                    //MARK: - Section Five -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("AI hair salon")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "poweroutlet.type.l.fill"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                        }
                        Spacer()
                        Button {
                            print("btn tapped")
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        
                    }) {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows) {
                                ForEach(sectionImages) { index in
                                    SectionFiveCell(image: index.image)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    //MARK: - Section Six -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("See your future")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "globe.central.south.asia.fill"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.blue)
                        }
                        Spacer()
                        Button {
                            print("btn tapped")
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        
                    }) {
                        LazyHGrid(rows: rows) {
                            ForEach(0..<1) { index in
                                SectionSixCell()
                            }
                        }
                    }
                    
                    //MARK: - Section Seven -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("Fresh new look")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "gift.fill"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.red)
                        }
                        Spacer()
                        Button {
                            print("btn tapped")
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        
                    }) {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows) {
                                ForEach(sectionImages) { index in
                                    SectionSevenCell(image: index.image)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    //MARK: - Section Eight -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("Old money")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "teddybear.fill"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.brown)
                        }
                        Spacer()
                        Button {
                            print("btn tapped")
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        
                    }) {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows) {
                                ForEach(sectionImages) { index in
                                    SectionEightCell(image: index.image)
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    //MARK: - Section Nine -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("Curriculum headshot")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "briefcase.fill"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.brown)
                        }
                        Spacer()
                        Button {
                            print("btn tapped")
                        } label: {
                            Text("See All")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width/4, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(.gray, lineWidth: 2)
                                )
                        }
                        
                    }) {
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows) {
                                ForEach(sectionImages) { index in
                                    SectionNineCell(image: index.image)
                                }
                            }
                        }
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .background(.black)
    }
}



struct ChooseYourGenderBottomSheetView: View {
    let dismissBottomSheet: () -> Void
    var body: some View {
        VStack {
            HStack {
                Button {
                    print("btn tapped")
                    dismissBottomSheet()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }.padding()
                .padding(.trailing, 300)
            VStack(alignment: .center, spacing: 20) {
                Image(systemName: "personalhotspot")
                    .font(.system(size: UIScreen.main.bounds.width/4))
                //.background(.yellow)
                Text("What's your gender?")
                    .font(.title.bold())
                Text("We will only use this information to personalize your experience.")
                Button {
                    print("")
                } label: {
                    Text("Female")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.black)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.gray.opacity(0.3), lineWidth: 2)
                )
                
                Button {
                    print("")
                } label: {
                    Text("Male")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.black)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.gray.opacity(0.3), lineWidth: 2)
                )
                
                Button {
                    print("")
                } label: {
                    Text("Other")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.black)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(.gray.opacity(0.3), lineWidth: 2)
                )
            }
        }
    }
}

struct BottomTabHomePageView: View {
    let rows = [GridItem(.flexible())]
    var body: some View {
        VStack {
            LazyHGrid(rows: rows, alignment: .bottom, spacing: 20) {
                ForEach(0..<3) { index in
                    BottomTabHomePageCells()
                }
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/6)
    }
}

struct BottomTabHomePageCells: View {
    @State var showNewExploreView = false
    @State var showNewAIPhotosView = false
    @State var showImagePickerView = false
    @State var showNewAIFiltersView = false
    @State var selectedImage: UIImage? = nil
    var body: some View {
        HStack(alignment: .center, spacing: UIScreen.main.bounds.width/10) {
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    print("btn tapped")
                    showImagePickerView.toggle()
                } label: {
                    Image(systemName: "sparkles")
                        .font(.system(size: 30))
                        .frame(width: UIScreen.main.bounds.width/6, height: 60)
                        .foregroundColor(.white)
                        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .cornerRadius(10)
                    
                }
                .fullScreenCover(isPresented: $showImagePickerView) {
                    EnhanceImagePicker(selectedImage: $selectedImage)
                }
                Text("Enhance")
                    .scaledFont(name: "", size: 15)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    print("btn tapped")
                    showNewAIPhotosView.toggle()
                } label: {
                    Image(systemName: "camera.aperture")
                        .font(.system(size: 30))
                        .frame(width: UIScreen.main.bounds.width/6, height: 60)
                        .foregroundColor(.white)
                        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showNewAIPhotosView) {
                    AIPhotosView()
                }
                Text("AI Photos")
                    .scaledFont(name: "", size: 15)
                    .foregroundColor(.white)
            }
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    print("btn tapped")
                    showNewAIFiltersView.toggle()
                } label: {
                    Image(systemName: "dot.viewfinder")
                        .font(.system(size: 30))
                        .frame(width: UIScreen.main.bounds.width/6, height: 60)
                        .foregroundColor(.white)
                        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showNewAIFiltersView) {
                    AIFiltersView()
                }
                Text("AI Filters")
                    .scaledFont(name: "", size: 15)
                    .foregroundColor(.white)
            }
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    print("btn tapped")
                    showNewExploreView.toggle()
                } label: {
                    Image(systemName: "square.grid.2x2")
                        .font(.system(size: 30))
                        .frame(width: UIScreen.main.bounds.width/6, height: 60)
                        .foregroundColor(.white)
                        .background(Color(red: 2.4, green: 0.6, blue: 0.2))
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $showNewExploreView) {
                    ExploreView()
                }
                Text("Explore")
                    .scaledFont(name: "", size: 15)
                    .foregroundColor(.white)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/6)
        .background(.black)
    }
}


struct EnhanceImagePicker: UIViewControllerRepresentable {
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

struct SectionZeroCell: View {
    @Binding var showingModal: Bool
    @Binding var selectedCellImage: UIImage
    @State var cellImage: UIImage? = nil
    var photo: PHAsset
    func fetchImage() {
        let manager = PHImageManager.default()
        let option = PHImageRequestOptions()
        option.resizeMode = .exact
        option.deliveryMode = .highQualityFormat
        option.isSynchronous = false
        manager.requestImage(for: photo, targetSize: CGSize(width: UIScreen.main.bounds.width/3.1, height: 120), contentMode: .aspectFill, options: option) { result, _ in
            if let result = result {
                self.cellImage = result
            }
      }
}
    var body: some View {
        VStack {
            ZStack {
                if let image = cellImage {
                    Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width/3.1, height: 120)
                    .background(.red)
                    .cornerRadius(10)
                    .onTapGesture {
                    showingModal = true
                    selectedCellImage = image
                }
            }
        }
                .onAppear() {
                    fetchImage()
            }
        }
    }
}

struct SectionOneCell: View {
    @Binding var showDetailsView: Bool
    let image: Image
    var body: some View {
        ZStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
                .background(.red)
                .cornerRadius(30)
            Text("hi")
                .font(.system(size: 12, weight: .bold))
                .foregroundColor(.white)
                .padding(.all, 5)
        }
        .onTapGesture {
            //selected = item
            showDetailsView = true
        }
    }
}

struct SectionThreeCell: View {
    @Binding var showAIPhotosView: Bool
    let image: Image
    var body: some View {
        VStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width/3.3, height: 150)
                .background(.red)
                .cornerRadius(30)
        }
        .onTapGesture {
            showAIPhotosView = true
        }
    }
}

struct SectionFourCell: View {
    @Binding var showYellowToolView: Bool
    var body: some View {
        ZStack {
            Image("img2")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width, height: 200)
                .background(.red)
                .cornerRadius(10)
            HStack(spacing: 40) {
                Text("hi")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20))
                    .tint(.white)
            }
            .padding(.top, 150)
        }
        .onTapGesture {
            //selected = item
            showYellowToolView = true
        }
    }
}

struct SectionFiveCell: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionSixCell: View {
    var body: some View {
        Image("img3")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .background(.red)
            .cornerRadius(10)
    }
}

struct SectionSevenCell: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionEightCell: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionNineCell: View {
    let image: Image
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct ModalView: View {
    @State var selectedImage: UIImage?
    @Binding var showingModal: Bool
    let dismissModal: () -> Void
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.vertical)
            VStack(spacing: 20) {
                ZStack {
                    Image(uiImage: selectedImage!)
                        .resizable()
                        .frame(width: 400, height: 450)
                    Button(action: {
                        dismissModal()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .frame(width: 50, height: 50)
                            .background(.black.opacity(0.2))
                            .cornerRadius(25)
                    }
                    .padding(.leading, -130)
                }
                .frame(height: 20)
                Spacer()
                    .frame(height: 200)
                HStack {
                    VStack {
                        Button {
                            print("btn tapped")
                        } label: {
                            HStack(spacing: 30) {
                                Text("Enhance")
                                    .font(.system(size: 18, weight: .bold))
                                    .foregroundColor(.white)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 120, height: 70)
                        .background(.black)
                        .cornerRadius(35)
                        Button {
                            print("btn tapped")
                        } label: {
                            HStack(spacing: 40) {
                                Image(systemName: "person.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                    .background(.red)
                                    .cornerRadius(35)
                                Text("Retake shot\n random text")
                                    .font(.system(size: 10, weight: .bold))
                                    .foregroundColor(.white)
                                Image(systemName: "chevron.right")
                                    .font(.system(size: 20, weight: .bold))
                                    .foregroundColor(.black)
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width - 120, height: 80)
                        .overlay(
                            RoundedRectangle(cornerRadius: 40)
                                .stroke(.gray.opacity(0.3), lineWidth: 2)
                        )
                    }
                }
                .padding(.bottom, 10)
            }
            .frame(width: 300, height: 500)
            .background(Color.white)
            .cornerRadius(20).shadow(radius: 20)
        }
    }
}

extension CGRect {
    var center : CGPoint {
        return CGPoint(x: self.midX, y: self.midY)
    }
}

struct SeeAllView: View {
    @State var selectedData: SeeAllCellData
    @State var showNewView = false
    @State var showDetailsView = false
    @Environment(\.presentationMode) var presentationMode
    let columns = [
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    let seeAllCellItems: [SeeAllCellData] = [
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image: UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS"),
        SeeAllCellData(id: UUID(), image:  UIImage(systemName: "person.fill") ?? UIImage(), title: "Title Text", details: "12 PHOTOS")
    ]
    
    var body: some View {
        //NavigationView {
        VStack(alignment: .leading) {
            HStack(spacing: 30) {
                Button {
                    print("btn tapped")
                    presentationMode.wrappedValue.dismiss()
                    showNewView.toggle()
                } label: {
                    Image(systemName: "xmark")
                        .background(Rectangle().fill(.white))
                        .frame(width: UIScreen.main.bounds.width/9, height: 40)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .background(.white)
                        .cornerRadius(20)
                }
                .fullScreenCover(isPresented: $showNewView) {
                    HomePageView(selectedCellImage: UIImage(), uiImage: UIImage(), image: [PHAsset](), selectedImage: UIImage(), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
                }
                Text("Couple photos").font(.system(size: 24, weight: .bold)).foregroundColor(.white)
            }
            .padding(.leading, 20)
            VStack {
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(0..<10) { index in
                            SeeAllCellView(item: seeAllCellItems[index], isSelected: $selectedData)
                                .onTapGesture {
                                    selectedData = seeAllCellItems[index]
                                    showDetailsView.toggle()
                                }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
            .padding(.top)
            
            .fullScreenCover(isPresented: $showDetailsView) {
                DetailsView(selection1: $selectedData)
            }
        }
        .padding(.bottom)
        .background(Color(red: 0.1, green: 0.1, blue: 0.1))
        //        }
        //        .accentColor(.white)
    }
}

struct SeeAllView_Previews: PreviewProvider {
    static var previews: some View {
        SeeAllView(selectedData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
    }
}

struct SeeAllCellView: View{
    let item: SeeAllCellData
    @Binding var isSelected: SeeAllCellData
    var body: some View {
        VStack {
            Image(uiImage: item.image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width/1.1, height: 150)
                .background(.red)
            VStack(spacing: 5) {
                HStack {
                    Text(item.title)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.white)
                }
                .padding(.leading, -160)
                HStack(spacing: 70) {
                    Text(item.details)
                        .background(Rectangle().fill(.gray))
                        .frame(width: UIScreen.main.bounds.width/3.2, height: 40)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .background(.gray)
                        .cornerRadius(10)
                    Button {
                        print("")
                    } label: {
                        Text("Get This Pack")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width/3, height: 60)
                            .background(.white)
                            .cornerRadius(30)
                    }
                }
            }
            .padding(.leading)
            .frame(width: UIScreen.main.bounds.width/1.1, height: 100)
        }
        .frame(width: UIScreen.main.bounds.width/1.1, height: 250)
        .background(.secondary)
        .cornerRadius(20)
    }
}

struct DetailsView: View {
    @State var showPickForTwo = false
    @Binding var selection1: SeeAllCellData
    
    var body: some View {
        NavigationView {
            VStack {
                if let selection = selection1 {
                    Image(uiImage: selection.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2).ignoresSafeArea()
                        .background(.red)
                    Spacer()
                    VStack(alignment: .center, spacing: 20) {
                        VStack(spacing: 30) {
                            Text(selection.details)
                                .background(Rectangle().fill(.gray))
                                .frame(width: UIScreen.main.bounds.width/3.2, height: 40)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .background(.gray)
                                .cornerRadius(10)
                            Text(selection.title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .padding(.top, -120)
                        Text("Create beautiful wedding pictures of you\n and your better half")
                            .font(.system(size: 12, weight: .regular))
                            .foregroundColor(.white)
                        NavigationLink(destination: PickForTwoView(), isActive: $showPickForTwo) {
                            Button {
                                showPickForTwo.toggle()
                            } label: {
                                HStack(spacing: 30) {
                                    Text("Pick Two People")
                                        .font(.system(size: 16, weight: .semibold))
                                        .foregroundColor(.black)
                                    Image(systemName: "plus")
                                        .font(.system(size: 20))
                                        .foregroundColor(.black)
                                }
                                .frame(width: UIScreen.main.bounds.width - 100, height: 60)
                                .background(.white)
                                .cornerRadius(30)
                            }
                        }
                        .navigationBarBackButtonHidden(true)
                        .navigationBarTitle("")
                    }
                }
            }
            .background(Color(red: 0.1, green: 0.1, blue: 0.1))
        }
        .accentColor(.white)
    }
}

struct PickForTwoView: View {
    @State var showSelectGenderView = false
    @State var selectedImage1: Image?
    @State var selectedImage2: Image?
    @State var showContinueButton = false
    let textPerson1 = "Person 1"
    let textPerson2 = "Person 2"
    let sectionZeroRows = [
        GridItem(.flexible(), spacing: -20, alignment: .center),
        GridItem(.flexible(), spacing: -20, alignment: .center),
        GridItem(.flexible(), spacing: -20, alignment: .center)
    ]
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    HStack {
                        Text("Pick 2 People")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                    }
                }
                VStack {
                    ScrollView(.vertical) {
                        Section(header: HStack(spacing: 100) {
                            Text("Your photos")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            Button {
                                print("btn tapped")
                            } label: {
                                Text("Open Gallery")
                                    .font(.system(size: 18, weight: .medium))
                                    .foregroundColor(.white)
                                    .frame(width: UIScreen.main.bounds.width/3, height: 50)
                                    .background(Color(red: 0.1, green: 0.1, blue: 0.1))
                                    .cornerRadius(25)
                            }
                        }
                        ) {
                            LazyVGrid(columns: sectionZeroRows, spacing: 5) {
                                ForEach(0..<18) { index in
                                    PickForTwoViewCell(onTap: { image in
                                        if selectedImage1 == nil {
                                            selectedImage1 = image
                                        } else if selectedImage2 == nil {
                                            selectedImage2 = image
                                            showContinueButton = true
                                        }
                                        
                                    })
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                }
                HStack(spacing: 20) {
                    Button {
                        print("")
                    } label: {
                        VStack {
                            selectedImage1
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text(textPerson1)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        .padding(.top)
                    }
                    
                    Button {
                        print("")
                    } label: {
                        VStack {
                            selectedImage2
                                .font(.system(size: 50))
                                .foregroundColor(.gray)
                            Text(textPerson2)
                                .font(.system(size: 14, weight: .regular))
                                .foregroundColor(.gray)
                        }
                        .padding(.top)
                    }
                }
                .padding(.leading, -160)
                if showContinueButton {
        NavigationLink(destination: FirstSelectGenderView(selectedImage1: $selectedImage1, selectedImage2: $selectedImage2, textPerson1: textPerson1, textPerson2: textPerson2), isActive: $showSelectGenderView) {
                        Button {
                            showSelectGenderView.toggle()
                        } label: {
                            Text("Continue")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.black)
                                .frame(width: UIScreen.main.bounds.width/1.5, height: 50)
                                .background(.white)
                                .cornerRadius(25)
                        }
                    }
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle("")
                }
            }
            .padding(.bottom, 50)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.1)
            .background(Color.black.ignoresSafeArea())
        }
    }
}

struct PickForTwoViewCell: View {
    var onTap: (Image) -> Void
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "person.fill")
                    .frame(width: UIScreen.main.bounds.width/3.3, height: 120)
                    .background(.red)
                    .cornerRadius(10)
                    .onTapGesture {
                        onTap(Image(systemName: "person.fill"))
                    }
            }
        }
    }
}

struct FirstSelectGenderView: View {
    @Binding var selectedImage1: Image?
    @Binding var selectedImage2: Image?
    @State var selectedGender: String? = nil
    @State var isNextButtonEnabled = false
    @State var showNextView = false
    var textPerson1: String
    var textPerson2: String
    var body: some View {
        //NavigationView {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    if let image1 = selectedImage1 {
                        image1
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .background(.red)
                            .cornerRadius(25)
                        
                    }
                    Text(textPerson1)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
                VStack {
                    if let image2 = selectedImage2 {
                        image2
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .background(.red)
                            .cornerRadius(25)
                            .disabled(true)
                    }
                    Text(textPerson2)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .hidden()
                }
            }
            .padding(.leading, 50)
            Spacer()
                .frame(height: 100)
            VStack(spacing: 20) {
                Text("Gender")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                Button {
                    selectedGender = "Female"
                    isNextButtonEnabled = true
                } label: {
                    Text("Female")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(selectedGender == "Female" ? .white : .gray.opacity(0.3), lineWidth: 2)
                )
                
                Button {
                    selectedGender = "Male"
                    isNextButtonEnabled = true
                } label: {
                    Text("Male")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(selectedGender == "Male" ? .white : .gray.opacity(0.3), lineWidth: 2)
                )
    NavigationLink(destination: SecondSelectGenderView(selectedImage1: $selectedImage1, selectedImage2: $selectedImage2, textPerson1: textPerson1, textPerson2: textPerson2), isActive: $showNextView) {
                    Button {
                        selectedGender = "Other"
                        isNextButtonEnabled = true
                    } label: {
                        Text("Other")
                            .font(.system(size: 16,weight: .semibold))
                            .foregroundColor(.white)
                    }
                    .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(selectedGender == "Other" ? .white : .gray.opacity(0.3), lineWidth: 2)
                    )
                }
                .navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
            }
            .frame(width: UIScreen.main.bounds.width, height: 300)
            .background(.secondary)
            .cornerRadius(20)
            Spacer()
                .frame(height: 80)
            VStack {
                HStack(spacing: 30) {
                    Button {
                        showNextView.toggle()
                    } label: {
                        HStack(spacing: 30) {
                            Text("Next")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 100, height: 60)
                    .disabled(!isNextButtonEnabled)
                    .background(isNextButtonEnabled ? Color.white : Color.gray)
                    .cornerRadius(30)
                }
                .padding(.bottom, 50)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.ignoresSafeArea())
        //}
    }
}

struct SecondSelectGenderView: View {
    @Binding var selectedImage1: Image?
    @Binding var selectedImage2: Image?
    @State var selectedGender: String? = nil
    @State var isNextButtonEnabled = false
    @State var showNextView = false
    @State var showTermsAndConditions = false
    @State var showLoadingView = false
    var textPerson1: String
    var textPerson2: String
    var body: some View {
        //NavigationView {
        VStack {
            HStack(spacing: 20) {
                VStack {
                    if let image1 = selectedImage1 {
                        image1
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .background(.red)
                            .cornerRadius(25)
                            .disabled(true)
                        
                    }
                    Text(textPerson1)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                        .hidden()
                }
                VStack {
                    if let image2 = selectedImage2 {
                        image2
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .background(.red)
                            .cornerRadius(25)
                    }
                    Text(textPerson2)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(.white)
                }
            }
            .padding(.leading, 50)
            Spacer()
                .frame(height: 70)
            VStack(spacing: 20) {
                Text("Gender")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                Button {
                    selectedGender = "Female"
                    isNextButtonEnabled = true
                    showTermsAndConditions = true
                } label: {
                    Text("Female")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(selectedGender == "Female" ? .white : .gray.opacity(0.3), lineWidth: 2)
                )
                
                Button {
                    selectedGender = "Male"
                    isNextButtonEnabled = true
                    showTermsAndConditions = true
                } label: {
                    Text("Male")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(selectedGender == "Male" ? .white : .gray.opacity(0.3), lineWidth: 2)
                )
                Button {
                    selectedGender = "Other"
                    isNextButtonEnabled = true
                    showTermsAndConditions = true
                } label: {
                    Text("Other")
                        .font(.system(size: 16,weight: .semibold))
                        .foregroundColor(.white)
                }
                .frame(width: UIScreen.main.bounds.width - 50, height: 60)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(selectedGender == "Other" ? .white : .gray.opacity(0.3), lineWidth: 2)
                )
            }
            .frame(width: UIScreen.main.bounds.width, height: 300)
            .background(.secondary)
            .cornerRadius(20)
            Spacer()
                .frame(height: 20)
            HStack {
                Text("By tapping Start Generation, declare that you have all necessary\n right and permissions to share these images and information with us\n and that you will use the images generated lawfully\n\n If you upload images that include minors, by tapping Start\n Generation, declare that you have parental responsibility for them\n and the necessary rights to share the images.")
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.white)
                    .opacity(showTermsAndConditions ? 1 : 0)
            }
            VStack {
                Spacer()
                    .frame(height: 20)
                VStack(spacing: 30) {
                    Button {
                        showLoadingView = true
                    } label: {
                        HStack(spacing: 30) {
                            Text("Start Generation")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.black)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 20))
                                .foregroundColor(.black)
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width - 100, height: 60)
                    .disabled(!isNextButtonEnabled)
                    .background(isNextButtonEnabled ? Color.white : Color.gray)
                    .cornerRadius(30)
                }
                .fullScreenCover(isPresented: $showLoadingView) {
                    GenderSelectionLoadingView(isActive: true)
                }
                .padding(.bottom, 50)
            }
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color.black.ignoresSafeArea())
        //}
    }
}
struct GenderSelectionLoadingView: View {
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
        .fullScreenCover(isPresented: $isPresentedView) {
            HomePageView(selectedCellImage: UIImage(), uiImage: UIImage(), image: [PHAsset](), selectedImage: UIImage(), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
        }
        .background(.black.opacity(0.2))
        .ignoresSafeArea()
    }
}
