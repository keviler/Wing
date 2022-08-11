//
//  WSectional.swift
//  
//
//  Created by 周朋毅 on 2022/8/10.
//

import Foundation

public protocol WSectional {
    associatedtype SectionKey
    associatedtype Items
    var key: SectionKey { get }
    var items: Items { get }
}

public struct WSection<Items>: WSectional {
    public var key: UUID {UUID()}
    public var items: Items
    public init(items: Items) {
        self.items = items
    }
}
