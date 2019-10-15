//
//  MainViewModel.swift
//  secondAttemptTest
//
//  Created by Bruno Augusto Constantino on 9/30/19.
//  Copyright © 2019 Bruno Augusto Constantino. All rights reserved.
//

import Foundation

struct LinkAliasType: Codable {
    let alias: String
    let _links: URLShortener
}

struct URLShortener: Codable {
    let `self`: String
    let short: String
}
