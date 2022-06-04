//
//  RestUtil.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 19/02/22.
//

import Foundation
class RestUtil {
  let baseUrl: String;
  
  init(baseUrl: String = "https://api.imgur.com/3") {
    self.baseUrl = baseUrl
  }
  
  func get<T: Decodable>(endpoint: String, headerRequests: [HeaderRequest] = [] ,queryParams: [URLQueryItem]?,  completion: @escaping (T)-> Void ) {
    
    var urlComponents = URLComponents(string: "\(baseUrl)/\(endpoint)")
    urlComponents?.queryItems = queryParams
    if let url = urlComponents?.url {
      self.createTaskAndResume(url,method: "GET" ,
                               headerRequests: headerRequests,
                               completion: completion)
    }
  }
  
  func post<T: Decodable>(endpoint: String,headerRequests: [HeaderRequest] = [], completion: @escaping (T)-> Void ) {
    let urlComponents = URLComponents(string: "\(baseUrl)/\(endpoint)")
    if let url = urlComponents?.url {
      self.createTaskAndResume(url,
                               method: "POST" ,
                               headerRequests: headerRequests,
                               completion: completion)
    }
  }
  
  private func createTaskAndResume<T: Decodable> (_ url: URL,method: String , headerRequests: [HeaderRequest] = [], completion: @escaping (T)-> Void) {
    
    var urlRequest = URLRequest(url: url)
    headerRequests.forEach { header in
      urlRequest.addValue(header.value, forHTTPHeaderField: header.headerField)
    }
    urlRequest.httpMethod = method
    let session = URLSession(configuration: .default)
    let task = session.dataTask(with: urlRequest) { data, _, error in
      if let error = error {
        // TODO ERROR
      } else if let data = data {
        let decoder = JSONDecoder()
        do {
          let dataDecoded = try decoder.decode(T.self, from: data)
          completion(dataDecoded)
        } catch {
          // Todo Error Decoder
        }
      } else {
        //TODO DATA IS NIL
      }
      
    }
    task.resume()
  }
}

