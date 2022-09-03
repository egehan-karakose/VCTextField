//
//  SafeUnwrap.swift
//  VTextField
//
//  Created by Egehan KARAKÖSE (Dijital Kanallar Uygulama Geliştirme Müdürlüğü) on 2.09.2022.
//

import Foundation
import UIKit

postfix operator ~

public postfix func ~(_ val: Int?) -> Int {
    return safeUnwrap(val)
}

public postfix func ~(_ val: Int64?) -> Int64 {
    return safeUnwrap(val)
}

public postfix func ~(_ val: Float?) -> Float {
    return safeUnwrap(val)
}

public postfix func ~(_ val: CGFloat?) -> CGFloat {
    return safeUnwrap(val)
}

public postfix func ~(_ val: Double?) -> Double {
    return safeUnwrap(val)
}

public postfix func ~(_ val: String?) -> String {
    return safeUnwrap(val)
}

public postfix func ~(_ val: Substring?) -> Substring {
    return safeUnwrap(val)
}

public postfix func ~(_ val: Bool?) -> Bool {
    return safeUnwrap(val)
}

public postfix func ~(_ val: Date?) -> Date {
    return safeUnwrap(val)
}

public postfix func ~<T>(_ val: [T]?) -> [T] {
    return safeUnwrap(val)
}

private func safeUnwrap(_ integer: Int?, default: Int = 0) -> Int {
    return integer ?? `default`
}

private func safeUnwrap(_ integer: Int64?, default: Int64 = 0) -> Int64 {
    return integer ?? `default`
}

private func safeUnwrap(_ float: Float?, default: Float = 0) -> Float {
    return float ?? `default`
}

private func safeUnwrap(_ cgFloat: CGFloat?, default: CGFloat = 0) -> CGFloat {
    return cgFloat ?? `default`
}

private func safeUnwrap(_ double: Double?, default: Double = 0) -> Double {
    return double ?? `default`
}

private func safeUnwrap(_ string: String?, default: String = "") -> String {
    return string ?? `default`
}

private func safeUnwrap(_ string: Substring?, default: Substring = "") -> Substring {
    return string ?? `default`
}

private func safeUnwrap(_ boolean: Bool?, default: Bool = false) -> Bool {
    return boolean ?? `default`
}

private func safeUnwrap(_ date: Date?, default: Date = Date()) -> Date {
    return date ?? `default`
}

private func safeUnwrap<T>(_ array: [T]?, default: [T] = [T]()) -> [T] {
    return array ?? `default`
}

