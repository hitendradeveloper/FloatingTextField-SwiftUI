//
//  FloatingTextFieldConfiguration.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI

public class FloatingTextFieldConfiguration {
	var textFieldFont: Font
	var textFieldColor: Color

	var floatingPlaceholderColor: Color
	var floatingPlaceholderFont: Font
	
	var underlineColor: Color
	var underlineHeight: CGFloat
	var underlinePadding: CGFloat
	
	var focusedColor: Color

	init(){
		self.textFieldFont = .system(.body)
		self.textFieldColor = Color(UIColor.label)
		self.floatingPlaceholderColor = Color(UIColor.placeholderText)
		self.floatingPlaceholderFont = .system(.caption)
		self.underlineColor = self.floatingPlaceholderColor
		self.underlineHeight = 1.0
		self.underlinePadding = 6
		self.focusedColor = Color.accentColor
	}
}

public extension FloatingTextFieldConfiguration {
	static var shared: FloatingTextFieldConfiguration = .default
	static var `default`: FloatingTextFieldConfiguration { .init() }
}

//MARK: Builder patter support with internal updates
public extension FloatingTextFieldConfiguration {
	
	@discardableResult
	func textFieldFont(_ textFieldFont: Font) -> Self { self.textFieldFont = textFieldFont; return self }
	
	@discardableResult
	func textFieldColor(_ textFieldColor: Color) -> Self { self.textFieldColor = textFieldColor; return self }
	
	@discardableResult
	func floatingPlaceholderColor(_ floatingPlaceholderColor: Color) -> Self { self.floatingPlaceholderColor = floatingPlaceholderColor; return self }
	
	@discardableResult
	func floatingPlaceholderFont(_ floatingPlaceholderFont: Font) -> Self { self.floatingPlaceholderFont = floatingPlaceholderFont; return self }
	
	@discardableResult
	func underlineColor(_ underlineColor: Color) -> Self { self.underlineColor = underlineColor; return self }
	
	@discardableResult
	func underlineHeight(_ underlineHeight: CGFloat) -> Self { self.underlineHeight = underlineHeight; return self }
	
	@discardableResult
	func underlinePadding(_ underlinePadding: CGFloat) -> Self { self.underlinePadding = underlinePadding; return self }
	
	@discardableResult
	func focusedColor(_ focusedColor: Color) -> Self { self.focusedColor = focusedColor; return self }
	
}

class TextFieldStore {
	class Weak<T: AnyObject> {
	  weak var rawValue : T?
	  init (value: T) { self.rawValue = value }
	}
	
	typealias Key = UITextField.Identifier
	
	typealias RawValue = UITextField
	typealias Value = Weak<RawValue>
	
	private static var store: TextFieldStore = TextFieldStore()
	
	private var storage: [Key: Value] = [:]
	
	static func insert(_ value: RawValue, `for` key: Key) {
		let weakStorage = Weak(value: value)
		store.storage[key] = weakStorage
	}
	
	static func value(`for` key: Key) -> RawValue? {
		let weakStorage = store.storage[key]
		return weakStorage?.rawValue
	}
}
