//
//  String+Extension.swift
//  Quizzy
//
//  Created by Nikolay Budai on 03/11/23.
//

import UIKit

extension String {
    var underLined: NSAttributedString {
        NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
    }
    
    func convertHtmlSpecialCharacters() -> String {
        if let formattedString = try? NSAttributedString(data: self.data(using: .utf8)!, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil).string {
            return formattedString
        }
        return self
    }
}
