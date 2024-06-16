//
//  ProfileImage.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/14/24.
//

import Foundation

enum ProfileImage: Int, CaseIterable, Codable {
    case profile_0 = 0 
    case profile_1
    case profile_2
    case profile_3
    case profile_4
    case profile_5
    case profile_6
    case profile_7
    case profile_8
    case profile_9
    case profile_10
    case profile_11
    
    var imageName: String {
        return String(describing: self)
    }
}
