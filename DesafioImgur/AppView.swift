//
//  ContentView.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 19/02/22.
//

import SwiftUI

struct AppView: View {
  @ObservedObject var authViewModel = AuthViewModel()
  var body: some View {
    GalleryScreenView()
  }
}

struct AppView_Preview: PreviewProvider {
  static var previews: some View {
    AppView()
  }
}
