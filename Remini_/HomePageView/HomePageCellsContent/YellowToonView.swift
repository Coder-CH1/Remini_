//
//  YellowToonView.swift
//  Remini_
//
//  Created by Mac on 31/05/2024.
//

import SwiftUI

struct YellowToonView: View {
    
    let columns = [
        GridItem(.flexible(), spacing: 20, alignment: .center),
        GridItem(.flexible(), spacing: 20, alignment: .center)
    ]
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                //MARK: - Section Eight -
                ScrollView(.vertical) {
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
                    Button {
                        print("btn tapped")
                    } label: {
                        Text("Get Full Park")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.black)
                            .frame(width: UIScreen.main.bounds.width/2, height: 50)
                            .background(.white)
                            .cornerRadius(25)
                    }
                    
                }) {
                        LazyVGrid(columns: columns, spacing: 10) {
                            ForEach(0..<6) { index in
                                YellowToonCellView()
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                
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
