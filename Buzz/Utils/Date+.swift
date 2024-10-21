//
//  Date+.swift
//  Buzz
//
//  Created by Vitor Henrique Barreiro Marinho on 21/10/24.
//

import Foundation

extension Date {
    
    func formatDate() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "pt_BR")
        formatter.dateFormat = "d 'de' MM 'de' yyyy"
        return formatter.string(from: self)
    }
}
