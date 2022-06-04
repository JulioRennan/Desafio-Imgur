//
//  CustomAsyncImage.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 22/02/22.
//

import Foundation
import SwiftUI

struct CustomAsyncImage: View {
  let url: URL?
  var onTapWithHasError: ((Bool)-> Void)?
  @State private var hasError: Bool = true;
  
  var body: some View {
    AsyncImage(url: url, transaction: Transaction(animation: .easeIn)) { phase in
      switch phase {
      case .empty:
        ProgressView()
          .tint(.white)
      case .success(let imageView):
        imageView
          .resizable()
          .aspectRatio(contentMode: .fit)
          .shadow(color: .white.opacity(0.5), radius: 2, x: 0, y: 2)
          .onAppear { self.hasError = false }
      case .failure(_):
        errorImage()
      @unknown default:
        errorImage()
      }
    }.onTapGesture {
      self.onTapWithHasError?(self.hasError)
    }
  }
  
  func errorImage() -> some View {
    return Image(systemName: "exclamationmark.icloud")
      .resizable()
      .renderingMode(.template)
      .foregroundColor(.white)
      .scaledToFit()
  }
}
