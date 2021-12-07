//
//  UserDefaultHandler.swift
//  SecureStore
//
//  Created by Josseph Colonia on 2/24/20.
//

import Foundation

public struct UserDefaultsHandler: LocalProviderHandler {
    
    // MARK: - Properties
    
    private let service = "appgate.secure.store"
    private let userDefault: UserDefaults?
    
    public init() {
        userDefault = UserDefaults(suiteName: service)
    }
    
    @discardableResult
    public func save<T>(data: T?, key: String) -> Bool {
        guard let data = data else { return false }
        userDefault?.setValue(data, forKey: key)
        return true
    }
    
    @discardableResult
    public func update<T>(data: T?, key: String) -> Bool {
        guard let data = data else { return false }
        userDefault?.setValue(data, forKey: key)
        return true
    }
    
    public func load<T>(key: String) -> T? {
        return userDefault?.object(forKey: key) as? T
    }
    
    @discardableResult
    public func delete(key: String) -> Bool {
        userDefault?.removeObject(forKey: key)
        return true
    }
    
    public subscript<T>(key: String) -> T? {
        get {
            return load(key: key)
        }
        set {
            _ = save(data: newValue, key: key)
        }
    }
}
