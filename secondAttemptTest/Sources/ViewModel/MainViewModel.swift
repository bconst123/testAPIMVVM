//
//  MainViewModel.swift
//  secondAttemptTest
//
//  Created by Bruno Augusto Constantino on 9/30/19.
//  Copyright © 2019 Bruno Augusto Constantino. All rights reserved.
//

struct UrlAliasViewModel {
    private(set) var link: String
    private(set) var alias: String
    private(set) var short: String
    init(link:String, alias: String, short: String) {
        self.link = link
        self.alias = alias
        self.short = short
    }
}
