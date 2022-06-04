//
//  WebViewModel.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
class WebViewModel: ObservableObject {
  @Published var isLoading: Bool = false
  @Published var canGoBack: Bool = false
  @Published var shouldGoBack: Bool = false
  @Published var title: String = ""
  
  var url: String
  
  init(url: String) {
    self.url = url
  }
}
