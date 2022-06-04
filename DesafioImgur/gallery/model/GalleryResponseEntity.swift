//
//  GalleryEntity.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation

struct GalleryResponseEntity: Decodable {
  let data: [GalleryEntity]
  let success: Bool
  let status: Int
}

struct GalleryEntity: Decodable, Identifiable {
  let id: String;
  let title: String;
  let description: String?;
  let views: Int;
  let link: String;
  let images_count: Int?;
  let images: [ImageEntity]?;
}

struct ImageEntity: Decodable, Identifiable {
  let id: String;
  let description: String?;
  let link: String;
  let favorite: Bool;
}
