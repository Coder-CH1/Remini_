//
//  HomePageView.swift
//  Remini_
//
//  Created by Mac on 24/05/2024.
//

import SwiftUI
import BottomSheetSwiftUI

struct HomePageView: View {
    @State var bottomSheetPosition: BottomSheetPosition = .hidden
    @State var showGenderSelector = false
    var body: some View {
        VStack(spacing: 0) {
            TopNavHomePageView()
            MiddleHomePageView()
            BottomTabHomePageView()
        }
        
        .bottomSheet(bottomSheetPosition: $bottomSheetPosition, switchablePositions: [.absolute(500)]) {
            ChooseYourGenderBottomSheetView(dismissBottomSheet: {
                bottomSheetPosition = .hidden
            } )
        }
        .enableBackgroundBlur(true)
        .customBackground(.white)
        .showDragIndicator(false)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                bottomSheetPosition = .absolute(500)
            }
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView()
    }
}

struct ChooseYourGenderBottomSheetView: View {
    let dismissBottomSheet: () -> Void
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Button {
                    print("btn tapped")
                    dismissBottomSheet()
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                }
            }
            .padding(.top)
            .padding(.trailing, 300)
            Image(systemName: "")
            Text("What's your gender?")
                .font(.title.bold())
            Text("We will only use this information to personalize\n your experience.")
        }
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
    let columns = [GridItem(.flexible(), spacing: 80, alignment: .center)]
    let rows = [
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    let sectionZeroRows = [
        GridItem(.flexible(), spacing: 0, alignment: .center),
        GridItem(.flexible(), spacing: 0, alignment: .center)
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
                                    ForEach(0..<20) { index in
                                        SectionZeroCell()
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
                        
                    }){
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, spacing: 8) {
                                ForEach(5..<20) { index in
                                    SectionOneCell()
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    //MARK: - Section Two -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("Stop-motion clay movie")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "paintpalette.fill"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.yellow)
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
                                SectionTwoCell()
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
                                ForEach(5..<20) { index in
                                    SectionThreeCell()
                                }
                            }
                        }
                        .scrollIndicators(.hidden)
                    }
                    
                    //MARK: - Section Four -
                    Section(header:  HStack{
                        HStack(alignment: .center, spacing: 20) {
                            Text("Century of Fashion")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "figure.stand"))
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
                                SectionFourCell()
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
                                ForEach(5..<20) { index in
                                    SectionFiveCell()
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
                                ForEach(5..<20) { index in
                                    SectionSevenCell()
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
                                ForEach(5..<20) { index in
                                    SectionEightCell()
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
                                ForEach(5..<20) { index in
                                    SectionNineCell()
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
                        .background(Color(red: 0.2, green: 0.2, blue: 0.2))
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

struct SectionZeroCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width/3.3, height: 120)
            .background(.red)
            .cornerRadius(10)
    }
}

struct SectionOneCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionTwoCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .background(.red)
            .cornerRadius(10)
    }
}

struct SectionThreeCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width/3.3, height: 150)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionFourCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .background(.red)
            .cornerRadius(10)
    }
}

struct SectionFiveCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionSixCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width, height: 200)
            .background(.red)
            .cornerRadius(10)
    }
}

struct SectionSevenCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionEightCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
    }
}

struct SectionNineCell: View {
    var body: some View {
        Image(systemName: "person.fill")
            .frame(width: UIScreen.main.bounds.width/3.3, height: 170)
            .background(.red)
            .cornerRadius(30)
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
