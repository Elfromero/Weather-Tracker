//
//  Regex+Extentions.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import Foundation

extension String {
    func matchesStrings(for regex: Regex<Substring>) -> [String] {
        let results = matches(of: regex)
        return results.map {
            String(self[$0.range])
        }
    }
}
