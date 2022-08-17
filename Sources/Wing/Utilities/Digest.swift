//
//  Digest.swift
//  Wing
//
//  Created by admin on 11/5/19.
//  Copyright © 2019 ZhouPengyi. All rights reserved.
//

import Foundation
import CommonCrypto.CommonDigest

public protocol DataConvertable {
    var data: Data? { get }
}

public protocol DigestProtocol {
    var MD2Data: Data? { get }
    var MD4Data: Data? { get }
    var MD5Data: Data? { get }
    var SHA1Data: Data? { get }
    var SHA224Data: Data? { get }
    var SHA256Data: Data? { get }
    var SHA384Data: Data? { get }
    var SHA512Data: Data? { get }

    var MD2: String? { get }
    var MD4: String? { get }
    var MD5: String? { get }
    var SHA1: String? { get }
    var SHA224: String? { get }
    var SHA256: String? { get }
    var SHA384: String? { get }
    var SHA512: String? { get }

}

public extension DigestProtocol where Self: DataConvertable {
    var MD2Data: Data? { get { return Digest.MD2.digestData(from: self.data) } }
    var MD4Data: Data? { get { return Digest.MD4.digestData(from: self.data) } }
    var MD5Data: Data? { get { return Digest.MD5.digestData(from: self.data) } }
    var SHA1Data: Data? { get { return Digest.SHA1.digestData(from: self.data) } }
    var SHA224Data: Data? { get { return Digest.SHA224.digestData(from: self.data) } }
    var SHA256Data: Data? { get { return Digest.SHA256.digestData(from: self.data) } }
    var SHA384Data: Data? { get { return Digest.SHA384.digestData(from: self.data) } }
    var SHA512Data: Data? { get { return Digest.SHA512.digestData(from: self.data) } }

    var MD2: String? { get { return Digest.MD2.digestString(from: self.data) } }
    var MD4: String? { get { return Digest.MD4.digestString(from: self.data) } }
    var MD5: String? { get { return Digest.MD5.digestString(from: self.data) } }
    var SHA1: String? { get { return Digest.SHA1.digestString(from: self.data) } }
    var SHA224: String? { get { return Digest.SHA224.digestString(from: self.data) } }
    var SHA256: String? { get { return Digest.SHA256.digestString(from: self.data) } }
    var SHA384: String? { get { return Digest.SHA384.digestString(from: self.data) } }
    var SHA512: String? { get { return Digest.SHA512.digestString(from: self.data) } }

}


public enum Digest {
    case MD2, MD4, MD5, SHA1, SHA224, SHA256, SHA384, SHA512
    var length: Int {
        get {
            switch self {
            case .MD2:
                return Int(CC_MD2_DIGEST_LENGTH)
            case .MD4:
                return Int(CC_MD4_DIGEST_LENGTH)
            case .MD5:
                return Int(CC_MD5_DIGEST_LENGTH)
            case .SHA1:
                return Int(CC_SHA1_DIGEST_LENGTH)
            case .SHA224:
                return Int(CC_SHA224_DIGEST_LENGTH)
            case .SHA256:
                return Int(CC_SHA256_DIGEST_LENGTH)
            case .SHA384:
                return Int(CC_SHA384_DIGEST_LENGTH)
            case .SHA512:
                return Int(CC_SHA512_DIGEST_LENGTH)
            }
        }
    }

    func digestData(from data: Data?) -> Data? {
        guard let data = data else { return nil }
        var digestData = Data(count: self.length)

        digestData.withUnsafeMutableBytes { digestBytes in
            data.withUnsafeBytes { messageBytes in
                if let messageBytesBaseAddress = messageBytes.baseAddress,
                    let digestBytesBaseAddress = digestBytes.bindMemory(to: UInt8.self).baseAddress {
                    let messageLength = CC_LONG(data.count)
                    switch self {
                    case .MD2:
                        CC_MD2(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    case .MD4:
                        CC_MD4(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    case .MD5:
                        CC_MD5(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    case .SHA1:
                        CC_SHA1(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    case .SHA224:
                        CC_SHA224(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    case .SHA256:
                        CC_SHA256(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    case .SHA384:
                        CC_SHA384(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    case .SHA512:
                        CC_SHA512(messageBytesBaseAddress, messageLength, digestBytesBaseAddress)
                    }
                }
            }
        }
        return digestData
    }

    func digestString(from data: Data?) -> String? {
        guard let digestData = self.digestData(from: data) else { return nil }
        return digestData.map {
            String(format: "%02hhx", $0)
        }.joined()
    }

}

typealias DigestAble = DigestProtocol & DataConvertable

extension Data: DigestAble {
    public var data: Data? { get { return self } }
}

extension String: DigestAble {
    public var data: Data? { get { return self.data(using: .utf8)} }
}
extension Array: DigestAble {
    public var data: Data? {
        get { return self.jsonData }
   }
}
extension Dictionary: DigestAble {
    public var data: Data? {
         get { return self.jsonData }
    }
}
