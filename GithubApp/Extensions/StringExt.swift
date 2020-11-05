//
//  StringExt.swift
//  GithubApp
//
//  Created by Lazaro Ambrosio on 11/5/20.
//  Copyright © 2020 Lazaro Ambrosio. All rights reserved.
//

import Foundation

extension String {

    func convertToDate() -> Date? {
      let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.timeZone = .current
        
        return dateFormatter.date(from: self)
    }

    
    func convertToDispalyFormat() -> String {
        guard let date = self.convertToDate() else {return "N/A"}
        return date.converToMonthYearFormat()
    }
}
