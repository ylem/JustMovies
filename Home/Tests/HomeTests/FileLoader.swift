//
//  FileLoader.swift
//  Common
//
//  Created by Wei Lu on 20/01/2022.
//

import Foundation
import Networking

/// Error types that FileLoader can throw
public enum FileLoaderError: Error {
    case missingFile
    case couldNotLoad
    case keyNotFound
}

public struct FileLoader {

    /// Load file from local, most use case is using in Unit Test to load local .json data files.
    /// - Parameters:
    ///   - filename: name of file
    ///   - fileExtension: the file extension, example : "json"
    ///   - bundle: Need to change to Test Bundle if using in Test target.
    ///   - decoder: default value is MyJLR decoding
    /// - Throws: An error of type FileLoaderError
    /// - Returns: returns data as decoded object.
    public static func load<T: Decodable>(_ filename: String,
                                          fileExtension: String = "json",
                                          bundle: Bundle = Bundle.main) throws -> T {
        let data: Data

        guard let file = bundle.url(forResource: filename, withExtension: fileExtension) else {
            throw FileLoaderError.missingFile
        }

        do {
            data = try Data(contentsOf: file)
        } catch {
            throw FileLoaderError.couldNotLoad
        }

        do {
            return try JSONDecoder.snakeCaseConverting.decode(T.self, from: data)
        } catch let decodingError as DecodingError {
            print("Decoding error: \(decodingError.localizedDescription)")
            throw FileLoaderError.keyNotFound
        }
    }
}
