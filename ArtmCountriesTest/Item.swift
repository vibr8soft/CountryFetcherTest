//
//  Item.swift
//  ArtmCountriesTest
//
//  Created by Olivier Lavoie on 2025-02-01.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
