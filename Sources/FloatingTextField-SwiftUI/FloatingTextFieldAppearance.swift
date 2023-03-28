//
//  FloatingTextFieldAppearance.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI

public final class FloatingTextFieldAppearance {
	var textFieldFont: Font
	var textFieldColor: Color

	var floatingPlaceholderColor: Color
	var floatingPlaceholderBackgroundColor: Color
	var floatingPlaceholderFont: Font
	
	var floatingPlaceHolderPadding: CGFloat
	var floatingPlaceHolderLeadingPadding: CGFloat
	
	var underlineColor: Color
	var underlineHeight: CGFloat
	var underlinePadding: CGFloat
	
	var borderColor: Color
	var borderWidth: CGFloat
	var borderPadding: CGFloat
	
	var focusedColor: Color
	
	var allowsFloatingPlaceholder: Bool

	init(){
		self.textFieldFont = .system(.body)
		self.textFieldColor = Color(UIColor.label)
		self.floatingPlaceholderColor = Color(UIColor.placeholderText)
		self.floatingPlaceholderBackgroundColor = Color(UIColor.clear)

		self.floatingPlaceholderFont = .system(.caption)
		self.floatingPlaceHolderPadding = 0
		self.floatingPlaceHolderLeadingPadding = 0
		
		self.underlineColor = self.floatingPlaceholderColor
		self.underlineHeight = 1.0
		self.underlinePadding = 4
		
		self.borderColor = self.floatingPlaceholderColor
		self.borderWidth = 1.0
		self.borderPadding = 10
		
		self.focusedColor = Color.accentColor
		
		self.allowsFloatingPlaceholder = true
	}
}

public extension FloatingTextFieldAppearance {
	static var shared: FloatingTextFieldAppearance = .default
	static var `default`: FloatingTextFieldAppearance { .init() }
}

//MARK: Builder patter support with internal updates
public extension FloatingTextFieldAppearance {
	
	@discardableResult
	func textFieldFont(_ textFieldFont: Font) -> Self { self.textFieldFont = textFieldFont; return self }
	
	@discardableResult
	func textFieldColor(_ textFieldColor: Color) -> Self { self.textFieldColor = textFieldColor; return self }
	
	@discardableResult
	func floatingPlaceholderColor(_ floatingPlaceholderColor: Color) -> Self { self.floatingPlaceholderColor = floatingPlaceholderColor; return self }
	
	@discardableResult
	func floatingPlaceholderBackgroundColor(_ floatingPlaceholderBackgroundColor: Color) -> Self { self.floatingPlaceholderBackgroundColor = floatingPlaceholderBackgroundColor; return self }
	
	@discardableResult
	func floatingPlaceholderFont(_ floatingPlaceholderFont: Font) -> Self { self.floatingPlaceholderFont = floatingPlaceholderFont; return self }
	
	@discardableResult
	func floatingPlaceHolderPadding(_ floatingPlaceHolderPadding: CGFloat) -> Self { self.floatingPlaceHolderPadding = floatingPlaceHolderPadding; return self }
	
	@discardableResult
	func floatingPlaceHolderLeadingPadding(_ floatingPlaceHolderLeadingPadding: CGFloat) -> Self { self.floatingPlaceHolderLeadingPadding = floatingPlaceHolderLeadingPadding; return self }
	
	@discardableResult
	func underlineColor(_ underlineColor: Color) -> Self { self.underlineColor = underlineColor; return self }
	
	@discardableResult
	func underlineHeight(_ underlineHeight: CGFloat) -> Self { self.underlineHeight = underlineHeight; return self }
	
	@discardableResult
	func underlinePadding(_ underlinePadding: CGFloat) -> Self { self.underlinePadding = underlinePadding; return self }
	
	@discardableResult
	func borderColor(_ borderColor: Color) -> Self { self.borderColor = borderColor; return self }
	
	@discardableResult
	func borderWidth(_ borderWidth: CGFloat) -> Self { self.borderWidth = borderWidth; return self }
	
	@discardableResult
	func borderPadding(_ borderPadding: CGFloat) -> Self { self.borderPadding = borderPadding; return self }
	
	
	@discardableResult
	func focusedColor(_ focusedColor: Color) -> Self { self.focusedColor = focusedColor; return self }
	
	@discardableResult
	func allowsFloatingPlaceholder(_ allowsFloatingPlaceholder: Bool) -> Self { self.allowsFloatingPlaceholder = allowsFloatingPlaceholder; return self }
}

internal final class TextFieldStore {
	internal final class Weak<T: AnyObject> {
	  weak var rawValue : T?
	  init (value: T) { self.rawValue = value }
	}
	
	internal typealias Key = UITextField.Identifier
	
	internal typealias RawValue = UITextField
	internal typealias Value = Weak<RawValue>
	
	private static var store: TextFieldStore = TextFieldStore()
	
	private var storage: [Key: Value] = [:]
	
	internal static func insert(_ value: RawValue, `for` key: Key) {
		let weakStorage = Weak(value: value)
		store.storage[key] = weakStorage
	}
	
	internal static func value(`for` key: Key) -> RawValue? {
		let weakStorage = store.storage[key]
		return weakStorage?.rawValue
	}
}
