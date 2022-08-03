//
//  FileManager+Extensions.swift
//  Wing
//
//  Created by admin on 11/22/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation

public extension FileManager {

    func fileSize(of directory: String) -> Int64 {
        return (self.fileAttribute(.size, of: directory) as? NSNumber)?.int64Value ?? 0
    }

    func fileAttribute(_ attribute: FileAttributeKey, of directory: String) -> Any? {
        guard self.fileExists(atPath: directory) else {
            return nil
        }
        do {
            let fileAttributes = try FileManager.default.attributesOfItem(atPath: directory)
            return fileAttributes[attribute]
        } catch {
            return nil
        }
    }

    func saveFile(_ file: Codable, name: String, extension: String? = nil, at path: String) throws {

    }
}
