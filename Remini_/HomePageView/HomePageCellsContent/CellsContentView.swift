//
//  CellsContentView.swift
//  Remini_
//
//  Created by Mac on 29/05/2024.
//

import SwiftUI

//struct CellsContentView: View {
//    //struct CustomModalPopups: View {
//        @State private var showingModal = false
//
//        var body: some View {
//            ZStack {
//                VStack(spacing: 20) {
//                    Button(action: {
//                        self.showingModal = true
//                    }) {
//                        Text("Show popup")
//                    }
//                    Spacer()
//                }
//                if $showingModal.wrappedValue {
//                    ZStack {
//Color.black.opacity(0.4)
//                            .edgesIgnoringSafeArea(.vertical)
//                        VStack(spacing: 20) {
//                Text("Popup")
//                                .bold().padding()
//                                .frame(maxWidth: .infinity)
//                                .background(Color.orange)
//                                .foregroundColor(Color.white)
//                            Spacer()
//                            Button(action: {
//                                self.showingModal = false
//                            }) {
//                                Text("Close")
//                            }.padding()
//                        }
//                        .frame(width: 300, height: 200)
//                        .background(Color.white)
//                        .cornerRadius(20).shadow(radius: 20)
//                    }
//                }
//            }
//        }
//    }
////}

import SwiftUI

struct ICellsContentView: View {
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))]) {
                    ForEach(0..<20) { index in
                        Text("Item \(index)")
                            .padding()
                            .frame(height: 100)
                            .background(Color.blue.opacity(0.5))
                            .cornerRadius(10)
                    }
                }
                .padding()
            }
            .navigationTitle("LazyVGrid Example")
            .overlay(
                StickyHeaderView()
                    .frame(height: 50)
                    .padding(.horizontal)
                    .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top),
                alignment: .top
            )
        }
    }
}

struct StickyHeaderView: View {
    var body: some View {
        HStack {
            Text("")
//            Button("Button 1") {
//                // Action for Button 1
//            }
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.green)
//            .cornerRadius(10)
//
//            Spacer()
//
//            Text("Sticky Header")
//
//            Spacer()
//
//            Button("Button 2") {
//                // Action for Button 2
//            }
//            .foregroundColor(.white)
//            .padding()
//            .background(Color.green)
//            .cornerRadius(10)
        }
        .background(Color.gray)
    }
}


struct ICellsContentView_Previews: PreviewProvider {
    static var previews: some View {
        ICellsContentView()
    }
}
