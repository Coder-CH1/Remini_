//
//  CellsContentView.swift
//  Remini_
//
//  Created by Mac on 29/05/2024.
//

import SwiftUI

struct CellsContentView: View {
    //struct CustomModalPopups: View {
        @State private var showingModal = false
        
        var body: some View {
            ZStack {
                VStack(spacing: 20) {
                    Button(action: {
                        self.showingModal = true
                    }) {
                        Text("Show popup")
                    }
                    Spacer()
                }
                if $showingModal.wrappedValue {
                    ZStack {
Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.vertical)
                        VStack(spacing: 20) {
                Text("Popup")
                                .bold().padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.orange)
                                .foregroundColor(Color.white)
                            Spacer()
                            Button(action: {
                                self.showingModal = false
                            }) {
                                Text("Close")
                            }.padding()
                        }
                        .frame(width: 300, height: 200)
                        .background(Color.white)
                        .cornerRadius(20).shadow(radius: 20)
                    }
                }
            }
        }
    }
//}

struct CellsContentView_Previews: PreviewProvider {
    static var previews: some View {
        CellsContentView()
    }
}
