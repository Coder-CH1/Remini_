//
//  ThirdImageView.swift
//  Remini_
//
//  Created by Mac on 24/05/2024.
//

import SwiftUI

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
            GiveAccessView()
        }
        .background(.black)
        .ignoresSafeArea()
    }
}

struct GiveAccessView: View {
    @State var showNewView = false
    let columns = [
        GridItem(.flexible(), spacing: 0, alignment: .center),
        GridItem(.flexible(), spacing: 0, alignment: .center),
        GridItem(.flexible(), spacing: 0, alignment: .center)
    ]
    var body: some View {
        VStack(alignment: .center, spacing: 30) {
            LazyVGrid(columns: columns, alignment: .center, spacing: 50) {
                ForEach(0..<6) { index in
                    GiveAccessCellView(image: Image(systemName: "person.fill"), width: index == 1 ? 150 : 60, height: index == 2 ? 100 : 50)
                }
            }
            .frame(height: 250)
            .background(.red)
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
                HomePageView(item: SectionOneData(id: UUID(), image: UIImage(), title: ""))
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
    let image: Image
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        image
            .resizable()
            .scaledToFit()
            .background(.white)
            .frame(width: width, height: height)
    }
}
