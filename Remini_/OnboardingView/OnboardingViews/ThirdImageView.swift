//
//  ThirdImageView.swift
//  Remini_
//
//  Created by Mac on 24/05/2024.
//

import SwiftUI
import Photos
import Kingfisher

struct ThirdImageView: View {
    @State var isPresentedView = false
    var body: some View {
        VStack(spacing: 30) {
            Spacer()
            Button {
                print("btn tapped")
            } label: {
                Image(systemName: "arrow.left.and.right")
                    .frame(width: 50, height: 50)
                    .background(.white)
                    .cornerRadius(25)
                    .tint(.black)
            }
            .padding(.bottom, 40)
            HStack(spacing: 30) {
                Text("Meet the new \n you")
                    .font(.system(size: 34, weight: .black))
                    .foregroundColor(.white)
                Button {
                    print("btn tapped")
                    isPresentedView.toggle()
                } label: {
                    Image(systemName: "chevron.right")
                        .frame(width: 80, height: 70)
                        .background(.white)
                        .cornerRadius(40)
                        .tint(.black)
                }
                
            }
            .fullScreenCover(isPresented: $isPresentedView) {
                LoadingView(isActive: true)
            }
            .padding(.bottom, 80)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.gray)
        .ignoresSafeArea()
    }
}

struct ThirdImageView_Previews: PreviewProvider {
    static var previews: some View {
        ThirdImageView()
    }
}

struct LoadingView: View {
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
            GiveAccessView(imageData: [ImageData(imgUrls: [String]())])
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

struct GiveAccessView: View {
    @State var showNewView = false
    @State var showImages = false
    @State var imageData: [ImageData]
    let columns = [
        GridItem(.flexible(), spacing: 0, alignment: .center),
        GridItem(.flexible(), spacing: 0, alignment: .center),
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    func getOffsetX(_ index: Int) -> CGFloat {
        if index == 0 || index == 1 {
            return 0
        } else if index == 2 || index == 3 {
            return index == 2 ? -100 : 100
        } else {
            return 100
        }
    }
    func getOffsetY(_ index: Int) -> CGFloat {
        if index == 0 || index == 1 {
            return -100
        } else if index == 2 || index == 3 {
            return -100
        } else {
            return 100
        }
    }
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 50) {
                ForEach(imageData, id: \.self) { firstIndex in
                    ForEach(firstIndex.imgUrls, id: \.self) { secondIndex in
                    GiveAccessCellView(imageUrl: secondIndex)
                        .frame(width: 100, height: 100)
                        .background(.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
//                        .offset(x: showImages ? 0 : getOffsetX(Int(1)), y: showImages ? 0 : getOffsetY(Int(3)))
//                        .animation(.easeInOut(duration: 3.0))
                    
                }
            }
        }
            .onAppear() {
                withAnimation() {
                    showImages.toggle()
                    ImageManager.shared.fetchImageUrls { urls in
                        DispatchQueue.main.async {
                            let imageDataArray = urls.imgUrls.map { url in
                                ImageData(imgUrls: [url])
                            }
                            self.imageData = imageDataArray
                        }
                    }
                }
            }
            .frame(height: 250)
            Spacer()
                .frame(height: 50)
            HStack(alignment: .center, spacing: 20) {
                Text("Get the most out of\nRemini ")
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.white) + Text(
                        Image(systemName: "football.fill"))
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.pink)
            }
            .padding(.leading, -40)
            Text("To continue, Remini needs access to your photos. \nYou can change this later in the settings app.")
                .font(.system(size: 15))
                .foregroundColor(.white)
            Button {
                print("btn tapped")
                showNewView.toggle()
            } label: {
                Text("Give Access to Photos")
                    .frame(width: UIScreen.main.bounds.width/1.1, height: 60)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.black)
                    .background(.white)
                    .cornerRadius(30)
            }
            .fullScreenCover(isPresented: $showNewView) {
                HomePageView(selectedCellImage: UIImage(), uiImage: UIImage(), image: [PHAsset](), selectedImage: UIImage(), selectedCellData: SeeAllCellData(id: UUID(), image: UIImage(), title: "", details: ""))
            }
            Button {
                print("btn tapped")
            } label: {
                Text("I'll do it later")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(.white)
                    .underline(color: .white)
            }
            
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
    }
}

struct GiveAccessCellView: View {
    let imageUrl: String
    var body: some View {
        KFImage(URL(string: imageUrl))
            .placeholder {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 120)
            }
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
    }
}
