//
//  LocalProviderHandler.swift
//  Secure Store
//
//  Created by Josseph Colonia on 3/5/20.
//  Copyright © 2020 Josseph Colonia. All rights reserved.
//

public protocol LocalProviderHandler {
    func save<T>(data: T?, key: String) -> Bool
    func update<T>(data: T?, key: String) -> Bool
    func load<T>(key: String) -> T?
    func delete(key: String) -> Bool
    subscript<T>(key: String) -> T? { get set }
}
