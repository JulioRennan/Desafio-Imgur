//
//  GalleryManager.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
class GalleryManager {
  private let galleryProvider = GalleryProvider()
  public func getPhotoGalleries(page:Int =  1) async -> [GalleryEntity] {
    let galleryResponse =  await galleryProvider.getGalleries(page: page)
    let galleryImages = galleryResponse.data.filter({ gallery in
      if ( gallery.images_count ?? 0 ) < 3 {
        return false
      }
      let avaiableImages = gallery.images?.filter({ $0.link.contains(".png") || $0.link.contains(".jpeg") }) ?? []
      return avaiableImages.count > 0
    })
    return galleryImages
  }
  
}
