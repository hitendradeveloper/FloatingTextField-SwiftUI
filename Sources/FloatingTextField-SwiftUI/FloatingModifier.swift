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

extension Modifiers.Floating {
	public class Configuration {
		var placeHolder: String
		var text: Binding<String>
		
		var textFieldFont: Font
		var textFieldColor: Color
		var floatingPlaceholderColor: Color
		var floatingPlaceholderFont: Font
		
		var leftView: AnyView
		var rightView: AnyView
		
		public init(placeHolder: String, text: Binding<String>) {
			self.placeHolder = placeHolder
			self.text = text
			
			self.textFieldFont = FloatingTextFieldConfiguration.shared.textFieldFont
			self.textFieldColor = FloatingTextFieldConfiguration.shared.textFieldColor
			self.floatingPlaceholderColor = FloatingTextFieldConfiguration.shared.floatingPlaceholderColor
			self.floatingPlaceholderFont = FloatingTextFieldConfiguration.shared.floatingPlaceholderFont
			
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
		public func floatingPlaceholderFont(_ floatingPlaceholderFont: Font) -> Self { self.floatingPlaceholderFont = floatingPlaceholderFont; return self }
		
		
		@discardableResult
		public func leftView(_ leftView: AnyView) -> Self { self.leftView = leftView; return self }
		
		@discardableResult
		public func rightView(_ rightView: AnyView) -> Self { self.rightView = rightView; return self }
	}
}

public extension View {
	
	@ViewBuilder
	func floating(_ configuration: Modifiers.Floating.Configuration) -> some View {
		self.font(configuration.textFieldFont)
			.modifier(Modifiers.Floating(configuration: configuration))
	}
}

extension View {
	func animate(using animation: Animation = .easeInOut(duration: 1), _ action: @escaping () -> Void) -> some View {
		onAppear {
			withAnimation(animation) {
				action()
			}
		}
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
					.padding(.bottom, 2)
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
			let text = configuration.text
			let placeholder = configuration.placeHolder
			
			Group {
				if text.wrappedValue.count > 0 {
					Text(text.wrappedValue.count > 0 ? placeholder : " ")
						.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
						.animation(text.wrappedValue.count > 0 ? .easeIn : .easeOut, value: 1)
				} else {
					Text(text.wrappedValue.count > 0 ? placeholder : " ")
						.transition(.asymmetric(insertion: .move(edge: .bottom), removal: .move(edge: .top)))
						.animation(text.wrappedValue.count > 0 ? .easeIn : .easeOut, value: 1)
				}
			}
			.font(configuration.floatingPlaceholderFont)
			.foregroundColor(configuration.floatingPlaceholderColor)
			.frame(maxWidth: .infinity, alignment: .leading)
		}
	}
	
}
