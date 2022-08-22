//
//  News.swift
//  NewsApp
//
//  Created by Владислав Резник on 16.08.2022.
//

import Foundation

struct Articles: Decodable {
    let articles: [ArticleResult]
}

struct ArticleResult: Decodable {
    let media: String?
    let published_date: String?
    let title: String?
    let topic: String?
    let summary: String?
}
