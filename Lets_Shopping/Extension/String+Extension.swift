//
//  String+Extension.swift
//  Lets_Shopping
//
//  Created by 김수경 on 6/18/24.
//

import Foundation

extension String {
    
    var removeHtmlTag: String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
    
}
