//
//  AuthManager.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation

class AuthManager {
  let storage = LocalStorage()
  
  func saveToken(authEntity: AuthEntity) {
    storage.setValue(value: authEntity, tableName: .token)
  }
  
  func getToken() -> AuthEntity? {
    return storage.getValue(.token)
  }
  
}
