//
//  AuthEntity.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
struct AuthEntity: Codable {
  let access_token: String
  let refresh_token: String
  let expires_in: String
}
