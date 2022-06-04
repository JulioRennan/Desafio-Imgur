//
//  GridItemsImages.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
import SwiftUI
import ToastUI

struct GridItemsImages: View {
  let images: [ImageEntity]
  @State private var selectedImage: ImageEntity
  @State private var isActive = false
  @State private var showToastError = false
  init(images: [ImageEntity]){
    self.images = images
    self.selectedImage = images.first!
  }
  var body: some View {
    
    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 3), alignment: .center) {
      ForEach(images) {
        img in
        CustomAsyncImage(url: URL(string: img.link)) { hasError in
          if hasError {
            self.isActive =  false
            self.showToastError = true
          } else {
            self.selectedImage =  img
            self.isActive = true
          }
        }
      }
      .transition(.move(edge: .trailing))
      .background {
        NavigationLink(destination: ImageScreenView(imageEntity: selectedImage), isActive: $isActive) {
          EmptyView()
        }
      }
    }.toast(isPresented: $showToastError, dismissAfter: 1) {
      ToastView {
        HStack {
           Image(systemName: "exclamationmark.triangle.fill")
            .resizable()
            .renderingMode(.template)
            .foregroundColor(.yellow)
            .scaledToFit()
            .frame(width: 20)
          Text("Erro ao carregar a imagem!")
        }
      }
      .padding()
    }
  }
  
}
