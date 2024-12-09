//
//  IconURLBuilder.swift
//  Weather Tracker
//
//  Created by Roman Radchuk on 12/8/24.
//

import Foundation

class IconURLBuilder {
    enum Size: String {
        case regular = "64x64"
        case large = "128x128"
    }
    
    private static let sizeRegex = /[0-9]{1,3}x[0-9]{1,3}/
    private let path: String
    private var size: Size
    init(path: String) throws(IconURLBuilderError) {
        self.path = path
        guard let sizeMatch = path.matchesStrings(for: Self.sizeRegex).first,
              let size = Size(rawValue: sizeMatch)
        else {
            throw .unrecognixedIconSize
        }
        self.size = size
    }
    
    func size(_ size: Size) -> Self {
        self.size = size
        return self
    }
    
    func build() -> URL? {
        return URL(string: "https:" + path.replacing(Self.sizeRegex, with: size.rawValue))
    }
}

enum IconURLBuilderError: Error {
    case unrecognixedIconSize
}
