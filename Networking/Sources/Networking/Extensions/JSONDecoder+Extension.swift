//
//  File.swift
//  
//
//  Created by Wei Lu on 16/03/2022.
//

import Foundation

public extension JSONDecoder {
    static let snakeCaseConverting: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
}

public extension JSONEncoder {
    static let snakeCaseConverting: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
}

