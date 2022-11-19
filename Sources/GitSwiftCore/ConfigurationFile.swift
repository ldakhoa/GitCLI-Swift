//
//  File.swift
//  
//
//  Created by Khoa Le on 20/11/2022.
//

import Foundation

public struct ConfigurationFile {
    public var originUrl: String?
    public var owner: String?
    public var repo: String?
    
    public init(originUrl: String? = nil, owner: String? = nil, repo: String? = nil) {
        self.originUrl = originUrl
        self.owner = owner
        self.repo = repo
    }
}
