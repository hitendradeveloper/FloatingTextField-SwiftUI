//
//  View+FloatingModifiers.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//


public enum Modifiers {}

public protocol OnFocusChangeConfigurable: AnyObject {
	func configure(focusedConfiguration: Modifiers.Focused.Configuration) -> Self
}
