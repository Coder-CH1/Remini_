//
//  YellowToonView.swift
//  Remini_
//
//  Created by Mac on 31/05/2024.
//

import SwiftUI
import Photos

struct YellowToonView: View {
    init() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        appearance.backgroundColor = .black
        UINavigationBar.appearance().standardAppearance = appearance
    }
    @State var showBottomButton = false
    @State var scrollViewOffset: CGFloat = 0
    @State var scrollViewContentOffset: CGFloat = 0
    @State var headerOffset: CGFloat = 0
    @State var showHomePageView = false
    @State var showAIPhotosView = false
    var headerStr = "Yellow Toon"
    let columns = [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
    ]
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                ScrollView(.vertical, showsIndicators: false) {
                    Section(header: VStack(spacing: 20) {
                        TopHeaderContent()
                        VStack {
                            Text(headerStr)
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) +
                            Text(Image(systemName: "sun.max"))
                                .font(.system(size: 20))
                                .foregroundColor(.orange)
                        }
                        
                        HeaderContents(showAIPhotosView: $showAIPhotosView)
                    }) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(0..<6) { index in
                                YellowToonCellView()
                            }
                        }
                    }
                    .offsetChanged(scrollViewOffset: $scrollViewOffset)
                    .contentOffsetChanged(scrollViewContentOffset: $scrollViewContentOffset)
                }
                .onChange(of: scrollViewOffset) { offset in
                    if offset < 50 {
                        withAnimation {
                            showBottomButton = true
                        }
                    } else {
                        withAnimation {
                            showBottomButton = false
                        }
                    }
                }
                if showBottomButton {
                    HStack(spacing: 30) {
                        Button { showAIPhotosView.toggle() } label: {
                            Text("Get Full Park")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(.black)
                        }
                        Image(systemName: "chevron.right")
                            .font(.system(size: 20))
                            .foregroundColor(.black)
                            .fullScreenCover(isPresented: $showAIPhotosView) {
                                AIPhotosView()
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width/1.2, height: 50)
                    .background(.white)
                    .cornerRadius(25)
                }
            }
            .padding(.top, 40)
            .padding(.bottom, 50)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.1)
            .background(Color.black.ignoresSafeArea())
            
            .navigationBarBackButtonHidden(false)
            .navigationBarItems(leading: Button {
                showHomePageView.toggle()
            } label: {
                Image(systemName: "chevron.backward")
                    .font(.system(size: 20))
                    .foregroundColor(.white)
            }.fullScreenCover(isPresented: $showHomePageView) {
                HomePageView(uiImage: UIImage(), image: [PHAsset](), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
                }
            
            )
            .fullScreenCover(isPresented: $showAIPhotosView) {
                AIPhotosView()
            }
        }
    }
}

struct YellowToonView_Previews: PreviewProvider {
    static var previews: some View {
        YellowToonView()
    }
}

extension View {
    func offsetChanged(scrollViewOffset: Binding<CGFloat>) -> some View {
        self.background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: ViewOffsetKey.self, value: proxy.frame(in: .named("scrollView")).minY)
            }
                .onPreferenceChange(ViewOffsetKey.self) { value in
                    scrollViewOffset.wrappedValue = value
                }
        )
    }
    
    func contentOffsetChanged(scrollViewContentOffset: Binding<CGFloat>) -> some View {
        self.background(
            GeometryReader { proxy in
                Color.clear
                    .preference(key: ViewOffsetKey.self, value: proxy.frame(in: .named("scrollView")).minY)
            }
                .onPreferenceChange(ViewOffsetKey.self) { value in
                    scrollViewContentOffset.wrappedValue = value
                }
        )
    }
}

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct YellowToonCellView: View {
    var body: some View {
        ZStack {
            Image(systemName: "")
                .frame(width: UIScreen.main.bounds.width/2, height: 250)
                .background(.red)
                .cornerRadius(10)
                .padding(.leading, 3)
                .padding(.trailing, 3)
        }
    }
}

struct HeaderContents: View {
    @Binding var showAIPhotosView: Bool
    var body: some View {
        VStack {
            Text("Get your personalized characters now!")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(.white)
            HStack(spacing: 30) {
                Button {
                    showAIPhotosView.toggle()
                } label: {
                    Text("Get Full Park")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(.black)
                }
                Image(systemName: "chevron.right")
                    .font(.system(size: 20))
                    .foregroundColor(.black)
            }
            .frame(width: UIScreen.main.bounds.width/1.2, height: 50)
            .background(.white)
            .cornerRadius(25)
        }
    }
}

struct TopHeaderContent: View {
    var body: some View {
        VStack {
            Text("15 PHOTOS")
                .background(Rectangle().fill(.gray))
                .frame(width: UIScreen.main.bounds.width/3.2, height: 40)
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)
                .background(.gray)
                .cornerRadius(10)
        }
    }
}
