//
//  NickNameTextFieldDelegate.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/15/24.
//

import Foundation

protocol NickNameTextFieldDelegate: AnyObject {
    func validateTextField(_ nickname: String?) -> String
}
