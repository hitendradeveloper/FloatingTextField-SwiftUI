//
//  FocusedModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI
import UIKit
import Introspect

extension Modifiers {
	public struct Focused: ViewModifier {
		
		var configuration: Configuration
		
		weak private var textField: UITextField?
		var isFirstResponder: Bool = false
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View { content }
	}
}


extension Modifiers.Focused {
	public  class Configuration {
		var focusedColor: Color
		var id: String

		public var isFocused: Bool {
			guard let textField = UIResponder.currentFirstResponder as? UITextField else { return false }
			guard let id = textField.identifier else { return false }
			return self.id == id
		}

		public init(id: UITextField.Identifier) {
			self.focusedColor = FloatingTextFieldAppearance.shared.focusedColor
			self.id = id
		}
		
		@discardableResult
		public func focusedColor(_ focusedColor: Color) -> Self { self.focusedColor = focusedColor; return self }
	}
}



public extension View {
	@ViewBuilder
	func floatingFocused(_ configuration: Modifiers.Focused.Configuration) -> some View {
		self
			.floatingID(configuration.id)
			.modifier(Modifiers.Focused(configuration: configuration))
	}
	
	@ViewBuilder
	func floatingID(_ id: UITextField.Identifier) -> some View {
		self
			.introspectTextField { introspectedTextField in
				introspectedTextField.identifier = id
				TextFieldStore.insert(introspectedTextField, for: id)
			}
	}
}
