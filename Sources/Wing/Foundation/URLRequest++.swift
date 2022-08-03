//
//  Request.swift
//  Wing
//
//  Created by admin on 11/5/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

/*
 Request releated extensions
 */
import Foundation

extension URLRequest {
    init?(string: String) {
        guard let url = URL(string: string) else {
            return nil
        }
        self.init(url: url)
    }
}
