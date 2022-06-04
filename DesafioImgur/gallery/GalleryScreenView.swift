//
//  GalleryView.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import SwiftUI

struct GalleryScreenView: View {
  @ObservedObject var galleryViewModel = GalleryViewModel()
  var countGalleries: Int {
    get { return galleryViewModel.galleries.count }
  }
  
  init() {
    UINavigationBar.appearance().tintColor = .black
    UINavigationBar.appearance().backgroundColor = UIColor.green.withAlphaComponent(0.2)
    UINavigationBar.appearance().isTranslucent = false
  }
  var body: some View {
    NavigationView {
      List {
        ForEach(galleryViewModel.galleries) { g in
          VStack {
            HeaderGalleryView(gallery: g)
              .onAppear {
                if g.id == galleryViewModel.galleries.last!.id,
                   galleryViewModel.hasMore {
                  galleryViewModel.nexPage()
                }
              }
            if let images = g.images {
              GridItemsImages(images: images)
            }
          }
        }.listRowBackground( Color(red: 54/255, green: 59/255, blue: 86/255))
        if galleryViewModel.isLoading {
          ProgressView()
            .frame(idealWidth: .infinity,
                   maxWidth: .infinity,
                   alignment: .center)
        }
      }
      .listStyle(.plain)
      .navigationTitle("Galerias Hot")
      .navigationViewStyle(StackNavigationViewStyle())
      .font(.system(size: 15))
      .navigationBarTitleDisplayMode(.inline)
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          Image("imgur_logo")
            .resizable()
            .scaledToFit()
            .frame(height: 20)
        }
      }
    }
  }
}

struct GalleryView_Previews: PreviewProvider {
  static var previews: some View {
    GalleryScreenView()
  }
}
