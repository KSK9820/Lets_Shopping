//
//  NickNameErrorMessage.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/15/24.
//

import Foundation

enum NickNameMessage: CustomStringConvertible, Equatable {
    case inputError
    case lengthError
    case specialCharacterError([String])
    case numberError
    case validNickName
    
    var description: String {
        switch self {
        case . inputError:
            ""
        case .lengthError:
            "2글자 이상 10글자 미만으로 설정해주세요"
        case .specialCharacterError(let special):
            "닉네임에 \(special.sorted().joined(separator: ", ")) 는 포함할 수 없어요"
        case .numberError:
            "닉네임에 숫자는 포함할 수 없어요"
        case .validNickName:
            "사용할 수 있는 닉네임이에요"
        }
    }
}
