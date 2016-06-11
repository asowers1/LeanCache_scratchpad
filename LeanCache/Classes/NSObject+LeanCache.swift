//
//  NSObject+LeanCache.swift
//  Pods
//
//  Created by Andrew Sowers on 6/8/16.
//
//

import Foundation

public extension NSObject {
    
    func codableProperties() -> Dictionary<String, Any?> {
        var codableProperties = [String: Any?]()
        let mirrorOfSelf: _MirrorType = _reflect(self)
        let numberOfProperties = _reflect(self).count
        for i in 0..<numberOfProperties {
            if i == 0 {
                // super
                continue;
            }
            let (name,some) = mirrorOfSelf[i]
            codableProperties[name] = unwrap(some.value)
        }
        return codableProperties
    }
    
    func unwrap(any: Any) -> Any? {
        let mi:_MirrorType = _reflect(any)
        if mi.disposition != .Optional {
            return any
        }
        if mi.count == 0 { return nil } // Optional.None
        let (_,some) = mi[0]
        return some.value
    }
    
    public func decode(coder decoder: NSCoder) {
        for (key, _) in codableProperties() {
            let object: AnyObject? = decoder.decodeObjectForKey(key)
            setValue(object, forKey: key)
        }
    }
    
    public func encode(aCoder: NSCoder) {
        for (key, value) in codableProperties() {
            switch value {
            case let property as AnyObject:
                aCoder.encodeObject(property, forKey: key)
            case let property as Int:
                aCoder.encodeInt(Int32(property), forKey: key)
            case let property as Bool:
                aCoder.encodeBool(property, forKey: key)
            default:
                print("Nil value for \(key)")
            }
        }
    }
}