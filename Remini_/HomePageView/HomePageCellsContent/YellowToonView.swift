//
//  YellowToonView.swift
//  Remini_
//
//  Created by Mac on 31/05/2024.
//

import SwiftUI

struct YellowToonView: View {
    @State var header = true
    @State var showBottomButton = false
//    @State var safeArea: EdgeInsets
//    @State var size: CGSize = 0
    @State var scrollViewContentHeight: CGFloat = 0
    @State var scrollViewHeight: CGFloat = 0
    let columns = [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
    ]
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                //MARK: - Section Eight -
                //ScrollViewReader { g in
                    ScrollView(.vertical, showsIndicators: false) {
                        Section(header:  VStack(spacing: 20){
                            Text("15 PHOTOS")
                                .background(Rectangle().fill(.gray))
                                .frame(width: UIScreen.main.bounds.width/3.2, height: 40)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.white)
                                .background(.gray)
                                .cornerRadius(10)
                            Text("Yellow Toon")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white) + Text(
                                    Image(systemName: "sun.max"))
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.orange)
                            
                            Text("Get your personalized characters now!")
                                .font(.system(size: 16, weight: .regular))
                                .foregroundColor(.white)
                            HStack(spacing: 30) {
                                Button {
                                    print("btn tapped")
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
                            
                        }) {
                            LazyVGrid(columns: columns, spacing: 10) {
                                ForEach(0..<6) { index in
                                    YellowToonCellView()
                                }
                            }
                                HStack(spacing: 30) {
                                    Button {
                                        print("btn tapped")
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
                //}
            }
            .padding(.top, 50)
            .padding(.bottom, 50)
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/1.1)
            .background(Color.black.ignoresSafeArea())
        }
    }
}
struct YellowToonView_Previews: PreviewProvider {
    @State var item: SectionFourData
    static var previews: some View {
        YellowToonView()
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

struct ViewOffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
