//
//  ViewInterface.swift
//  Blu
//
//  Created by Aranza Manriquez Alonso on 25/12/24.
//

protocol ViewInterface: AnyObject {
    func showProgressHUD()
    func hideProgressHUD()
}

extension ViewInterface {
    func showProgressHUD() {}
        
    func hideProgressHUD() {}
    
}

