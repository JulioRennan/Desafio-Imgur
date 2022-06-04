//
//  AuthenticateView.swift
//  DesafioImgur
//
//  Created by Julio Rennan on 21/02/22.
//

import Foundation
import SwiftUI
struct AuthenticateView: View {
  @ObservedObject var authViewModel: AuthViewModel;
  @ObservedObject var webViewModel: WebViewModel;
  init(authViewModel: AuthViewModel) {
    self.authViewModel = authViewModel
    self.webViewModel = WebViewModel(url: authViewModel.urlToGetCode)
  }
  var body: some View {
    WebView(webViewModel: webViewModel) { currentUrl in
      if let url =  currentUrl {
        authViewModel.saveTokenByUrl(url: url)
      }
    }
  }
}
