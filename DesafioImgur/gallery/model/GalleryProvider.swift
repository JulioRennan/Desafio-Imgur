//
//  GalleryProvider.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
class GalleryProvider  {
  private let restUtils = RestUtil()
  
  public func getGalleries(page:Int = 1) async -> GalleryResponseEntity {
   return await withCheckedContinuation({ continuation in
     self.restUtils.get(endpoint: "/gallery/hot",
                        headerRequests: [
                          HeaderRequest(headerField: "Authorization", value: "Client-ID \(Constants.clientId)")
                        ],
                        queryParams: [
                          URLQueryItem(name: "page", value:  String(page))
                        ]) { continuation.resume(returning: $0) }
    })
  }
}
