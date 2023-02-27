//
//  FloatingModifier.swift
//  FloatingTextField-SwiftUI
//
//  Created by Hitendra Solanki on 05/02/23.
//  Twitter: @hitendrahckr - Medium: @hitendrahckr
//  Copyright © 2023 by Hitendra Solanki. All rights reserved.
//

import SwiftUI
import UIKit
import Combine

extension Modifiers.Floating {
	public class Configuration {
		
		var textFieldFont: Font
		var textFieldColor: Color
		var floatingPlaceholderColor: Color
		var floatingPlaceholderBackgroundColor: Color
		var floatingPlaceholderFont: Font
		var floatingPlaceHolderPadding: CGFloat
		var floatingPlaceHolderLeadingPadding: CGFloat
		
		
		var id: UITextField.Identifier
		
		var leftView: AnyView
		var rightView: AnyView
		
		public init() {
			self.id = "______" // this will be udpate on OnFocusConfigurable.configure
			
			self.textFieldFont = FloatingTextFieldAppearance.shared.textFieldFont
			self.textFieldColor = FloatingTextFieldAppearance.shared.textFieldColor
			self.floatingPlaceholderColor = FloatingTextFieldAppearance.shared.floatingPlaceholderColor
			self.floatingPlaceholderBackgroundColor = FloatingTextFieldAppearance.shared.floatingPlaceholderBackgroundColor
			self.floatingPlaceholderFont = FloatingTextFieldAppearance.shared.floatingPlaceholderFont
			self.floatingPlaceHolderPadding = FloatingTextFieldAppearance.shared.floatingPlaceHolderPadding
			self.floatingPlaceHolderLeadingPadding = FloatingTextFieldAppearance.shared.floatingPlaceHolderLeadingPadding
			
			self.leftView = AnyView(erasing: EmptyView())
			self.rightView = AnyView(erasing: EmptyView())
		}
		
		@discardableResult
		public func textFieldFont(_ textFieldFont: Font) -> Self { self.textFieldFont = textFieldFont; return self }
		
		@discardableResult
		public func textFieldColor(_ textFieldColor: Color) -> Self { self.textFieldColor = textFieldColor; return self }
		
		
		@discardableResult
		public func floatingPlaceholderColor(_ floatingPlaceholderColor: Color) -> Self { self.floatingPlaceholderColor = floatingPlaceholderColor; return self }
		
		@discardableResult
		public func floatingPlaceholderBackgroundColor(_ floatingPlaceholderBackgroundColor: Color) -> Self { self.floatingPlaceholderBackgroundColor = floatingPlaceholderBackgroundColor; return self }
		
		@discardableResult
		public func floatingPlaceholderFont(_ floatingPlaceholderFont: Font) -> Self { self.floatingPlaceholderFont = floatingPlaceholderFont; return self }
		
		@discardableResult
		public func floatingPlaceHolderPadding(_ floatingPlaceHolderPadding: CGFloat) -> Self { self.floatingPlaceHolderPadding = floatingPlaceHolderPadding; return self }
		
		@discardableResult
		public func floatingPlaceHolderLeadingPadding(_ floatingPlaceHolderLeadingPadding: CGFloat) -> Self { self.floatingPlaceHolderLeadingPadding = floatingPlaceHolderLeadingPadding; return self }
		
		@discardableResult
		public func leftView(_ leftView: AnyView) -> Self { self.leftView = leftView; return self }
		
		@discardableResult
		public func rightView(_ rightView: AnyView) -> Self { self.rightView = rightView; return self }
	}
	
}
public extension View {
	
	@ViewBuilder
	func floating(_ configuration: Modifiers.Floating.Configuration) -> some View {
		self
			.font(configuration.textFieldFont)
			.modifier(Modifiers.Floating(configuration: configuration))
	}
}

extension Modifiers {
	
	public struct Floating: ViewModifier {
		
		var configuration: Configuration
		init(configuration: Configuration) {
			self.configuration = configuration
		}
		
		@ViewBuilder
		public func body(content: Content) -> some View {
			VStack(spacing: 0) {
				placeHolderViewIfNeeded()
					.background(configuration.floatingPlaceholderBackgroundColor)
					.padding(.bottom, configuration.floatingPlaceHolderPadding)
					.padding(.leading, configuration.floatingPlaceHolderLeadingPadding)
				HStack {
					configuration.leftView
					content
					configuration.rightView
				}
				.font(configuration.textFieldFont)
				.foregroundColor(configuration.textFieldColor)
			}
		}
		
		@ViewBuilder private func placeHolderViewIfNeeded() -> some View {
			Group {
				if let textField = TextFieldStore.value(for: self.configuration.id),
				   let text = textField.text,
				   let placeholder = textField.placeholder,
				   text.count > 0 {

					Text(placeholder)
						.transition(.move(edge: .bottom).combined(with: .opacity))
						.animation(.easeIn, value: 1)
					
				} else {
					Text(" ")
						.transition(.move(edge: .bottom).combined(with: .opacity))
						.animation(.easeOut, value: 1)
				}
			}
			.font(configuration.floatingPlaceholderFont)
			.foregroundColor(configuration.floatingPlaceholderColor)
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
}

extension Modifiers.Floating.Configuration: OnFocusChangeConfigurable {
	public func configure(focusedConfiguration: Modifiers.Focused.Configuration) -> Self {
		self.id = focusedConfiguration.id
		if focusedConfiguration.isFocused {
			self.textFieldColor = focusedConfiguration.focusedColor
			self.floatingPlaceholderColor = focusedConfiguration.focusedColor
		}
		return self
	}
}
