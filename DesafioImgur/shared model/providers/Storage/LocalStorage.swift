//
//  LocalStorage.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 19/02/22.
//

import Foundation

class LocalStorage {
  enum TableNames: String { case token = "token" }
  
  func getValue<T>(_ tableName: TableNames) -> T? {
    return UserDefaults.standard.object(forKey: tableName.rawValue) as? T
  }
  
  func getValue<T: Decodable>(_ tableName: TableNames) -> T? {
    if let data =  UserDefaults.standard.object(forKey: tableName.rawValue) as? Data {
      let decoder = JSONDecoder()
      if let entity =  try? decoder.decode(T.self, from: data) {
        return entity
      }
    }
    return nil
  }
  
  func setValue<T>(value: T, tableName: TableNames) {
    UserDefaults.standard.set(value, forKey: tableName.rawValue)
  }
  
  func setValue<T: Encodable>(value: T, tableName: TableNames) {
    let enconder = JSONEncoder()
    if let entityEncoded = try? enconder.encode(value) {
      UserDefaults.standard.set(entityEncoded, forKey: tableName.rawValue)
    }
  }
}
