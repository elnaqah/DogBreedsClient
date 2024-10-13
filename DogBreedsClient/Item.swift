//
//  Item.swift
//  DogBreedsClient
//
//  Created by Ahmed alnaqah on 2024-10-13.
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
