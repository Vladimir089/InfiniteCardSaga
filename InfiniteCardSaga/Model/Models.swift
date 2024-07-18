//
//  Models.swift
//  InfiniteCardSaga
//
//  Created by Владимир Кацап on 18.07.2024.
//

import Foundation


struct Post: Codable {
    var title: String
    var text: String
    var date: Date
    
    init(title: String, text: String, date: Date) {
        self.title = title
        self.text = text
        self.date = date
    }
}
