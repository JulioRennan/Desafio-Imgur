//
//  CardGalleryView.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
import SwiftUI
struct HeaderGalleryView: View {
  let gallery: GalleryEntity
  let corderRadius: CGFloat =  5
  var body: some View  {
    ZStack {
      RoundedRectangle(cornerRadius: corderRadius)
        .fill(.black.opacity(0.8))
      NavigationLink(destination: GalleryScreenView()){
        HStack {
          Text(gallery.title)
            .foregroundColor(.white)
            .lineLimit(2)
            .padding()
          Spacer()
          Image(systemName: "chevron.right")
            .font(.system(size: 20))
            .foregroundColor(.white)
        }
      }
    }
  }
}
