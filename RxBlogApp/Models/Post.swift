//
//  Post.swift
//  RxBlogApp
//
//  Created by Emir Küçükosman on 4.12.2020.
//

import Foundation

struct Post: Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}
