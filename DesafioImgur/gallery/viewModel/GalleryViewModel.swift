//
//  GalleryViewModel.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
class GalleryViewModel: ObservableObject {
  let galleryManager = GalleryManager()
  var page: Int = 1
  @Published var galleries = [GalleryEntity]()
  @Published var isLoading = false
  @Published var hasMore =  true
  
  init() {
   nexPage()
  }
  
  func nexPage() {
    if hasMore {
      isLoading = true
      Task {
        let galleriesAvaiable = await galleryManager.getPhotoGalleries(page: page)
        DispatchQueue.main.async {
          self.galleries += galleriesAvaiable
          self.page += 1
          self.isLoading = false
        }
      }
    }
  }
}
