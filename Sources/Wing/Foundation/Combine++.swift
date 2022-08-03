//
//  Combine+FK.swift
//  FengKao
//
//  Created by 周朋毅 on 2022/1/21.
//

import Foundation
import Combine


//MARK: fix encode decode @Published property issue
extension Published: Decodable where Value: Decodable
{
    public init(from decoder: Decoder) throws
    {
        self.init(initialValue: try .init(from: decoder))
    }
}


extension Published: Encodable where Value: Encodable
{
    public func encode(to encoder: Encoder) throws {
        guard
            let storageValue = Mirror(reflecting: self).descendant("storage").map(Mirror.init)?.children.first?.value,
            let value = storageValue as? Value ?? (storageValue as? Publisher).map(Mirror.init)?.descendant("subject", "currentValue")as? Value
        else { throw EncodingError.invalidValue(self, codingPath: encoder.codingPath) }
        
        try value.encode(to: encoder)
    }
}


public extension EncodingError
{
    /// `invalidValue` without having to pass a `Context` as an argument.
    static func invalidValue(_ value: Any, codingPath: [CodingKey], debugDescription: String = .init()) -> Self
    {
        .invalidValue(value, .init(codingPath: codingPath, debugDescription: debugDescription) )
    }
}

