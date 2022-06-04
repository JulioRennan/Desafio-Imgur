//
//  AuthViewModel.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
import UIKit
class AuthViewModel: ObservableObject {
  let authManager = AuthManager()
  @Published var isLogged = false
  
  init() {
    if let entityToken = authManager.getToken() {
      isLogged = true
    }
  }
  
  var urlToGetCode: String {
    get {
      let url = "https://api.imgur.com/oauth2/authorize?client_id=%@&client_secret=%@&response_type=token"
      return String(format: url, Constants.clientId, Constants.clientSecret)
    }
  }
  
  func saveTokenByUrl(url: URL) {
    guard let urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return }
    guard let queryItems = urlComponent.queryItems else { return }
    if let accessToken =  queryItems.getItemByQueryAtributte("access_token") {
      let refreshToken = queryItems.getItemByQueryAtributte("refresh_token")
      let expiresIn = queryItems.getItemByQueryAtributte("expires_in")
      let entity = AuthEntity(access_token: accessToken.value!,
                              refresh_token: refreshToken!.value!,
                              expires_in: expiresIn!.value!)
      authManager.saveToken(authEntity: entity)
      isLogged = true
    }
  }
}

extension Array where Element == URLQueryItem {
  func getItemByQueryAtributte(_ queryAtt: String) -> URLQueryItem? {
    return self.first(where: { q in
      return q.name == queryAtt } )
  }
}
