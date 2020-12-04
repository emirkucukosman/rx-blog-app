//
//  BaseError.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import Foundation

struct BaseError: Error {
    var errorDescription: String?
    
    init(_ description: String) {
        errorDescription = description
    }
}
