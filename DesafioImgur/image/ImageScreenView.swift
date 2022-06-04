//
//  ImageScreen.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 22/02/22.
//

import SwiftUI

struct ImageScreenView: View {
  let imageEntity: ImageEntity;
  var body: some View {
    
      ScrollView(.vertical) {
        CustomAsyncImage(url: URL(string: imageEntity.link))
      }
      .background(Color(red: 54/255, green: 59/255, blue: 86/255)
                    .opacity(0.8))
      .padding(.top)
  }
}


