//
//  UserInformationDTO.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import Foundation

struct UserInformationDTO: Codable {
    var nickname: String?
    var profileImage: ProfileImage
    var signinDate: String?
}
