//
//  Cache.swift
//  LeanCache
//
//  Created by asowers1 on 05/27/2016.
//  Copyright (c) 2016 asowers1. All rights reserved.
//

import Foundation

public class Cache<T: NSCoding> {
    let memoryCache: NSCache
    let persistentCache: PersistentCache<T>

    let name: String

    public init(name: String) {
        self.name = name
        self.memoryCache = {
            let cache = NSCache()
            cache.name = name
            return cache
            }()

        self.persistentCache = PersistentCache<T>(name: "\(NSBundle.mainBundle().bundleIdentifier!).cache")
    }

    public func get() -> T? {
        if let object = self.memoryCache.objectForKey(self.name) as? T {
            return object
        } else if let object = self.persistentCache.get(self.name) {
            return object
        } else {
            return nil
        }
    }

    public func set(object: T) {
        self.memoryCache.setObject(object, forKey: self.name)
        self.persistentCache.set(object, forKey: self.name)
    }

    public func clear() {
        self.memoryCache.removeAllObjects()
        self.persistentCache.clear()
    }
}