//
//  Articles.swift
//  StateMachineDemo
//
//  Created by Peter Yo on Dec/30/20.
//

import Foundation

struct ArticlesResponse : Decodable {
  let articles: [Article]?
}

struct Article : Decodable {
  let source: Source?
  let author: String?
  let title: String?
  let description: String?
  let url: String?
  let urlToImage: String?
  let publishedAt: String?
  let content: String?
}

struct Source : Decodable {
  let id: String?
  let name: String?
}
