//
//  LoginInterfaces.swift
//  Blu
//
//  Created by Aranza Manriquez Alonso on 25/12/24.
//  Copyright (c) 2024 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit
import Alamofire

enum LoginNavigationOption {
    case goImages
}

protocol LoginWireframeInterface: WireframeInterface {
    func navigate(to option: LoginNavigationOption)
}

protocol LoginViewInterface: ViewInterface {
    func successfulLogin(user: LoginResponse)
    func failureLogin(messageError: String)
}

protocol LoginPresenterInterface: PresenterInterface {
    func performLogin(request: LoginRequest)
    func goImages()
}

protocol LoginInteractorInterface: InteractorInterface {
    func executeLogin(onSuccess successCallBack: ((_ response: LoginResponse) -> Void)?,
                      onFailure failureCallBack: ((_ errorMessage: String) -> Void)?,
                      body: LoginRequest)
}
