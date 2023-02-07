//
//  FloatingUnderlineFocusedModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI
import UIKit
import Introspect

extension Modifiers.FloatingFocusedUnderline {
	public  class Configuration {
		public var floatingUnderlineConfiguration: Modifiers.FloatingUnderline.Configuration
		var focusedColor: Color
		var id: String

		var isFirstResponderSelf: Bool {
			guard let textField = UIResponder.currentFirstResponder as? UITextField else { return false }
			guard let id = textField.identifier else { return false }
			return self.id == id
		}

		init(floatingUnderlineConfiguration: Modifiers.FloatingUnderline.Configuration, id: UITextField.Identifier) {
			
			self.floatingUnderlineConfiguration = floatingUnderlineConfiguration
			self.focusedColor = FloatingTextFieldConfiguration.shared.focusedColor
			self.id = id
			
			if self.isFirstResponderSelf {
				self.floatingUnderlineConfiguration.underlineColor(focusedColor)
				self.floatingUnderlineConfiguration.floatingConfiguration.floatingPlaceholderColor(focusedColor)
				self.floatingUnderlineConfiguration.floatingConfiguration.textFieldColor(focusedColor)
			}
		}
		
		public convenience init(placeHolder: String, text: Binding<String>, id: UITextField.Identifier) {
			
			let floatingConfiguation: Modifiers.Floating.Configuration = .init(placeHolder: placeHolder, text: text)
			let floatingUnderlineConfiguration: Modifiers.FloatingUnderline.Configuration = .init(floatingConfiguration: floatingConfiguation)
			
			self.init(floatingUnderlineConfiguration: floatingUnderlineConfiguration, id: id)
			
		}
		
		@discardableResult
		public func focusedColor(_ focusedColor: Color) -> Self { self.focusedColor = focusedColor; return self }
	}
}


public extension View {
	
	@ViewBuilder
	func floatingFocusedUnderline(_ configuration: Modifiers.FloatingFocusedUnderline.Configuration) -> some View {
		self
			.floatingID(configuration.id)
			.modifier(Modifiers.FloatingFocusedUnderline(configuration: configuration))
	}
	
	@ViewBuilder
	func floatingID(_ id: String) -> some View {
		self
			.introspectTextField { introspectedTextField in
				introspectedTextField.identifier = id
			}
	}
}


extension Modifiers {
	public struct FloatingFocusedUnderline: ViewModifier {
		
		var configuration: Configuration
		
		weak private var textField: UITextField?
		var isFirstResponder: Bool = false
		
		
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			content
				.floatingUnderline(configuration.floatingUnderlineConfiguration) //Underline modifier
		}
	}
}

